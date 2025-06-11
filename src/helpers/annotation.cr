# This module provides helper methods for adding annotations to objects easily.
module Crygen::Helpers::Annotation
  # Add a `@[Deprecated]` annotation.
  # Returns: an object class itself.
  def as_deprecated : self
    @annotations << CGT::Annotation.new("Deprecated")
    self
  end

  # Add a `@[Deprecated]` annotation on the method with a custom message.
  # Returns: an object class itself.
  def as_deprecated(message : String) : self
    @annotations << CGT::Annotation.new("Deprecated").add_arg(message.dump)
    self
  end

  # Add a `@[Experimental]` annotation.
  # Returns: an object class itself.
  def as_experimental : self
    @annotations << CGT::Annotation.new("Experimental")
    self
  end

  # Add a `@[Experimental]` annotation on the method with a custom message.
  # Returns: an object class itself.
  def as_experimental(message : String) : self
    @annotations << CGT::Annotation.new("Experimental").add_arg(message.dump)
    self
  end

  # Add a `@[Flags]` annotation.
  # Returns: an object class itself.
  def as_flags : self
    @annotations << CGT::Annotation.new("Flags")
    self
  end

  # Add a `@[Link]` annotation on the method with the library name.
  # Returns: an object class itself.
  def add_link(name : String) : self
    @annotations << CGT::Annotation.new("Link").add_arg(name.dump)
    self
  end

  # Add a `@[ThreadLocal]` annotation.
  # Returns: an object class itself.
  def as_thread_local : self
    @annotations << CGT::Annotation.new("ThreadLocal")
    self
  end

  # Add a `@[AlwaysInline]` annotation.
  # Returns: an object class itself.
  def as_always_inline : self
    @annotations << CGT::Annotation.new("AlwaysInline")
    self
  end

  # Add a `@[Extern]` annotation.
  # Returns: an object class itself.
  def as_extern : self
    @annotations << CGT::Annotation.new("Extern")
    self
  end

  # Add a `@[NoInline]` annotation.
  # Returns: an object class itself.
  def as_no_inline : self
    @annotations << CGT::Annotation.new("NoInline")
    self
  end

  # Add a `@[CallConvention]` annotation.
  # Returns: an object class itself.
  def add_call_convention(name : String) : self
    @annotations << CGT::Annotation.new("Link").add_arg(name.dump)
    self
  end
end
