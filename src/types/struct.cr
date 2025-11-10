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

  def initialize(@name : String, @inherited_abstract_struct_name : String? = nil); end

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

      [generate_mixins, generate_properties, generate_instance_vars, generate_class_vars].each do |step|
        str << step
      end

      if !@includes.empty? || !@extends.empty? || !@instance_vars.empty? || !@class_vars.empty? || !@properties.empty?
        if !@methods.empty?
          str << "\n"
        end
      end

      @methods.each_with_index do |method, index|
        str << "\n" if index != 0
        str << method << "\n"
      end

      if !@methods.empty? && !@structs.empty?
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

      str << Crygen::Utils::Indentation.generate
      str << "end"
    end
  end

  # :ditto:
  def to_s(io : IO) : Nil
    io << self.generate
  end
end
