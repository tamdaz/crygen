require "./../types/method"

module Crygen::Modules::Method
  @methods = [] of Crygen::Types::Method

  # Adds an method into class.
  def add_method(method : Crygen::Types::Method) : Nil
    @methods << method
  end
end
