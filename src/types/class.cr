require "./../modules/*"
require "./../interfaces/generator"

# A class that generates a class.
# ```
# class_person = CGT::Class.new("Person")
# class_person.add_comment("This is a class called Person.")
# class_person.add_method(method_full_name)
# puts class_person.generate
# ```
# Output :
# ```
# # This is a class called Person.
# class Person
#   # Gets the person's full name.
#   def full_name : String
#     "John Doe"
#   end
# end
# ```
class Crygen::Types::Class < Crygen::Abstract::GeneratorInterface
  include Crygen::Modules::Comment
  include Crygen::Modules::Property
  include Crygen::Modules::InstanceVar
  include Crygen::Modules::ClassVar
  include Crygen::Modules::Method

  @type : Symbol = :normal

  # When instantiating the `Crygen::Types::Class` class, only the name must
  # be passed as a parameter.
  def initialize(@name : String)
    @annotations = [] of Crygen::Types::Annotation
  end

  # Adds annotation(s) on a class.
  # ```
  # class_type = CGT::Class.new("Person")
  # class_type.add_annotation(CGT::Annotation.new("Experimental"))
  # class_type.add_annotation(CGT::Annotation.new("AnotherAnnotation"))
  # ```
  def add_annotation(annotation_type : Crygen::Types::Annotation) : Nil
    @annotations << annotation_type
  end

  # Set as an abstract class.
  # ```
  # class_type = CGT::Class.new("Person")
  # class_type.as_abstract
  # ```
  def as_abstract : Nil
    @type = :abstract
  end

  # Generates a Crystal code.
  def generate : String
    String.build do |str|
      @comments.each { |comment| str << "# #{comment}\n" }
      @annotations.each { |annotation_type| str << annotation_type.generate + "\n" }
      str << if @type == :abstract
        "abstract class #{@name}\n"
      else
        "class #{@name}\n"
      end
      generate_properties.each_line { |line| str << "  " + line + "\n" }
      generate_instance_vars.each_line { |line| str << "  " + line + "\n" }
      generate_class_vars.each_line { |line| str << "  " + line + "\n" }
      can_add_whitespace = false
      @methods.each do |method|
        str << "\n" if can_add_whitespace == true
        case @type
        when :normal   then str << method.generate.each_line { |line| str << "  " + line + "\n" }
        when :abstract then str << method.generate_abstract_method
        end
        if can_add_whitespace == false && @type == :normal
          can_add_whitespace = true
        end
      end
      str << "end"
    end
  end
end
