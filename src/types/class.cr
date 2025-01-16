require "./../modules/*"

class Crygen::Types::Class
  include Crygen::Modules::Comment
  include Crygen::Modules::Method

  @type : Symbol = :normal

  def initialize(@name : String); end

  # Set as an abstract class.
  def as_abstract : Nil
    @type = :abstract
  end

  # Generates a Crystal code.
  def generate : String
    String.build do |str|
      @comments.each { |comment| str << "# #{comment}\n" }
      str << class_type
      @methods.each do |method|
        method.generate.each_line { |line| str << "  " + line }
      end
      str << "end"
    end
  end

  # Defines a class type.
  private def class_type : String
    if @type == :abstract
      "abstract class #{@name}\n"
    else
      "class #{@name}\n"
    end
  end
end
