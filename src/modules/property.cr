require "./../enums/prop_visibility"
require "./scope"

module Crygen::Modules::Property
  @properties = [] of Hash(Symbol, String | Symbol | Nil)

  # Adds a property into object (visibility, name and type)
  def add_property(visibility : Crygen::Enums::PropVisibility, name : String, type : String) : self
    @properties << {:scope => :public, :visibility => visibility.to_s.downcase, :name => name, :type => type, :value => nil}
    self
  end

  # Adds a property into object (visibility, name, type and value)
  def add_property(visibility : Crygen::Enums::PropVisibility, name : String, type : String, value : String) : self
    @properties << {:scope => :public, :visibility => visibility.to_s.downcase, :name => name, :type => type, :value => value}
    self
  end

  # Generates the properties.
  protected def generate_properties : String
    String.build do |str|
      @properties.each do |prop|
        str << "#{prop[:visibility]} #{prop[:name]}"
        str << " : #{prop[:type]}" if prop[:visibility]
        str << " = #{prop[:value]}" if prop[:value]
        str << "\n"
      end
    end
  end
end
