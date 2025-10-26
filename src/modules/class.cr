module Crygen::Modules::Class
  @classes = [] of Crygen::Types::Class

  # Adds the nested class(es).
  def add_class(*classes : Crygen::Types::Class) : self
    @classes += classes.to_a
    self
  end
end
