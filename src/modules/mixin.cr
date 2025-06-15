# Module that is used to store and add the mixins (includes and extends).
module Crygen::Modules::Mixin
  @includes = [] of String
  @extends = [] of String

  # Adds an include into object.
  def add_include(name : String) : self
    @includes << name
    self
  end

  # Adds an extend into object.
  def add_extend(name : String) : self
    @extends << name
    self
  end

  # Adds includes into object.
  def add_includes(names : Array(String)) : self
    @includes += names
    self
  end

  # Adds includes into object.
  def add_extends(names : Array(String)) : self
    @extends += names
    self
  end

  # Generate the mixins.
  protected def generate_mixins : String
    String.build do |str|
      @includes.each { |inc| str << "include " << inc << "\n" }
      @extends.each { |ext| str << "extend " << ext << "\n" }
    end
  end
end
