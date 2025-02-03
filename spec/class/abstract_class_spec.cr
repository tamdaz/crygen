require "./../spec_helper"

describe Crygen::Types::Class do
  describe "abstract class" do
    it "creates an abstract class" do
      test_person_class().as_abstract.generate.should eq(<<-CRYSTAL)
      abstract class Person
      end
      CRYSTAL
    end

    it "creates an abstract class with one abstract method" do
      class_type = test_person_class()
      class_type.as_abstract
      class_type.add_method(CGT::Method.new("full_name", "String"))
      class_type.generate.should eq(<<-CRYSTAL)
      abstract class Person
        abstract def full_name : String
      end
      CRYSTAL
    end

    it "creates an abstract class with many abstract methods" do
      first_name_method = CGT::Method.new("first_name", "String")
      last_name_method = CGT::Method.new("last_name", "String")
      full_name_method = CGT::Method.new("full_name", "String")
      class_type = test_person_class()
      class_type.as_abstract
      class_type.add_method(first_name_method).add_method(last_name_method).add_method(full_name_method)
      class_type.generate.should eq(<<-CRYSTAL)
      abstract class Person
        abstract def first_name : String
        abstract def last_name : String
        abstract def full_name : String
      end
      CRYSTAL
    end

    it "creates an abstract class with one line comment" do
      class_type = test_person_class()
      class_type.as_abstract
      class_type.add_comment("This is an example class concerning a person.")
      class_type.generate.should eq(<<-CRYSTAL)
      # This is an example class concerning a person.
      abstract class Person
      end
      CRYSTAL
    end

    it "creates an abstract class with multiple lines comment" do
      class_type = test_person_class().as_abstract.add_comment(<<-STR)
      This is a multiline comment.
      The name class is Person.
      STR

      class_type.generate.should eq(<<-CRYSTAL)
      # This is a multiline comment.
      # The name class is Person.
      abstract class Person
      end
      CRYSTAL
    end
  end
end
