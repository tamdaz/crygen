require "./../modules/*"

class Crygen::Types::Class
  include Crygen::Modules::Comment
  include Crygen::Modules::InstanceVar
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
      generate_instance_vars.each_line { |line| str << "  " + line + "\n" }
      can_add_whitespace = false
      @methods.each do |method|
        str << "\n" if can_add_whitespace == true

        case @type
        when :normal   then str << method.generate.each_line { |line| str << "  " + line + "\n" }
        when :abstract then str << method.generate_abstract_method
        end

        if can_add_whitespace == false && @type == :normal
          can_add_whitespace = true
        end
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
