require "./../modules/arg"
require "./../interfaces/generator"

# A class that allows to generate an annotation.
# ```
# class_type = test_person_class()
# class_type.add_annotation(CGT::Annotation.new("Experimental"))
# puts class_type.generate
# ```
# Output :
# ```
# @[Experimental]
# class Person
# end
# ```
class Crygen::Types::Annotation < Crygen::Abstract::GeneratorInterface
  # Tuple => {name, value}
  @args = [] of Tuple(String | Nil, String)

  # When instantiating the `Crygen::Types::Annotation` class,
  # only the name must be passed as a parameter.
  def initialize(@name : String); end

  # Adds only a value into the argument.
  # ```
  # annotation_type = Crygen::Types::Annotation.new("MyAnnotation")
  # annotation_type.add_arg("true")
  # ```
  # Output :
  # ```
  # @[MyAnnotation(true)]
  # ```
  def add_arg(value : String) : Nil
    @args << {nil, value}
  end

  # Adds a name and value into the argument.
  # ```
  # annotation_type = Crygen::Types::Annotation.new("MyAnnotation")
  # annotation_type.add_arg("name", "John Doe".dump)
  # ```
  # Output :
  # ```
  # @[MyAnnotation(name: "John Doe")]
  # ```
  def add_arg(name : String, value : String) : Nil
    @args << {name, value}
  end

  # Generates an annotation.
  def generate : String
    String.build do |str|
      str << "@[#{@name}"
      str << generate_args unless @args.empty?
      str << "]"
    end
  end

  # Generates args for an annotation.
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
