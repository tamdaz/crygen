module Crygen::Modules::Scope
  @scope : Symbol = :public

  # Set the scope as protected.
  def as_protected : Nil
    @scope = :protected
  end

  # Set the scope as private.
  def as_private : Nil
    @scope = :private
  end
end
