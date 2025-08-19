require "./../spec_helper"

describe Crygen::Types::Class do
  describe "abstract class" do
    it "creates an abstract class" do
      expected = <<-CRYSTAL
      abstract class Person
      end
      CRYSTAL

      class_type = test_person_class().as_abstract
      class_type.generate.should eq(expected)
      class_type.to_s.should eq(expected)
    end

    it "creates an abstract class with one abstract method" do
      expected = <<-CRYSTAL
      abstract class Person
        abstract def full_name : String
      end
      CRYSTAL

      class_type = test_person_class()
      class_type.as_abstract
      class_type.add_method(CGT::Method.new("full_name", "String").as_abstract)
      class_type.generate.should eq(expected)
      class_type.to_s.should eq(expected)
    end

    it "creates an abstract class with many abstract methods" do
      expected = <<-CRYSTAL
      abstract class Person
        abstract def first_name : String
        abstract def last_name : String
        abstract def full_name : String
      end
      CRYSTAL

      class_type = test_person_class()
      class_type.as_abstract
      class_type.add_methods(
        CGT::Method.new("first_name", "String").as_abstract,
        CGT::Method.new("last_name", "String").as_abstract,
        CGT::Method.new("full_name", "String").as_abstract
      )
      class_type.generate.should eq(expected)
      class_type.to_s.should eq(expected)
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
      class_type.as_abstract
      class_type.add_methods(
        CGT::Method.new("abstract_method", "String").as_abstract,
        CGT::Method.new("non_abstract_method", "String").add_body("Hello world".dump)
      )
      class_type.generate.should eq(expected)
      class_type.to_s.should eq(expected)
    end

    it "creates an abstract class with one line comment" do
      expected = <<-CRYSTAL
      # This is an example class concerning a person.
      abstract class Person
      end
      CRYSTAL

      class_type = test_person_class()
      class_type.as_abstract
      class_type.add_comment("This is an example class concerning a person.")
      class_type.generate.should eq(expected)
      class_type.to_s.should eq(expected)
    end

    it "creates an abstract class with multiple lines comment" do
      class_type = test_person_class().as_abstract.add_comment(<<-STR)
      This is a multiline comment.
      The name class is Person.
      STR

      expected = <<-CRYSTAL
      # This is a multiline comment.
      # The name class is Person.
      abstract class Person
      end
      CRYSTAL

      class_type.generate.should eq(expected)
      class_type.to_s.should eq(expected)
    end
  end
end
