require "./../modules/*"
require "./../interfaces/generator_interface"

# A class that generates a method.
# ```
# method_type = CGT::Method.new("major?", "Bool")
# method_type.add_arg("age", "Int8", "22")
# method_type.add_body("Hello world".dump)
# ```
#
# Output:
# ```
# def major?(age : Int8 = 22) : Bool
#   "Hello world"
# end
# ```
class Crygen::Types::Method < Crygen::Interfaces::GeneratorInterface
  include Crygen::Modules::Comment
  include Crygen::Modules::Scope
  include Crygen::Modules::Arg
  include Crygen::Modules::Annotation

  getter type : Symbol = :normal

  # Body content.
  @body : String = ""

  def initialize(@name : String, @return_type : String); end

  # Set as an abstract method.
  # ```
  # class_type = CGT::Class.new("Person")
  # class_type.as_abstract
  # ```
  #
  # Output:
  # ```
  # abstract class Person
  # end
  # ```
  def as_abstract : self
    @type = :abstract
    self
  end

  # Add a code into method.
  # ```
  # method_type = CGT::Method.new("full_name", "String")
  # method_type.add_body("Hello world".dump)
  # ```
  #
  # Output:
  # ```
  # def full_name : String
  #   "Hello world"
  # end
  # ```
  def add_body(body : String) : self
    @body += body
    self
  end

  # Generates the method.
  def generate : String
    if @type == :abstract
      self.generate_abstract_method
    else
      self.generate_normal_method
    end
  end

  # Generates the normal (non-abstract) method.
  protected def generate_normal_method : String
    String.build do |str|
      @comments.each do |line|
        str << Crygen::Utils::Indentation.generate << "# " << line << "\n"
      end

      str << CGG::Annotation.generate(@annotations)
      str << Crygen::Utils::Indentation.generate
      str << @scope << ' ' unless @scope == :public
      str << "def " << @name << generate_args << " : " << @return_type << "\n"

      Crygen::Utils::Indentation.add_indent

      @body.each_line do |line|
        str << Crygen::Utils::Indentation.generate << line << "\n"
      end

      Crygen::Utils::Indentation.remove_indent

      str << Crygen::Utils::Indentation.generate << "end"
    end
  end

  # Generates the abstract method.
  protected def generate_abstract_method : String
    String.build do |str|
      @comments.each do |line|
        str << Crygen::Utils::Indentation.generate << "# " << line << "\n"
      end

      str << CGG::Annotation.generate(@annotations)
      str << Crygen::Utils::Indentation.generate
      str << @scope << ' ' unless @scope == :public
      str << "abstract def " << @name << generate_args << " : " << @return_type
    end
  end

  # Generate a method thanks to #to_s method.
  def to_s(io : IO) : Nil
    io << self.generate
  end
end
