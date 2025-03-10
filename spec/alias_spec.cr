require "./spec_helper"

describe Crygen::Types::Alias do
  it "creates an alias" do
    Crygen::Types::Alias.new("MyAlias", %w[Foo Bar]).generate.should eq(<<-CRYSTAL)
    alias MyAlias = Foo | Bar
    CRYSTAL
  end
end
