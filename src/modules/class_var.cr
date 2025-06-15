# Module that is used to store class variables.
module Crygen::Modules::ClassVar
  @class_vars = [] of Tuple(String, String, String | Nil)

  # Adds a class var with default value.
  def add_class_var(name : String, type : String, value : String | Nil = nil) : self
    output_value = if type == "String" && !value.nil?
                     value.dump
                   else
                     value
                   end

    @class_vars << {name, type, output_value}
    self
  end

  # Generate the class_vars.
  def generate_class_vars : String
    String.build do |str|
      @class_vars.each do |class_var|
        name, type, value = class_var

        str << "@@" << name << " : " << type
        str << " = " << value unless value.nil?
        str << "\n"
      end
    end
  end
end
