require "./../modules/*"
require "./../interfaces/generator"

# A class that generates a struct.
# ```
# method_type = CGT::Method.new("full_name", "String")
# method_type.add_body("John Doe".dump)
# struct_type = test_point_struct()
# struct_type.add_method(method_type)
# puts struct_type.generate
# ```
# Output :
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

  # When instantiating the `Crygen::Types::Struct` class,
  # only the name needs to be entered in the constructor.
  def initialize(@name : String)
    @annotations = [] of Crygen::Types::Annotation
  end

  # Adds an annotation onto a class.
  # ```
  # struct_type = CGT::Struct.new("Point")
  # struct_type.add_annotation(CGT::Annotation.new("Experimental"))
  # ```
  def add_annotation(annotation_type : Crygen::Types::Annotation) : Nil
    @annotations << annotation_type
  end

  # Generates a struct.
  def generate : String
    String.build do |str|
      @comments.each { |comment| str << "# #{comment}\n" }
      @annotations.each { |annotation_type| str << annotation_type.generate + "\n" }
      str << "struct #{@name}\n"
      generate_properties.each_line { |line| str << "  " + line + "\n" }
      generate_instance_vars.each_line { |line| str << "  " + line + "\n" }
      generate_class_vars.each_line { |line| str << "  " + line + "\n" }
      can_add_whitespace = false
      @methods.each do |method|
        str << "\n" if can_add_whitespace == true
        str << method.generate.each_line { |line| str << "  " + line + "\n" }
        if can_add_whitespace == false
          can_add_whitespace = true
        end
      end
      str << "end"
    end
  end
end
