# Module that is used to store and add the arguments.
module Crygen::Modules::Arg
  @args = [] of Tuple(String, String, String | Nil)

  # Adds an argument.
  def add_arg(name : String, type : String, value : String | Nil = nil) : self
    @args << {name, type, value}
    self
  end

  # Generate the args.
  def generate_args : String
    String.build do |str|
      str << '(' unless @args.empty?

      @args.each_with_index do |arg, i|
        name, type, value = arg

        str << name << " : " << type
        unless value.nil?
          str << " = " << value
        end
        str << ", " if i != @args.size - 1
      end

      str << ')' unless @args.empty?
    end
  end
end
