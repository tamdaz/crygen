module Crygen::Modules::Arg
  @args = [] of Tuple(String, String, String | Nil)

  # Add an argument with no default value.
  def add_arg(name : String, type : String) : Nil
    @args << {name, type, nil}
  end

  # Add an argument with default value.
  def add_arg(name : String, type : String, value : String) : Nil
    @args << {name, type, value}
  end

  # Generate the args
  def generate_args : String
    String.build do |str|
      str << '(' unless @args.empty?
      @args.each_with_index do |arg, i|
        if arg[2].nil?
          str << "#{arg[0]} : #{arg[1]}"
        else
          str << "#{arg[0]} : #{arg[1]} = #{arg[2]}"
        end
        str << ", " if i != @args.size - 1
      end
      str << ')' unless @args.empty?
    end
  end
end
