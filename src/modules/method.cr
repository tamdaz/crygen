require "./../types/method"

module Crygen::Modules::Method
  @methods = [] of Crygen::Types::Method

  # Adds an method into class.
  # Parameters:
  # method : Crygen::Types::Method
  # Returns:
  # an object class itself.
  def add_method(method : Crygen::Types::Method) : self
    @methods << method
    self
  end
end
