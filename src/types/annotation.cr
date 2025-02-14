require "./../modules/arg"
require "./../interfaces/generator_interface"

# A class that allows to generate an annotation.
# ```
# class_type = CGT::Class.new("Person")
# class_type.add_annotation(CGT::Annotation.new("Experimental"))
# puts class_type.generate
# ```
# Output:
# ```
# @[Experimental]
# class Person
# end
# ```
class Crygen::Types::Annotation < Crygen::Abstract::GeneratorInterface
  @args = [] of Tuple(String | Nil, String)

  def initialize(@name : String); end

  # Adds only a value into the argument.
  # ```
  # annotation_type = Crygen::Types::Annotation.new("MyAnnotation")
  # annotation_type.add_arg("true")
  # ```
  # Output:
  # ```
  # @[MyAnnotation(true)]
  # ```
  # Returns:
  # an object class itself.
  def add_arg(value : String) : self
    @args << {nil, value}
    self
  end

  # Adds a name and value into the argument.
  # ```
  # annotation_type = Crygen::Types::Annotation.new("MyAnnotation")
  # annotation_type.add_arg("full_name", "John Doe".dump)
  # ```
  # Output:
  # ```
  # @[MyAnnotation(full_name: "John Doe")]
  # ```
  # Returns:
  # an object class itself.
  def add_arg(name : String, value : String) : self
    @args << {name, value}
    self
  end

  # Generates an annotation.
  # Returns: String
  def generate : String
    String.build do |str|
      str << "@[#{@name}"
      str << generate_args unless @args.empty?
      str << "]"
    end
  end

  # Generates args for an annotation.
  # Returns: String
  private def generate_args : String
    String.build do |str|
      str << '(' unless @args.empty?
      @args.each_with_index do |arg, i|
        if arg[0].nil?
          str << arg[1]
        else
          str << "#{arg[0]}: #{arg[1]}"
        end
        str << ", " if i != @args.size - 1
      end
      str << ')' unless @args.empty?
    end
  end
end
