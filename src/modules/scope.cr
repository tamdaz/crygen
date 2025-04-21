module Crygen::Modules::Scope
  @scope : Symbol = :public

  # Set the scope as protected.
  def as_protected : self
    @scope = :protected

    self
  end

  # Set the scope as private.
  def as_private : self
    @scope = :private
    
    self
  end
end
