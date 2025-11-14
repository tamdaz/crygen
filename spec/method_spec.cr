require "./spec_helper"

describe Crygen::Types::Method do
  it "creates a public method" do
    expected = <<-CRYSTAL
    def full_name : String
    end
    CRYSTAL

    method_type = CGT::Method.new("full_name", "String")

    assert_is_expected(method_type, expected)
  end

  it "creates a method with an annotation" do
    expected = <<-CRYSTAL
    @[Experimental]
    def full_name : String
    end
    CRYSTAL

    method_type = CGT::Method.new("full_name", "String")
      .add_annotation(CGT::Annotation.new("Experimental"))

    assert_is_expected(method_type, expected)
  end

  it "creates a method with more annotations" do
    expected = <<-CRYSTAL
    @[Experimental]
    @[MyAnnotation]
    def full_name : String
    end
    CRYSTAL

    method_type = CGT::Method.new("full_name", "String")
      .add_annotations(
        CGT::Annotation.new("Experimental"),
        CGT::Annotation.new("MyAnnotation")
      )

    assert_is_expected(method_type, expected)
  end

  it "creates a method with body" do
    expected = <<-CRYSTAL
    def full_name : String
      # This comment is in method body
      "John Doe"
    end
    CRYSTAL

    method_type = CGT::Method.new("full_name", "String")
      .add_body(<<-CRYSTAL)
      # This comment is in method body
      "John Doe"
      CRYSTAL

    assert_is_expected(method_type, expected)
  end

  it "creates a protected method" do
    expected = <<-CRYSTAL
    protected def date_birth : String
    end
    CRYSTAL

    assert_is_expected(CGT::Method.new("date_birth", "String").as_protected, expected)
  end

  it "creates a private method" do
    expected = <<-CRYSTAL
    private def date_birth : String
    end
    CRYSTAL

    assert_is_expected(CGT::Method.new("date_birth", "String").as_private, expected)
  end

  it "creates a method with one arg" do
    expected = <<-CRYSTAL
    def major?(age : Int8) : Bool
    end
    CRYSTAL

    assert_is_expected(CGT::Method.new("major?", "Bool").add_arg("age", "Int8"), expected)
  end

  it "creates a method with one default value arg" do
    expected = <<-CRYSTAL
    def major?(age : Int8 = 22) : Bool
    end
    CRYSTAL

    assert_is_expected(CGT::Method.new("major?", "Bool").add_arg("age", "Int8", "22"), expected)
  end

  it "creates a method with many args" do
    expected = <<-CRYSTAL
    def major?(age : Int8, min_majority : Int8) : Bool
    end
    CRYSTAL

    method_type = CGT::Method.new("major?", "Bool")
      .add_arg("age", "Int8")
      .add_arg("min_majority", "Int8")

    assert_is_expected(method_type, expected)
  end

  it "creates a method with one default arg on many args" do
    expected = <<-CRYSTAL
    def major?(age : Int8, min_majority : Int8 = 22) : Bool
    end
    CRYSTAL

    method_type = CGT::Method.new("major?", "Bool")
      .add_arg("age", "Int8")
      .add_arg("min_majority", "Int8", "22")

    assert_is_expected(method_type, expected)
  end

  it "creates a method with many args" do
    expected = <<-CRYSTAL
    def major?(age : Int8 = 18, min_majority : Int8 = 22) : Bool
    end
    CRYSTAL

    method_type = CGT::Method.new("major?", "Bool")
      .add_arg("age", "Int8", "18")
      .add_arg("min_majority", "Int8", "22")

    assert_is_expected(method_type, expected)
  end

  it "adds several arguments with #add_args" do
    expected = <<-CRYSTAL
    def foo(bar : String, age : Int32 = 42, flag : Bool) : Nil
    end
    CRYSTAL

    method_type = CGT::Method.new("foo", "Nil")
      .add_args(
        {"bar", "String", nil},
        {"age", "Int32", "42"},
        {"flag", "Bool", nil}
      )

    assert_is_expected(method_type, expected)
  end

  it "creates an abstract method" do
    expected = <<-CRYSTAL
    abstract def major?(age : Int8 = 18, min_majority : Int8 = 22) : Bool
    CRYSTAL

    method_type = CGT::Method.new("major?", "Bool")
      .add_arg("age", "Int8", "18")
      .add_arg("min_majority", "Int8", "22")
      .as_abstract

    assert_is_expected(method_type, expected)
  end

  it "creates a protected abstract method" do
    expected = <<-CRYSTAL
    protected abstract def major?(age : Int8 = 18, min_majority : Int8 = 22) : Bool
    CRYSTAL

    method_type = CGT::Method.new("major?", "Bool")
      .add_arg("age", "Int8", "18")
      .add_arg("min_majority", "Int8", "22")
      .as_protected
      .as_abstract

    assert_is_expected(method_type, expected)
  end

  it "creates a private abstract method" do
    expected = <<-CRYSTAL
    private abstract def major?(age : Int8 = 18, min_majority : Int8 = 22) : Bool
    CRYSTAL

    method_type = CGT::Method.new("major?", "Bool")
      .add_arg("age", "Int8", "18")
      .add_arg("min_majority", "Int8", "22")
      .as_private
      .as_abstract

    assert_is_expected(method_type, expected)
  end
end
