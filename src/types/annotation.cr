require "./../modules/arg"
require "./../interfaces/generator"

class Crygen::Types::Annotation < Crygen::Abstract::GeneratorInterface
  # Tuple => {name, value}
  @args = [] of Tuple(String | Nil, String)

  def initialize(@name : String); end

  def add_arg(value : String) : Nil
    @args << {nil, value}
  end

  def add_arg(name : String, value : String) : Nil
    @args << {name, value}
  end

  # Generates a Crystal code.
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
