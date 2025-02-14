require "./../interfaces/generator"
require "./../modules/arg"

# A class that generates a macro
# ```
# macro_type = CGT::Macro.new("example")
# macro_type.add_arg("name")
# puts macro_type.generate
# ```
# Output:
# ```
# macro example(name)
#   puts {{ name }}
# end
# ```
class Crygen::Types::Macro < Crygen::Abstract::GeneratorInterface
  @args = [] of String
  @body = ""

  def initialize(@name : String); end

  # Adds an argument to the macro.
  # ```
  # macro_type = CGT::Macro.new("example")
  # macro_type.add_arg("name")
  # ```
  # Output:
  # ```
  # macro example(name)
  # end
  # ```
  # Parameters:
  # - arg : String
  # Returns:
  # an object class itself.
  def add_arg(arg : String) : self
    @args << arg
    self
  end

  # Adds a new line into the macro body.
  # ```
  # macro_type = CGT::Macro.new("example")
  # macro_type.add_arg("name")
  # macro_type.add_body("puts {{ name }}")
  # ```
  # Output:
  # ```
  # macro example(name)
  #   puts {{ name }}
  # end
  # ```
  # Parameters:
  # - line : String
  # Returns:
  # an object class itself.
  def add_body(line : String) : self
    @body += line + "\n"
    self
  end

  # Write the macro body.
  # ```
  # macro_type = CGT::Macro.new("example")
  # macro_type.add_arg("name")
  # macro_type.body = "puts {{ name }}"
  # ```
  # Output:
  # ```
  # macro example(name)
  #   puts {{ name }}
  # end
  # ```
  # Parameters:
  # - body : String
  # Returns:
  # an object class itself.
  def body=(body : String) : self
    @body = body
    self
  end

  # Generates the macro.
  # Returns: String
  def generate : String
    String.build do |str|
      str << "macro #{@name}"
      str << generate_args unless @args.empty?
      str << "\n"
      @body.each_line { |line| str << "  #{line}\n" }
      str << "end"
    end
  end

  # Generate the args.
  # Returns: String
  private def generate_args : String
    String.build do |str|
      str << '(' unless @args.empty?
      @args.each_with_index do |arg, i|
        str << "#{arg}"
        str << ", " if i != @args.size - 1
      end
      str << ')' unless @args.empty?
    end
  end
end
