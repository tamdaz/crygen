require "./../types/annotation"

# Module that is used to store and add the instance variables.
module Crygen::Modules::InstanceVar
  @instance_vars = [] of Tuple(String, String, String?, Array(Crygen::Types::Annotation)?)

  # Adds an argument with default value.
  def add_instance_var(
    name : String, type : String, value : String? = nil,
    annotations : Array(Crygen::Types::Annotation)? = nil,
  ) : self
    output_value = if type == "String" && !value.nil?
                     value.dump
                   else
                     value
                   end

    @instance_vars << {name, type, output_value, annotations}
    self
  end

  # Adds an argument with default value.
  def add_instance_var(
    name : String, type : String, value : String? = nil,
    the_annotation : Crygen::Types::Annotation? = nil,
  ) : self
    add_instance_var(name, type, value, [the_annotation])
  end

  # Generate the instance vars.
  def generate_instance_vars : String
    String.build do |str|
      can_add_whitespace = false

      @instance_vars.each do |instance_var|
        name, type, value, annotations = instance_var

        if can_add_whitespace && annotations
          str << "\n"
        end

        if annotations
          annotations.each do |ann|
            str << Crygen::Utils::Indentation.generate << ann << "\n"
          end
        end

        str << Crygen::Utils::Indentation.generate
        str << '@' << name << " : " << type
        str << " = " << value unless value.nil?
        str << "\n"

        if can_add_whitespace == false
          can_add_whitespace = true
        end
      end
    end
  end
end
