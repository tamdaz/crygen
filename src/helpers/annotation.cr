# This module provides helper methods for adding annotations to objects easily.
module Crygen::Helpers::Annotation
  # Add a `@[Deprecated]` annotation.
  # Returns: an object class itself.
  def deprecated : self
    @annotations << CGT::Annotation.new("Deprecated")
    self
  end

  # Add a `@[Deprecated]` annotation on the method with a custom message.
  # Returns: an object class itself.
  def deprecated(message : String) : self
    @annotations << CGT::Annotation.new("Deprecated").add_arg(message.dump)
    self
  end

  # Add a `@[Experimental]` annotation.
  # Returns: an object class itself.
  def experimental : self
    @annotations << CGT::Annotation.new("Experimental")
    self
  end

  # Add a `@[Experimental]` annotation on the method with a custom message.
  # Returns: an object class itself.
  def experimental(message : String) : self
    @annotations << CGT::Annotation.new("Experimental").add_arg(message.dump)
    self
  end

  # Add a `@[Flags]` annotation.
  # Returns: an object class itself.
  def flags : self
    @annotations << CGT::Annotation.new("Flags")
    self
  end

  # Add a `@[Link]` annotation on the method with the library name.
  # Returns: an object class itself.
  def link(name : String) : self
    @annotations << CGT::Annotation.new("Link").add_arg(name.dump)
    self
  end

  # Add a `@[ThreadLocal]` annotation.
  # Returns: an object class itself.
  def thread_local : self
    @annotations << CGT::Annotation.new("ThreadLocal")
    self
  end

  # Add a `@[AlwaysInline]` annotation.
  # Returns: an object class itself.
  def always_inline : self
    @annotations << CGT::Annotation.new("AlwaysInline")
    self
  end

  # Add a `@[Extern]` annotation.
  # Returns: an object class itself.
  def extern : self
    @annotations << CGT::Annotation.new("Extern")
    self
  end

  # Add a `@[NoInline]` annotation.
  # Returns: an object class itself.
  def no_inline : self
    @annotations << CGT::Annotation.new("NoInline")
    self
  end

  # Add a `@[CallConvention]` annotation.
  # Returns: an object class itself.
  def call_convention(name : String) : self
    @annotations << CGT::Annotation.new("Link").add_arg(name.dump)
    self
  end
end
