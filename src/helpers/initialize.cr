# This module provides helper methods for adding constructors
# (or initializers) to classes and structures.
module Crygen::Helpers::Initialize
  # Adds `#initialize` method.
  # Returns: an object itself.
  def add_initialize : self
    method = Crygen::Types::Method.new("initialize", "Nil")
    @methods << method

    self
  end

  # Adds `#initialize` method with the block.
  # Returns: an object itself.
  def add_initialize(&) : self
    method = Crygen::Types::Method.new("initialize", "Nil")
    yield method
    @methods << method

    self
  end
end
