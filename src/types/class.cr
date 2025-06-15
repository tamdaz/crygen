require "./../modules/*"
require "./../interfaces/generator_interface"

# A class that generates a class.
# ```
# class_person = CGT::Class.new("Person")
# class_person.add_comment("This is a class called Person.")
# class_person.add_method(method_full_name)
# puts class_person.generate
# ```
# Output:
# ```
# # This is a class called Person.
# class Person
#   # Gets the person's full name.
#   def full_name : String
#     "John Doe"
#   end
# end
# ```
class Crygen::Types::Class < Crygen::Interfaces::GeneratorInterface
  include Crygen::Modules::Comment
  include Crygen::Modules::Property
  include Crygen::Modules::InstanceVar
  include Crygen::Modules::ClassVar
  include Crygen::Modules::Method
  include Crygen::Modules::Annotation
  include Crygen::Modules::Mixin

  @type : Symbol = :normal

  def initialize(@name : String); end

  # Set as an abstract class.
  # ```
  # class_type = CGT::Class.new("Person")
  # class_type.as_abstract
  # ```
  # Output:
  # ```
  # abstract class Person
  # end
  # ```
  def as_abstract : self
    @type = :abstract
    self
  end

  # Generates a Crystal code.
  def generate : String
    String.build do |str|
      line_proc = ->(line : String) { str << "  " + line + "\n" }

      str << CGG::Comment.generate(@comments)
      str << CGG::Annotation.generate(@annotations)

      str << "abstract " if @type == :abstract
      str << "class "
      str << @name << "\n"

      [generate_mixins, generate_properties, generate_instance_vars, generate_class_vars].each do |step|
        step.each_line(&line_proc)
      end

      can_add_whitespace = false

      @methods.each do |method|
        str << "\n" if can_add_whitespace == true

        case @type
        when :normal   then str << method.generate.each_line(&line_proc)
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
