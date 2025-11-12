require "./../modules/arg"
require "./../interfaces/generator_interface"

# A class that allows to generate an annotation.
# ```
# class_type = CGT::Class.new("Person")
# class_type.add_annotation(CGT::Annotation.new("Experimental"))
# puts class_type.generate
# ```
#
# Output:
# ```
# @[Experimental]
# class Person
# end
# ```
class Crygen::Types::Annotation < Crygen::Interfaces::GeneratorInterface
  @args = [] of Tuple(String?, String)

  def initialize(@name : String); end

  # Adds only a value into the argument.
  # ```
  # annotation_type = Crygen::Types::Annotation.new("MyAnnotation")
  # annotation_type.add_arg("true")
  # ```
  #
  # Output:
  # ```
  # @[MyAnnotation(true)]
  # ```
  def add_arg(value : String) : self
    @args << {nil, value}
    self
  end

  # Add several values into the argument.
  # ```
  # my_annotation = Crygen::Types::Annotation.new("MyAnnotation")
  # my_annotation.add_args("1", "2.73", "true", "Hello world".dump)
  # ```
  #
  # Output:
  # ```
  # @[MyAnnotation(1, 2.73, true, "Hello world")]
  # ```
  def add_args(*values : String) : self
    values.each { |value| self.add_arg(value) }
    self
  end

  # Adds a name and value into the argument.
  # ```
  # annotation_type = Crygen::Types::Annotation.new("MyAnnotation")
  # annotation_type.add_arg("full_name", "John Doe".dump)
  # ```
  #
  # Output:
  # ```
  # @[MyAnnotation(full_name: "John Doe")]
  # ```
  def add_arg(name : String, value : String) : self
    @args << {name, value}
    self
  end

  # Generates an annotation.
  def generate : String
    String.build do |str|
      str << "@[" << @name

      unless @args.empty?
        str << generate_args
      end

      str << "]"
    end
  end

  # Generates args for an annotation.
  private def generate_args : String
    String.build do |str|
      str << '(' unless @args.empty?

      @args.each_with_index do |arg, index|
        name, value = arg

        str << name << ": " unless name.nil?
        str << value
        str << ", " if index != @args.size - 1
      end

      str << ')' unless @args.empty?
    end
  end

  # :ditto:
  def to_s(io : IO) : Nil
    io << self.generate
  end
end
