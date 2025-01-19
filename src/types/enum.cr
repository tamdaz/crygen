require "./../modules/method.cr"

class Crygen::Types::Enum
  include Crygen::Modules::Method

  @constants = [] of Tuple(String, String | Nil)

  def initialize(@name : String, @type : String | Nil = nil); end

  # Adds a constant into enum (name only).
  def add_constant(name : String) : Nil
    @constants << {name, nil}
  end

  # Adds a constant into enum (name and value).
  def add_constant(name : String, value : String) : Nil
    @constants << {name, value}
  end

  # Generates an enum.
  def generate : String
    String.build do |str|
      if @type
        str << "enum #{@name} : #{@type}\n"
      else
        str << "enum #{@name}\n"
      end
      @constants.each do |constant|
        if constant[1]
          str << "  #{constant[0]} = #{constant[1]}\n"
        else
          str << "  #{constant[0]}\n"
        end
      end
      str << "\n" if !@methods.empty?
      can_add_whitespace = false
      @methods.each do |method|
        str << "\n" if can_add_whitespace == true
        str << method.generate.each_line { |line| str << "  " + line + "\n" }
        if can_add_whitespace == false
          can_add_whitespace = true
        end
      end
      str << "end"
    end
  end
end
