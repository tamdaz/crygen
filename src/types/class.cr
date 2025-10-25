require "./../interfaces/generator_interface"
require "./../modules/*"

# A class that generates a class.
# ```
# class_person = CGT::Class.new("Person")
# class_person.add_comment("This is a class called Person.")
# class_person.add_method(method_full_name)
# puts class_person.generate
# ```
#
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

  # Used for adding nested classes.
  include Crygen::Modules::Class

  @type : Symbol = :normal

  def initialize(@name : String, @inherited_class_name : String? = nil); end

  # Set as an abstract class.
  # ```
  # class_type = CGT::Class.new("Person")
  # class_type.as_abstract
  # ```
  #
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
      str << "class " << @name
      str << " < " << @inherited_class_name if @inherited_class_name
      str << "\n"

      [generate_mixins, generate_properties, generate_instance_vars, generate_class_vars].each do |step|
        step.each_line(&line_proc)
      end

      whitespace = false

      grouped_methods = @methods.group_by(&.type)

      if grouped_methods[:abstract]?
        generate_abstract_methods(str, grouped_methods[:abstract], whitespace)
        str << "\n" if grouped_methods[:normal]?
      end

      if grouped_methods[:normal]?
        generate_normal_methods(str, grouped_methods[:normal], whitespace)
      end

      str << "end"
    end
  end

  # Generate a class thanks to #to_s method.
  def to_s(io : IO) : Nil
    io << self.generate
  end
end
