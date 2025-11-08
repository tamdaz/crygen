require "./../types/annotation"

# Module that is used to store class variables.
module Crygen::Modules::ClassVar
  @class_vars = [] of Tuple(String, String, String?, Array(Crygen::Types::Annotation)?)

  # Adds a class var with default value.
  def add_class_var(
    name : String, type : String, value : String? = nil,
    annotations : Array(Crygen::Types::Annotation)? = nil,
  ) : self
    output_value = if type == "String" && !value.nil?
                     value.dump
                   else
                     value
                   end

    @class_vars << {name, type, output_value, annotations}
    self
  end

  # Adds a class var with default value.
  def add_class_var(
    name : String, type : String, value : String? = nil,
    the_annotation : Crygen::Types::Annotation? = nil,
  ) : self
    add_class_var(name, type, value, [the_annotation])
  end

  # Generate the class_vars.
  def generate_class_vars : String
    String.build do |str|
      can_add_whitespace = false

      @class_vars.each do |class_var|
        name, type, value, annotations = class_var

        if can_add_whitespace && annotations
          str << "\n"
        end

        if annotations
          annotations.each do |ann|
            str << Crygen::Utils::Indentation.generate << ann << "\n"
          end
        end

        str << Crygen::Utils::Indentation.generate
        str << "@@" << name << " : " << type
        str << " = " << value unless value.nil?
        str << "\n"

        if can_add_whitespace == false
          can_add_whitespace = true
        end
      end
    end
  end
end
