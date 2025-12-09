require "./../spec_helper"

describe Crygen::Types::Class do
  describe "abstract class" do
    it "creates an abstract class" do
      expected = <<-CRYSTAL
      abstract class Person
      end
      CRYSTAL

      class_type = test_person_class().as_abstract

      assert_is_expected(class_type, expected)
    end

    it "creates an abstract class with one abstract method" do
      expected = <<-CRYSTAL
      abstract class Person
        abstract def full_name : String
      end
      CRYSTAL

      class_type = test_person_class()
        .add_method(CGT::Method.new("full_name", "String").as_abstract)
        .as_abstract

      assert_is_expected(class_type, expected)
    end

    it "creates an abstract class with one abstract method with comment" do
      expected = <<-CRYSTAL
      abstract class Person
        # Returns the full name
        abstract def full_name : String
      end
      CRYSTAL

      method_full_name = CGT::Method.new("full_name", "String")
        .add_comment("Returns the full name")
        .as_abstract

      class_type = test_person_class()
        .add_method(method_full_name)
        .as_abstract

      assert_is_expected(class_type, expected)
    end

    it "creates an abstract class with many abstract methods" do
      expected = <<-CRYSTAL
      abstract class Person
        abstract def first_name : String
        abstract def last_name : String
        abstract def full_name : String
      end
      CRYSTAL

      class_type = test_person_class().as_abstract
      class_type.add_methods(
        CGT::Method.new("first_name", "String").as_abstract,
        CGT::Method.new("last_name", "String").as_abstract,
        CGT::Method.new("full_name", "String").as_abstract
      )

      assert_is_expected(class_type, expected)
    end

    it "creates an abstract class with a few abstract and normal methods" do
      expected = <<-CRYSTAL
      abstract class Person
        abstract def first_name : String
        abstract def last_name : String
        abstract def full_name : String

        def majority : Int32
        end

        def date_birth : Time
        end
      end
      CRYSTAL

      class_type = test_person_class().as_abstract
      class_type.add_methods(
        CGT::Method.new("first_name", "String").as_abstract,
        CGT::Method.new("last_name", "String").as_abstract,
        CGT::Method.new("full_name", "String").as_abstract,
        CGT::Method.new("majority", "Int32"),
        CGT::Method.new("date_birth", "Time")
      )

      assert_is_expected(class_type, expected)
    end

    it "creates an abstract class with a few abstract and normal methods (with comments)" do
      expected = <<-CRYSTAL
      abstract class Person
        # Returns the first name
        abstract def first_name : String

        # Returns the last name
        abstract def last_name : String

        # Returns the full name
        abstract def full_name : String

        # Returns the age majority
        def majority : Int32
        end

        # Returns the date birth
        def date_birth : Time
        end
      end
      CRYSTAL

      class_type = test_person_class()
        .add_methods(
          CGT::Method.new("first_name", "String").add_comment("Returns the first name").as_abstract,
          CGT::Method.new("last_name", "String").add_comment("Returns the last name").as_abstract,
          CGT::Method.new("full_name", "String").add_comment("Returns the full name").as_abstract,
          CGT::Method.new("majority", "Int32").add_comment("Returns the age majority"),
          CGT::Method.new("date_birth", "Time").add_comment("Returns the date birth")
        )
        .as_abstract

      assert_is_expected(class_type, expected)
    end

    it "creates an abstract class with many abstract methods (comment for each abstract method)" do
      expected = <<-CRYSTAL
      abstract class Person
        # Returns the first name
        abstract def first_name : String

        # Returns the last name
        abstract def last_name : String

        # Returns the full name
        abstract def full_name : String
      end
      CRYSTAL

      class_type = test_person_class()
        .add_methods(
          CGT::Method.new("first_name", "String").add_comment("Returns the first name").as_abstract,
          CGT::Method.new("last_name", "String").add_comment("Returns the last name").as_abstract,
          CGT::Method.new("full_name", "String").add_comment("Returns the full name").as_abstract
        )
        .as_abstract

      assert_is_expected(class_type, expected)
    end

    it "creates an abstract class with abstract and non-abstract methods" do
      expected = <<-CRYSTAL
      abstract class Person
        abstract def abstract_method : String

        def non_abstract_method : String
          "Hello world"
        end
      end
      CRYSTAL

      class_type = test_person_class()
        .add_methods(
          CGT::Method.new("abstract_method", "String").as_abstract,
          CGT::Method.new("non_abstract_method", "String").add_body("Hello world".dump)
        ).as_abstract

      assert_is_expected(class_type, expected)
    end

    it "creates an abstract class with one line comment" do
      expected = <<-CRYSTAL
      # This is an example class concerning a person.
      abstract class Person
      end
      CRYSTAL

      class_type = test_person_class()
        .add_comment("This is an example class concerning a person.")
        .as_abstract

      assert_is_expected(class_type, expected)
    end

    it "creates an abstract class with multiple lines comment" do
      expected = <<-CRYSTAL
      # This is a multiline comment.
      # The name class is Person.
      abstract class Person
      end
      CRYSTAL

      class_type = test_person_class().as_abstract.add_comment(<<-STR)
      This is a multiline comment.
      The name class is Person.
      STR

      assert_is_expected(class_type, expected)
    end
  end
end
