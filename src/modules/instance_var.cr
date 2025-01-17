module Crygen::Modules::InstanceVar
  @instance_vars = [] of Tuple(String, String, String | Nil)

  # Add an argument with no default value.
  def add_instance_var(name : String, type : String) : Nil
    @instance_vars << {name, type, nil}
  end

  # Add an argument with default value.
  def add_instance_var(name : String, type : String, value : String) : Nil
    if type == "String"
      @instance_vars << {name, type, value.dump}
    else
      @instance_vars << {name, type, value}
    end
  end

  # Generate the instance_vars
  def generate_instance_vars : String
    String.build do |str|
      @instance_vars.each do |instance_var|
        if instance_var[2].nil?
          str << "@#{instance_var[0]} : #{instance_var[1]}\n"
        else
          str << "@#{instance_var[0]} : #{instance_var[1]} = #{instance_var[2]}\n"
        end
      end
    end
  end
end
