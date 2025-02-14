module Crygen::Modules::Scope
  @scope : Symbol = :public

  # Set the scope as protected.
  # Returns:
  # an object class itself.
  def as_protected : self
    @scope = :protected
    self
  end

  # Set the scope as private.
  # Returns:
  # an object class itself.
  def as_private : self
    @scope = :private
    self
  end
end
