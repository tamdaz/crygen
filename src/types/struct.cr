require "./../modules/*"
require "./../interfaces/generator_interface"

# A class that generates a struct.
# ```
# method_type = CGT::Method.new("full_name", "String")
# method_type.add_body("John Doe".dump)
# struct_type = test_point_struct()
# struct_type.add_method(method_type)
# puts struct_type.generate
# ```
# Output:
# ```
# # This is a struct called Point.
# struct Point
#   def full_name : String
#     "John Doe"
#   end
# end
# ```
class Crygen::Types::Struct < Crygen::Abstract::GeneratorInterface
  include Crygen::Modules::Comment
  include Crygen::Modules::Property
  include Crygen::Modules::InstanceVar
  include Crygen::Modules::ClassVar
  include Crygen::Modules::Method
  include Crygen::Modules::Annotation
  include Crygen::Modules::Mixin

  def initialize(@name : String); end

  # Generates a struct.
  def generate : String
    String.build do |str|
      line_proc = ->(line : String) { str << "  " + line + "\n" }

      @comments.each { |comment| str << "# " << comment << "\n" }
      @annotations.each { |annotation_type| str << annotation_type.generate + "\n" }
      str << "struct " << @name << "\n"
      generate_mixins.each_line(&line_proc)
      generate_properties.each_line(&line_proc)
      generate_instance_vars.each_line(&line_proc)
      generate_class_vars.each_line(&line_proc)

      can_add_whitespace = false
      @methods.each do |method|
        str << "\n" if can_add_whitespace == true
        str << method.generate.each_line(&line_proc)
        if can_add_whitespace == false
          can_add_whitespace = true
        end
      end
      str << "end"
    end
  end
end
