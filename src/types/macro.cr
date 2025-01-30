require "./../interfaces/generator"
require "./../modules/arg"

# A class that generates a macro
# ```
# macro_type = CGT::Macro.new("example")
# macro_type.add_arg("name")
# puts macro_type.generate
# ```
# Output :
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
  def add_arg(arg : String) : Nil
    @args << arg
  end

  # Adds a new line into the macro body.
  def add_body(line : String) : Nil
    @body += line + "\n"
  end

  # Write the macro body.
  def body=(body : String) : Nil
    @body = body
  end

  # Generates the macro.
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
