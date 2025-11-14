require "./../spec_helper"

describe Crygen::Types::Struct do
  it "creates a struct with one instance var" do
    expected = <<-CRYSTAL
      struct Point
        @full_name : String
      end
      CRYSTAL

    struct_type = test_point_struct()
      .add_instance_var("full_name", "String")

    assert_is_expected(struct_type, expected)
  end

  it "creates a struct with one instance var with the default value" do
    expected = <<-CRYSTAL
      struct Point
        @full_name : String = "John Doe"
      end
      CRYSTAL

    struct_type = test_point_struct()
      .add_instance_var("full_name", "String", "John Doe")

    assert_is_expected(struct_type, expected)
  end

  it "creates a struct with many instance vars" do
    expected = <<-CRYSTAL
      struct Point
        @first_name : String
        @last_name : String
      end
      CRYSTAL

    struct_type = test_point_struct()
      .add_instance_var("first_name", "String")
      .add_instance_var("last_name", "String")

    assert_is_expected(struct_type, expected)
  end

  it "creates a struct with many instance vars (annotations only)" do
    expected = <<-CRYSTAL
      struct Point
        @[Information]
        @first_name : String

        @[Information]
        @last_name : String
      end
      CRYSTAL

    the_annotation = CGT::Annotation.new("Information")

    struct_type = test_point_struct()
      .add_instance_var("first_name", "String", the_annotation: the_annotation)
      .add_instance_var("last_name", "String", the_annotation: the_annotation)

    assert_is_expected(struct_type, expected)
  end

  it "creates a struct with many instance vars (annotations only)" do
    expected = <<-CRYSTAL
      struct Point
        @age : Int32
        @first_name : String

        @[Information]
        @last_name : String
      end
      CRYSTAL

    the_annotation = CGT::Annotation.new("Information")

    struct_type = test_point_struct()
      .add_instance_var("age", "Int32")
      .add_instance_var("first_name", "String")
      .add_instance_var("last_name", "String", the_annotation: the_annotation)

    assert_is_expected(struct_type, expected)
  end

  it "creates a struct with many instance vars with one default value" do
    expected = <<-CRYSTAL
      struct Point
        @first_name : String = "John"
        @last_name : String
      end
      CRYSTAL

    struct_type = test_point_struct()
      .add_instance_var("first_name", "String", "John")
      .add_instance_var("last_name", "String")

    assert_is_expected(struct_type, expected)
  end

  it "creates a struct with many instance vars with default values" do
    expected = <<-CRYSTAL
      struct Point
        @first_name : String = "John"
        @last_name : String = "Doe"
      end
      CRYSTAL

    struct_type = test_point_struct()
      .add_instance_var("first_name", "String", "John")
      .add_instance_var("last_name", "String", "Doe")

    assert_is_expected(struct_type, expected)
  end
end
