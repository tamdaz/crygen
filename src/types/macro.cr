require "./../modules/arg"
require "./../interfaces/generator_interface"

# A class that generates a macro
# ```
# macro_type = CGT::Macro.new("example")
# macro_type.add_arg("name")
# puts macro_type.generate
# ```
#
# Output:
# ```
# macro example(name)
#   puts {{ name }}
# end
# ```
class Crygen::Types::Macro < Crygen::Interfaces::GeneratorInterface
  @args = [] of String
  @body = ""

  # The macro name to pass to the constructor.
  def initialize(@name : String); end

  # Adds an argument to the macro.
  # ```
  # macro_type = CGT::Macro.new("example")
  # macro_type.add_arg("name")
  # ```
  #
  # Output:
  # ```
  # macro example(name)
  # end
  # ```
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
  #
  # Output:
  # ```
  # macro example(name)
  #   puts {{ name }}
  # end
  # ```
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
  #
  # Output:
  # ```
  # macro example(name)
  #   puts {{ name }}
  # end
  # ```
  def body=(body : String) : self
    @body = body
    self
  end

  # Generates a for loop macro.
  # ```
  # Crygen::Types::Macro.for_loop("item", "items") do |str, indent|
  #   str << indent << "puts {{ item }}\n"
  # end
  # ```
  #
  # Output:
  # ```
  # {% for item in items %}
  #   puts {{ item }}
  # {% end %}
  # ```
  def self.for_loop(name : String, iterator : String, &) : String
    String.build do |str|
      str << "{% for " << name << " in " << iterator << " %}" << "\n"
      String::IndentedBuilder.with_indent(str) do |_, indent|
        yield str, indent
      end
      str << "{% end %}"
    end
  end

  # Generates an if condition macro.
  # ```
  # Crygen::Types::Macro.if("x > 0") do |str, indent|
  #   str << indent << "puts \"positive\"\n"
  # end
  # ```
  #
  # Output:
  # ```
  # {% for item in items %}
  #   puts "positive"
  # {% end %}
  # ```
  def self.if(expression : String, &) : String
    String.build do |str|
      str << "{% if " << expression << " %}" << "\n"
      String::IndentedBuilder.with_indent(str) do |_, indent|
        yield str, indent
      end
      str << "{% end %}"
    end
  end

  # Generates an unless condition macro.
  # ```
  # Crygen::Types::Macro.unless("x > 0") do |str, indent|
  #   str << indent << "puts \"negative or zero\"\n"
  # end
  # ```
  #
  # Output:
  # ```
  # {% unless x > 0 %}
  #   puts \"negative or zero\"
  # {% end %}
  # ```
  def self.unless(expression : String, &) : String
    String.build do |str|
      str << "{% unless " << expression << " %}" << "\n"
      String::IndentedBuilder.with_indent(str) do |_, indent|
        yield str, indent
      end
      str << "{% end %}"
    end
  end

  # Generates a verbatim macro.
  # ```
  # Crygen::Types::Macro.verbatim do |str, indent|
  #   str << indent << "puts 123\n"
  # end
  # ```
  #
  # Output:
  # ```
  # {% verbatim do %}
  #   puts 123
  # {% end %}
  # ```
  def self.verbatim(&) : String
    String.build do |str|
      str << "{% verbatim do %}" << "\n"
      String::IndentedBuilder.with_indent(str) do |_, indent|
        yield str, indent
      end
      str << "{% end %}"
    end
  end

  # Generates the macro.
  def generate : String
    String.build do |str|
      str << "macro " << @name
      str << generate_args unless @args.empty?
      str << "\n"
      @body.each_line { |line| str << "  " << line << "\n" }
      str << "end"
    end
  end

  # :ditto:
  def to_s(io : IO) : Nil
    io << self.generate
  end

  # Generate the args.
  private def generate_args : String
    String.build do |str|
      str << '(' unless @args.empty?
      @args.each_with_index do |arg, index|
        str << arg
        str << ", " if index != @args.size - 1
      end
      str << ')' unless @args.empty?
    end
  end
end
