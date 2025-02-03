module Crygen::Modules::ClassVar
  @class_vars = [] of Tuple(String, String, String | Nil)

  # Adds a class var with no default value.
  def add_class_var(name : String, type : String) : self
    @class_vars << {name, type, nil}
    self
  end

  # Adds a class var with default value.
  def add_class_var(name : String, type : String, value : String) : self
    if type == "String"
      @class_vars << {name, type, value.dump}
    else
      @class_vars << {name, type, value}
    end
    self
  end

  # Generate the class_vars
  def generate_class_vars : String
    String.build do |str|
      @class_vars.each do |instance_var|
        if instance_var[2].nil?
          str << "@@#{instance_var[0]} : #{instance_var[1]}\n"
        else
          str << "@@#{instance_var[0]} : #{instance_var[1]} = #{instance_var[2]}\n"
        end
      end
    end
  end
end
