require "./../spec_helper"

describe Crygen::Types::Class do
  it "creates a class" do
    class_type = test_person_class()
    class_type.generate.should eq(<<-CRYSTAL)
    class Person
    end
    CRYSTAL
  end

  it "creates a class with one line comment" do
    class_type = test_person_class()
    class_type.add_comment("This is an example class concerning a person.")
    class_type.generate.should eq(<<-CRYSTAL)
    # This is an example class concerning a person.
    class Person
    end
    CRYSTAL
  end

  it "creates a class with multiple lines comment" do
    class_type = test_person_class()
    class_type.add_comment(<<-STR)
    This is a multiline comment.
    The name class is Person.
    STR

    class_type.generate.should eq(<<-CRYSTAL)
    # This is a multiline comment.
    # The name class is Person.
    class Person
    end
    CRYSTAL
  end
end
