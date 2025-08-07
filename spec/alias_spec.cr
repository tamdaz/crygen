require "./spec_helper"

describe Crygen::Types::Alias do
  it "creates an alias" do
    alias_type = Crygen::Types::Alias.new("MyAlias", ["Foo"])
    alias_type.generate.should eq("alias MyAlias = Foo")
    alias_type.to_s.should eq("alias MyAlias = Foo")
  end

  it "creates an alias with unions" do
    alias_type_generate = Crygen::Types::Alias.new("MyAlias", %w[Foo Bar])
    alias_type_generate.generate.should eq("alias MyAlias = Foo | Bar")
    alias_type_generate.to_s.should eq("alias MyAlias = Foo | Bar")

    alias_type_to_s = Crygen::Types::Alias.new("MyAlias", %w[A::Foo B::Foo C::Bar D::Bar])
    alias_type_to_s.generate.should eq("alias MyAlias = A::Foo | B::Foo | C::Bar | D::Bar")
    alias_type_to_s.to_s.should eq("alias MyAlias = A::Foo | B::Foo | C::Bar | D::Bar")
  end
end
