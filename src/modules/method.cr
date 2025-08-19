require "./../types/method"

module Crygen::Modules::Method
  @methods = [] of Crygen::Types::Method

  # Adds an method into class.
  def add_method(method : Crygen::Types::Method) : self
    @methods << method
    self
  end

  # Adds methods into class.
  def add_methods(*methods : Crygen::Types::Method) : self
    @methods += methods.to_a
    self
  end

  protected def generate_abstract_methods(str : IO, methods : Array(CGT::Method), whitespace : Bool)
    methods.each do |method|
      str << "\n" if whitespace == true
      str << method.generate_abstract_method.each_line { |line| str << "  " + line + "\n" }

      if whitespace == false && @type == :normal
        whitespace = true
      end
    end
  end

  protected def generate_normal_methods(str : IO, methods : Array(CGT::Method), whitespace : Bool)
    methods.each do |method|
      str << "\n" if whitespace == true
      str << method.generate.each_line { |line| str << "  " + line + "\n" }

      if whitespace == false && @type == :normal
        whitespace = true
      end
    end
  end
end
