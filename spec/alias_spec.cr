require "./spec_helper"

describe Crygen::Types::Alias do
  it "creates an alias" do
    Crygen::Types::Alias.new("MyAlias", ["Foo"]).generate.should eq(<<-CRYSTAL)
    alias MyAlias = Foo
    CRYSTAL
  end

  it "creates an alias with unions" do
    Crygen::Types::Alias.new("MyAlias", %w[Foo Bar]).generate.should eq(<<-CRYSTAL)
    alias MyAlias = Foo | Bar
    CRYSTAL

    Crygen::Types::Alias.new("MyAlias", %w[A::Foo B::Foo C::Bar D::Bar]).generate.should eq(<<-CRYSTAL)
    alias MyAlias = A::Foo | B::Foo | C::Bar | D::Bar
    CRYSTAL
  end
end
