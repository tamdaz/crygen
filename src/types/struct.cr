require "./../modules/*"

class Crygen::Types::Struct
  include Crygen::Modules::Comment
  include Crygen::Modules::InstanceVar
  include Crygen::Modules::ClassVar
  include Crygen::Modules::Method

  def initialize(@name : String)
    @annotations = [] of Crygen::Types::Annotation
  end

  # Adds an annotation on a class.
  def add_annotation(annotation_type : Crygen::Types::Annotation) : Nil
    @annotations << annotation_type
  end

  # Generates a Crystal code.
  def generate : String
    String.build do |str|
      @comments.each { |comment| str << "# #{comment}\n" }
      @annotations.each { |annotation_type| str << annotation_type.generate + "\n" }
      str << "struct #{@name}\n"
      generate_instance_vars.each_line { |line| str << "  " + line + "\n" }
      generate_class_vars.each_line { |line| str << "  " + line + "\n" }
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
