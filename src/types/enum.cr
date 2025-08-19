require "./../modules/method.cr"
require "./../interfaces/generator_interface"

# A class that generates an enumeration (enum).
# ```
# enum_type = Crygen::Types::Enum.new("Person")
# enum_type.add_constant("Employee")
# enum_type.add_constant("Student")
# enum_type.add_constant("Intern")
# puts enum_type.generate
# ```
#
# Output:
# ```
# enum Person
#   Employee
#   Student
#   Intern
# end
# ```
class Crygen::Types::Enum < Crygen::Interfaces::GeneratorInterface
  include Crygen::Modules::Comment
  include Crygen::Modules::Method
  include Crygen::Modules::Annotation

  # Array of constants (name and value).
  @constants = [] of Tuple(String, String?)

  def initialize(@name : String, @type : String? = nil); end

  # Adds a constant into enum (name and value).
  # ```
  # enum_type = Crygen::Types::Enum.new("Person")
  # enum_type.add_constant("Employee")
  #
  # enum_type = Crygen::Types::Enum.new("Person")
  # enum_type.add_constant("Employee", 1)
  # ```
  #
  # Output:
  # ```
  # enum Person
  #   Employee
  # end
  # ```
  #
  # ```
  # enum Person
  #   Employee = 1
  # end
  # ```
  def add_constant(name : String, value : String? = nil) : self
    @constants << {name, value}
    self
  end

  # Adds several constants into enum (name and value).
  # ```
  # enum_type = Crygen::Types::Enum.new("Person")
  # enum_type.add_constants(
  #   {"Employee", "1"}, {"Student", "2"}, {"Intern", "3"}
  # )
  # ```
  #
  # Output:
  # ```
  # enum Person
  #   Employee = 1
  #   Student  = 2
  #   Intern   = 3
  # end
  # ```
  def add_constants(*constants : Tuple(String, String?)) : self
    constants.each do |name, value|
      self.add_constant(name, value)
    end
    self
  end

  # Generates an enum.
  def generate : String
    String.build do |str|
      str << CGG::Comment.generate(@comments)
      str << CGG::Annotation.generate(@annotations)

      str << "enum " << @name
      str << " : " << @type if @type
      str << "\n"

      @constants.each do |constant|
        name, value = constant

        str << "  " << name
        str << " = " << value if value
        str << "\n"
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

  # Generate an enum thanks to #to_s method.
  def to_s(io : IO) : Nil
    io << self.generate
  end
end
