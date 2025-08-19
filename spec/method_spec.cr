require "./spec_helper"

describe Crygen::Types::Method do
  it "creates a public method" do
    expected = <<-CRYSTAL
    def full_name : String
    end
    CRYSTAL

    method_type = CGT::Method.new("full_name", "String")
    method_type.generate.should eq(expected)
    method_type.to_s.should eq(expected)
  end

  it "creates a method with an annotation" do
    expected = <<-CRYSTAL
    @[Experimental]
    def full_name : String
    end
    CRYSTAL

    method_type = CGT::Method.new("full_name", "String")
    method_type.add_annotation(CGT::Annotation.new("Experimental"))
    method_type.generate.should eq(expected)
    method_type.to_s.should eq(expected)
  end

  it "creates a method with more annotations" do
    expected = <<-CRYSTAL
    @[Experimental]
    @[MyAnnotation]
    def full_name : String
    end
    CRYSTAL

    method_type = CGT::Method.new("full_name", "String")
    method_type.add_annotations(
      CGT::Annotation.new("Experimental"),
      CGT::Annotation.new("MyAnnotation")
    )
    method_type.generate.should eq(expected)
    method_type.to_s.should eq(expected)
  end

  it "creates a method with body" do
    expected = <<-CRYSTAL
    def full_name : String
      # This comment is in method body
      "John Doe"
    end
    CRYSTAL

    method_type = CGT::Method.new("full_name", "String")
    method_type.add_body(<<-CRYSTAL)
    # This comment is in method body
    "John Doe"
    CRYSTAL

    method_type.generate.should eq(expected)
    method_type.to_s.should eq(expected)
  end

  it "creates a protected method" do
    expected = <<-CRYSTAL
    protected def date_birth : String
    end
    CRYSTAL

    CGT::Method.new("date_birth", "String").as_protected.generate.should eq(expected)
    CGT::Method.new("date_birth", "String").as_protected.to_s.should eq(expected)
  end

  it "creates a private method" do
    expected = <<-CRYSTAL
    private def date_birth : String
    end
    CRYSTAL

    CGT::Method.new("date_birth", "String").as_private.generate.should eq(expected)
    CGT::Method.new("date_birth", "String").as_private.to_s.should eq(expected)
  end

  it "creates a method with one arg" do
    expected = <<-CRYSTAL
    def major?(age : Int8) : Bool
    end
    CRYSTAL

    CGT::Method.new("major?", "Bool").add_arg("age", "Int8").generate.should eq(expected)
    CGT::Method.new("major?", "Bool").add_arg("age", "Int8").to_s.should eq(expected)
  end

  it "creates a method with one default value arg" do
    expected = <<-CRYSTAL
    def major?(age : Int8 = 22) : Bool
    end
    CRYSTAL

    CGT::Method.new("major?", "Bool").add_arg("age", "Int8", "22").generate.should eq(expected)
    CGT::Method.new("major?", "Bool").add_arg("age", "Int8", "22").to_s.should eq(expected)
  end

  it "creates a method with many args" do
    expected = <<-CRYSTAL
    def major?(age : Int8, min_majority : Int8) : Bool
    end
    CRYSTAL

    method_type = CGT::Method.new("major?", "Bool")
    method_type.add_arg("age", "Int8")
    method_type.add_arg("min_majority", "Int8")
    method_type.generate.should eq(expected)
    method_type.to_s.should eq(expected)
  end

  it "creates a method with one default arg on many args" do
    expected = <<-CRYSTAL
    def major?(age : Int8, min_majority : Int8 = 22) : Bool
    end
    CRYSTAL

    method_type = CGT::Method.new("major?", "Bool")
    method_type.add_arg("age", "Int8")
    method_type.add_arg("min_majority", "Int8", "22")
    method_type.generate.should eq(expected)
    method_type.to_s.should eq(expected)
  end

  it "creates a method with many args" do
    expected = <<-CRYSTAL
    def major?(age : Int8 = 18, min_majority : Int8 = 22) : Bool
    end
    CRYSTAL

    method_type = CGT::Method.new("major?", "Bool")
    method_type.add_arg("age", "Int8", "18")
    method_type.add_arg("min_majority", "Int8", "22")
    method_type.generate.should eq(expected)
    method_type.to_s.should eq(expected)
  end

  it "adds several arguments with #add_args" do
    expected = <<-CRYSTAL
    def foo(bar : String, age : Int32 = 42, flag : Bool) : Nil
    end
    CRYSTAL

    method_type = CGT::Method.new("foo", "Nil")
    method_type.add_args(
      {"bar", "String", nil},
      {"age", "Int32", "42"},
      {"flag", "Bool", nil}
    )

    method_type.generate.should eq(expected)
    method_type.to_s.should eq(expected)
  end
end
