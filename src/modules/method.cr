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
    @methods << methods
    self
  end
end
