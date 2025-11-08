require "./spec_helper"

describe Crygen::Types::Alias do
  it "creates an alias" do
    expected = <<-CRYSTAL
    alias MyAlias = Foo
    CRYSTAL

    alias_type = Crygen::Types::Alias.new("MyAlias", ["Foo"])
    alias_type.generate.should eq(expected)
    alias_type.to_s.should eq(expected)
  end

  it "creates an alias with unions" do
    expected = <<-CRYSTAL
    alias MyAlias = Foo | Bar
    CRYSTAL

    alias_type_generate = Crygen::Types::Alias.new("MyAlias", %w[Foo Bar])
    alias_type_generate.generate.should eq(expected)
    alias_type_generate.to_s.should eq(expected)

    expected = <<-CRYSTAL
    alias MyAlias = A::Foo | B::Foo | C::Bar | D::Bar
    CRYSTAL

    alias_type_union = Crygen::Types::Alias.new("MyAlias", %w[A::Foo B::Foo C::Bar D::Bar])
    alias_type_union.generate.should eq(expected)
    alias_type_union.to_s.should eq(expected)
  end

  it "creates an alias with comment" do
    expected = <<-CRYSTAL
    # This is my alias
    alias MyAlias = Foo
    CRYSTAL

    alias_type = Crygen::Types::Alias.new("MyAlias", ["Foo"])
    alias_type.add_comment("This is my alias")
    alias_type.generate.should eq(expected)
    alias_type.to_s.should eq(expected)
  end
end
