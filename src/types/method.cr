require "./../modules/*"
require "./../interfaces/generator"

class Crygen::Types::Method < Crygen::Abstract::GeneratorInterface
  include Crygen::Modules::Comment
  include Crygen::Modules::Scope
  include Crygen::Modules::Arg

  @body : String = ""

  def initialize(@name : String, @return_type : String)
    @annotations = [] of Crygen::Types::Annotation
  end

  # Adds an annotation on a class.
  def add_annotation(annotation_type : Crygen::Types::Annotation) : Nil
    @annotations << annotation_type
  end

  # Add a code into method.
  def add_body(body : String) : Nil
    @body += body
  end

  # Generates the methods
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

  # Generates the abstract methods
  protected def generate_abstract_method : String
    String.build do |str|
      @comments.each { |comment| str << "# #{comment}\n" }
      str << @scope.to_s + " " unless @scope == :public
      str << "  abstract def #{@name}#{generate_args} : #{@return_type}\n"
    end
  end
end
