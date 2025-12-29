# Module that stores an array of classes.
module Crygen::Modules::Class
  protected getter classes = [] of Crygen::Types::Class

  # Adds the nested class(es).
  def add_class(*classes : Crygen::Types::Class) : self
    @classes += classes.to_a
    self
  end
end
