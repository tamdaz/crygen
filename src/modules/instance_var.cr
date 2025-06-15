# Module that is used to store and add the instance variables.
module Crygen::Modules::InstanceVar
  @instance_vars = [] of Tuple(String, String, String | Nil)

  # Adds an argument with default value.
  def add_instance_var(name : String, type : String, value : String | Nil = nil) : self
    output_value = if type == "String" && !value.nil?
                     value.dump
                   else
                     value
                   end
    @instance_vars << {name, type, output_value}
    self
  end

  # Generate the instance vars.
  def generate_instance_vars : String
    String.build do |str|
      @instance_vars.each do |instance_var|
        name, type, value = instance_var

        str << '@' << name << " : " << type
        str << " = " << value unless value.nil?
        str << "\n"
      end
    end
  end
end
