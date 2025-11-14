require "./../spec_helper"

describe Crygen::Types::Class do
  describe "(instance vars only)" do
    it "creates a class with one instance var" do
      expected = <<-CRYSTAL
      class Person
        @full_name : String
      end
      CRYSTAL

      class_type = test_person_class()
        .add_instance_var("full_name", "String")

      assert_is_expected(class_type, expected)
    end

    it "creates a class with one instance var with the default value" do
      expected = <<-CRYSTAL
      class Person
        @full_name : String = "John Doe"
      end
      CRYSTAL

      class_type = test_person_class()
        .add_instance_var("full_name", "String", "John Doe")

      assert_is_expected(class_type, expected)
    end

    it "creates a class with many instance vars" do
      expected = <<-CRYSTAL
      class Person
        @first_name : String
        @last_name : String
      end
      CRYSTAL

      class_type = test_person_class()
        .add_instance_var("first_name", "String")
        .add_instance_var("last_name", "String")

      assert_is_expected(class_type, expected)
    end

    it "creates a class with many instance vars" do
      expected = <<-CRYSTAL
      class Person
        @[Information]
        @first_name : String

        @[Information]
        @last_name : String
      end
      CRYSTAL

      the_annotation = CGT::Annotation.new("Information")

      class_type = test_person_class()
        .add_instance_var("first_name", "String", annotations: [the_annotation])
        .add_instance_var("last_name", "String", annotations: [the_annotation])

      assert_is_expected(class_type, expected)
    end

    it "creates a class with many instance vars" do
      expected = <<-CRYSTAL
      class Person
        @age : Int32
        @first_name : String

        @[Information]
        @last_name : String
      end
      CRYSTAL

      the_annotation = CGT::Annotation.new("Information")

      class_type = test_person_class()
        .add_instance_var("age", "Int32")
        .add_instance_var("first_name", "String")
        .add_instance_var("last_name", "String", annotations: [the_annotation])

      assert_is_expected(class_type, expected)
    end

    it "creates a class with many instance vars with one default value" do
      expected = <<-CRYSTAL
      class Person
        @first_name : String = "John"
        @last_name : String
      end
      CRYSTAL

      class_type = test_person_class()
        .add_instance_var("first_name", "String", "John")
        .add_instance_var("last_name", "String")

      assert_is_expected(class_type, expected)
    end

    it "creates a class with many instance vars with default values" do
      expected = <<-CRYSTAL
      class Person
        @first_name : String = "John"
        @last_name : String = "Doe"
      end
      CRYSTAL

      class_type = test_person_class()
        .add_instance_var("first_name", "String", "John")
        .add_instance_var("last_name", "String", "Doe")

      assert_is_expected(class_type, expected)
    end
  end
end
