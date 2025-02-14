require "./../modules/method.cr"
require "./../interfaces/generator"

# A class that generates an enumeration (enum).
# ```
# enum_type = Crygen::Types::Enum.new("Person")
# enum_type.add_constant("Employee")
# enum_type.add_constant("Student")
# enum_type.add_constant("Intern")
# puts enum_type.generate
# ```
# Output:
# ```
# enum Person
#   Employee
#   Student
#   Intern
# end
# ```
class Crygen::Types::Enum
  include Crygen::Modules::Method

  # Array of constants (name and value).
  @constants = [] of Tuple(String, String | Nil)

  def initialize(@name : String, @type : String | Nil = nil); end

  # Adds a constant into enum (name only).
  # ```
  # enum_type = Crygen::Types::Enum.new("Person")
  # enum_type.add_constant("Employee")
  # ```
  # Output:
  # ```
  # enum Person
  #  Employee
  # end
  # ```
  # Returns:
  # an object class itself.
  def add_constant(name : String) : self
    @constants << {name, nil}
    self
  end

  # Adds a constant into enum (name and value).
  # ```
  # enum_type = Crygen::Types::Enum.new("Person")
  # enum_type.add_constant("Employee", 1)
  # ```
  # Returns:
  # an object class itself.
  def add_constant(name : String, value : String) : self
    @constants << {name, value}
    self
  end

  # Generates an enum.
  # Returns: String
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
