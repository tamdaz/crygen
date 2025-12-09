require "./../spec_helper"

describe "(class vars only)" do
  it "creates a class with one class var" do
    expected = <<-CRYSTAL
    class Person
      @@full_name : String
    end
    CRYSTAL

    class_type = test_person_class()
      .add_class_var("full_name", "String")

    assert_is_expected(class_type, expected)
  end

  it "creates a class with one class var with the default value" do
    expected = <<-CRYSTAL
    class Person
      @@full_name : String = "John Doe"
    end
    CRYSTAL

    class_type = test_person_class()
      .add_class_var("full_name", "String", "John Doe")

    assert_is_expected(class_type, expected)
  end

  it "creates a class with many class vars" do
    expected = <<-CRYSTAL
    class Person
      @@first_name : String
      @@last_name : String
    end
    CRYSTAL

    class_type = test_person_class()
      .add_class_var("first_name", "String")
      .add_class_var("last_name", "String")

    assert_is_expected(class_type, expected)
  end

  it "creates a class with many class vars (annotations only)" do
    expected = <<-CRYSTAL
    class Person
      @[Information]
      @@first_name : String

      @[Information]
      @@last_name : String
    end
    CRYSTAL

    the_annotation = CGT::Annotation.new("Information")

    class_type = test_person_class()
      .add_class_var("first_name", "String", the_annotation: the_annotation)
      .add_class_var("last_name", "String", the_annotation: the_annotation)

    assert_is_expected(class_type, expected)
  end

  it "creates a class with many class vars (one annotation)" do
    expected = <<-CRYSTAL
    class Person
      @@age : Int32
      @@first_name : String

      @[Information]
      @@last_name : String
    end
    CRYSTAL

    the_annotation = CGT::Annotation.new("Information")

    class_type = test_person_class()
      .add_class_var("age", "Int32")
      .add_class_var("first_name", "String")
      .add_class_var("last_name", "String", the_annotation: the_annotation)

    assert_is_expected(class_type, expected)
  end

  it "creates a class with many class vars with one default value" do
    expected = <<-CRYSTAL
    class Person
      @@first_name : String = "John"
      @@last_name : String
    end
    CRYSTAL

    class_type = test_person_class()
      .add_class_var("first_name", "String", "John")
      .add_class_var("last_name", "String")

    assert_is_expected(class_type, expected)
  end

  it "creates a class with many class vars with default values" do
    expected = <<-CRYSTAL
    class Person
      @@first_name : String = "John"
      @@last_name : String = "Doe"
    end
    CRYSTAL

    class_type = test_person_class()
      .add_class_var("first_name", "String", "John")
      .add_class_var("last_name", "String", "Doe")

    assert_is_expected(class_type, expected)
  end

  it "creates a class with many class and instance vars" do
    expected = <<-CRYSTAL
    class Person
      @first_name : String
      @last_name : String

      @@another_first_name : String
      @@another_last_name : String
    end
    CRYSTAL

    class_type = test_person_class()
      .add_instance_var("first_name", "String")
      .add_instance_var("last_name", "String")
      .add_class_var("another_first_name", "String")
      .add_class_var("another_last_name", "String")

    assert_is_expected(class_type, expected)
  end
end
