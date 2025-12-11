require "./../modules/*"
require "./../interfaces/generator_interface"
require "./../helpers/initialize"

# A class that generates a struct.
# ```
# method_type = CGT::Method.new("full_name", "String")
# method_type.add_body("John Doe".dump)
# struct_type = CGT::Struct.new("Point")
# struct_type.add_method(method_type)
# puts struct_type.generate
# ```
#
# Output:
# ```
# struct Point
#   def full_name : String
#     "John Doe"
#   end
# end
# ```
class Crygen::Types::Struct < Crygen::Interfaces::GeneratorInterface
  include Crygen::Modules::Comment
  include Crygen::Modules::Property
  include Crygen::Modules::InstanceVar
  include Crygen::Modules::ClassVar
  include Crygen::Modules::Method
  include Crygen::Modules::Annotation
  include Crygen::Modules::Mixin

  include Crygen::Helpers::Initialize

  # Used for adding nested structs.
  include Crygen::Modules::Struct

  protected getter name : String
  protected getter inherited_abstract_struct_name : String?

  def initialize(@name : String, @inherited_abstract_struct_name : String? = nil); end

  # Equality. Returns `true` if each value in `self` is equal to each
  # corresponding value in *other*.
  def ==(other : Crygen::Types::Struct) : Bool
    {% begin %}
      equalities = [] of Bool
      {% for instance_var in @type.instance_vars.map(&.name) %}
      equalities << (@{{ instance_var }} == other.{{ instance_var }})
      {% end %}
      equalities.all?
    {% end %}
  end

  # Generates a struct.
  def generate : String
    String.build do |str|
      @comments.each do |line|
        str << Crygen::Utils::Indentation.generate << "# " << line << "\n"
      end

      str << CGG::Annotation.generate(@annotations)

      str << Crygen::Utils::Indentation.generate
      str << "struct " << @name
      str << " < " << @inherited_abstract_struct_name if @inherited_abstract_struct_name
      str << "\n"

      Crygen::Utils::Indentation.add_indent

      generators = [generate_mixins, generate_properties, generate_instance_vars, generate_class_vars]

      generators.each_with_index do |step, index|
        if index > 0
          previous_step = generators[index - 1]

          if previous_step != "" && step != ""
            str << "\n"
          end
        end

        str << step
      end

      is_top_level_empty = [@includes, @extends, @instance_vars, @class_vars, @properties].any?(&.empty?.!)

      if is_top_level_empty && !@methods.empty?
        str << "\n"
      end

      @methods.each_with_index do |method, index|
        if index != 0
          str << "\n"
        end

        str << method << "\n"
      end

      if (is_top_level_empty || !@methods.empty?) && !@structs.empty?
        str << "\n"
      end

      @structs.each_with_index do |the_struct, index|
        if index != 0
          Crygen::Utils::Indentation.reset
          str << Crygen::Utils::Indentation.add_indent << "\n"
          Crygen::Utils::Indentation.restore
        end

        str << the_struct << "\n"
      end

      Crygen::Utils::Indentation.remove_indent

      str << Crygen::Utils::Indentation.generate << "end"
    end
  end

  # :ditto:
  def to_s(io : IO) : Nil
    io << self.generate
  end
end
