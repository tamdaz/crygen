require "./../modules/*"
require "./../interfaces/generator_interface"

# A class that generates a method.
# ```
# method_type = CGT::Method.new("major?", "Bool")
# method_type.add_arg("age", "Int8", "22")
# method_type.add_body("Hello world".dump)
# ```
# Output:
# ```
# def major?(age : Int8 = 22) : Bool
#   "Hello world"
# end
# ```
class Crygen::Types::Method < Crygen::Abstract::GeneratorInterface
  include Crygen::Modules::Comment
  include Crygen::Modules::Scope
  include Crygen::Modules::Arg
  include Crygen::Modules::Annotation

  # Body content.
  @body : String = ""

  def initialize(@name : String, @return_type : String); end

  # Adds an annotation on a class.
  # ```
  # method_type = CGT::Method.new("full_name", "String")
  # method_type.add_annotation(CGT::Annotation.new("Experimental"))
  # ```
  # Output:
  # ```
  # @[Experimental]
  # def full_name : String
  # end
  # ```
  def add_annotation(annotation_type : Crygen::Types::Annotation) : self
    @annotations << annotation_type
    self
  end

  # Add a code into method.
  # ```
  # method_type = CGT::Method.new("full_name", "String")
  # method_type.add_body("Hello world".dump)
  # ```
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

  # Generates the methods.
  def generate : String
    String.build do |str|
      @comments.each { |comment| str << "# #{comment}\n" }
      @annotations.each { |annotation_type| str << annotation_type.generate + "\n" }
      str << @scope.to_s + " " unless @scope == :public
      str << "def #{@name}#{generate_args} : #{@return_type}\n"
      @body.each_line { |line| str << "  #{line}\n" }
      str << "end"
    end
  end

  # Generates the abstract methods.
  protected def generate_abstract_method : String
    String.build do |str|
      @comments.each { |comment| str << "# #{comment}\n" }
      str << @scope.to_s + " " unless @scope == :public
      str << "  abstract def #{@name}#{generate_args} : #{@return_type}\n"
    end
  end
end
