require "./spec_helper"

describe Crygen::Types::Alias do
  it "creates an alias" do
    expected = <<-CRYSTAL
    alias MyAlias = Foo
    CRYSTAL

    alias_type = Crygen::Types::Alias.new("MyAlias", ["Foo"])

    assert_is_expected(alias_type, expected)
  end

  it "creates an alias with unions" do
    expected = <<-CRYSTAL
    alias MyAlias = Foo | Bar
    CRYSTAL

    alias_type = Crygen::Types::Alias.new("MyAlias", %w[Foo Bar])

    assert_is_expected(alias_type, expected)

    expected = <<-CRYSTAL
    alias MyAlias = A::Foo | B::Foo | C::Bar | D::Bar
    CRYSTAL

    alias_type = Crygen::Types::Alias.new("MyAlias", %w[A::Foo B::Foo C::Bar D::Bar])

    assert_is_expected(alias_type, expected)
  end

  it "creates an alias with comment" do
    expected = <<-CRYSTAL
    # This is my alias
    alias MyAlias = Foo
    CRYSTAL

    alias_type = Crygen::Types::Alias.new("MyAlias", ["Foo"])
      .add_comment("This is my alias")

    assert_is_expected(alias_type, expected)
  end
end
