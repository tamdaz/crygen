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
  @constants = [] of Tuple(String, String | Nil)

  def initialize(@name : String, @type : String | Nil = nil); end

  # Adds a constant into enum (name and value).
  # ```
  # enum_type = Crygen::Types::Enum.new("Person")
  # enum_type.add_constant("Employee")
  #
  # enum_type = Crygen::Types::Enum.new("Person")
  # enum_type.add_constant("Employee", 1)
  # ```
  # Output:
  # enum Person
  #   Employee
  # end
  # ```
  def add_constant(name : String, value : String | Nil = nil) : self
    @constants << {name, value}

    self
  end

  # Generates an enum.
  def generate : String
    String.build do |str|
      @comments.each { |comment| str << "# #{comment}\n" }

      @annotations.each { |annotation_type| str << annotation_type.generate + "\n" }

      str << "enum " << @name

      if @type
        str << " : " << @type
      end

      str << "\n"

      @constants.each do |constant|
        name, value = constant

        str << "  " << name

        if value
          str << " = " << value
        end

        str << "\n"
      end

      if !@methods.empty?
        str << "\n"
      end

      can_add_whitespace = false

      @methods.each do |method|
        if can_add_whitespace == true
          str << "\n"
        end

        str << method.generate.each_line { |line| str << "  " + line + "\n" }

        if can_add_whitespace == false
          can_add_whitespace = true
        end
      end

      str << "end"
    end
  end
end
