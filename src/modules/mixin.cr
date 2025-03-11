# Module that is used to store and add the mixins (includes and extends).
module Crygen::Modules::Mixin
  @includes = [] of String
  @extends = [] of String

  # Adds an include into object.
  def add_include(name : String) : self
    @includes << name
    self
  end

  # Adds an extend into object
  def add_extend(name : String) : self
    @extends << name
    self
  end

  # Generate the mixins.
  protected def generate_mixins : String
    String.build do |str|
      @includes.each do |inc|
        str << "include "
        str << inc
        str << "\n"
      end

      @extends.each do |ext|
        str << "extend "
        str << ext
        str << "\n"
      end
    end
  end
end
