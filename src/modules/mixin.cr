module Crygen::Modules::Mixin
  @includes = [] of String
  @extends = [] of String

  def add_include(name : String)
    @includes << name
  end

  def add_extend(name : String)
    @extends << name
  end

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
