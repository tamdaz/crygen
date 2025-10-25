module Crygen::Modules::Class
  @classes = [] of Crygen::Types::Class

  # Adds the nested class.
  def add_class(the_class : Crygen::Types::Class) : self
    @classes << the_class
    self
  end

  # Adds the nested classes.
  def add_classes(*classes : Crygen::Types::Class) : self
    @classes += classes.to_a
    self
  end
end
