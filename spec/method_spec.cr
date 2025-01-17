require "./spec_helper"

describe Crygen::Types::Method do
  it "creates a public method" do
    method_type = CGT::Method.new("full_name", "String")
    method_type.generate.should eq(<<-CRYSTAL)
    def full_name : String
    end
    CRYSTAL
  end

  it "creates a method with body" do
    method_type = CGT::Method.new("full_name", "String")
    method_type.add_body(<<-CRYSTAL)
    # This comment is in method body
    "John Doe"
    CRYSTAL
    method_type.generate.should eq(<<-CRYSTAL)
    def full_name : String
      # This comment is in method body
      "John Doe"
    end
    CRYSTAL
  end

  it "creates a protected method" do
    method_type = CGT::Method.new("date_birth", "String")
    method_type.as_protected
    method_type.generate.should eq(<<-CRYSTAL)
    protected def date_birth : String
    end
    CRYSTAL
  end

  it "creates a private method" do
    method_type = CGT::Method.new("date_birth", "String")
    method_type.as_private
    method_type.generate.should eq(<<-CRYSTAL)
    private def date_birth : String
    end
    CRYSTAL
  end

  it "creates a method with one arg" do
    method_type = CGT::Method.new("major?", "Bool")
    method_type.add_arg("age", "Int8")
    method_type.generate.should eq(<<-CRYSTAL)
    def major?(age : Int8) : Bool
    end
    CRYSTAL
  end

  it "creates a method with one default value arg" do
    method_type = CGT::Method.new("major?", "Bool")
    method_type.add_arg("age", "Int8", "22")
    method_type.generate.should eq(<<-CRYSTAL)
    def major?(age : Int8 = 22) : Bool
    end
    CRYSTAL
  end

  it "creates a method with many args" do
    method_type = CGT::Method.new("major?", "Bool")
    method_type.add_arg("age", "Int8")
    method_type.add_arg("min_majority", "Int8")
    method_type.generate.should eq(<<-CRYSTAL)
    def major?(age : Int8, min_majority : Int8) : Bool
    end
    CRYSTAL
  end

  it "creates a method with one default arg on many args" do
    method_type = CGT::Method.new("major?", "Bool")
    method_type.add_arg("age", "Int8")
    method_type.add_arg("min_majority", "Int8", "22")
    method_type.generate.should eq(<<-CRYSTAL)
    def major?(age : Int8, min_majority : Int8 = 22) : Bool
    end
    CRYSTAL
  end

  it "creates a method with many args" do
    method_type = CGT::Method.new("major?", "Bool")
    method_type.add_arg("age", "Int8", "18")
    method_type.add_arg("min_majority", "Int8", "22")
    method_type.generate.should eq(<<-CRYSTAL)
    def major?(age : Int8 = 18, min_majority : Int8 = 22) : Bool
    end
    CRYSTAL
  end
end
