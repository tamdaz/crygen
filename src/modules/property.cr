require "./scope"

module Crygen::Modules::Property
  @properties = [] of Hash(Symbol, String | Symbol | Nil)

  # Adds a property into object (visibility, name and type)
  def add_property(visibility : Symbol, name : String, type : String) : Nil
    @properties << {:scope => :public, :visibility => visibility, :name => name, :type => type, :value => nil}
  end

  # Adds a property into object (visibility, name, type and value)
  def add_property(visibility : Symbol, name : String, type : String, value : String) : Nil
    @properties << {:scope => :public, :visibility => visibility, :name => name, :type => type, :value => value}
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
