# Module that is used to store and add the instance variables.
module Crygen::Modules::InstanceVar
  @instance_vars = [] of Tuple(String, String, String | Nil)

  # Adds an argument with default value.
  def add_instance_var(name : String, type : String, value : String | Nil = nil) : self
    if type == "String" && !value.nil?
      @instance_vars << {name, type, value.dump}
    else
      @instance_vars << {name, type, value}
    end

    self
  end

  # Generate the instance vars.
  def generate_instance_vars : String
    String.build do |str|
      @instance_vars.each do |instance_var|
        name, type, value = instance_var

        str << '@' << name << " : " << type

        unless value.nil?
          str << " = " << value
        end

        str << "\n"
      end
    end
  end
end
