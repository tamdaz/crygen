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

  # Generate the abstract and normal methods
  protected def generate_methods(str : IO, methods : Array(CGT::Method))
    methods.each_with_index do |method, index|
      if index != 0 && (!method.comments.empty? || method.type != :abstract)
        str << "\n"
      end

      str << method << "\n"
    end
  end
end
