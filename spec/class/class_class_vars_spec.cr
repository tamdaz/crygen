require "./../spec_helper"

describe "(class vars only)" do
  it "creates a class with one class var" do
    expected = <<-CRYSTAL
    class Person
      @@full_name : String
    end
    CRYSTAL

    class_type = test_person_class().add_class_var("full_name", "String")
    class_type.generate.should eq(expected)
    class_type.to_s.should eq(expected)
  end

  it "creates a class with one class var with the default value" do
    expected = <<-CRYSTAL
    class Person
      @@full_name : String = "John Doe"
    end
    CRYSTAL

    class_type = test_person_class().add_class_var("full_name", "String", "John Doe")
    class_type.generate.should eq(expected)
    class_type.to_s.should eq(expected)
  end

  it "creates a class with many class vars" do
    expected = <<-CRYSTAL
    class Person
      @@first_name : String
      @@last_name : String
    end
    CRYSTAL

    class_type = test_person_class()
    class_type.add_class_var("first_name", "String")
    class_type.add_class_var("last_name", "String")
    class_type.generate.should eq(expected)
    class_type.to_s.should eq(expected)
  end

  it "creates a class with many class vars with one default value" do
    expected = <<-CRYSTAL
    class Person
      @@first_name : String = "John"
      @@last_name : String
    end
    CRYSTAL

    class_type = test_person_class()
    class_type.add_class_var("first_name", "String", "John")
    class_type.add_class_var("last_name", "String")
    class_type.generate.should eq(expected)
    class_type.to_s.should eq(expected)
  end

  it "creates a class with many class vars with default values" do
    expected = <<-CRYSTAL
    class Person
      @@first_name : String = "John"
      @@last_name : String = "Doe"
    end
    CRYSTAL

    class_type = test_person_class()
    class_type.add_class_var("first_name", "String", "John")
    class_type.add_class_var("last_name", "String", "Doe")
    class_type.generate.should eq(expected)
    class_type.to_s.should eq(expected)
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
    class_type.add_instance_var("first_name", "String")
    class_type.add_instance_var("last_name", "String")
    class_type.add_class_var("another_first_name", "String")
    class_type.add_class_var("another_last_name", "String")
    class_type.generate.should eq(expected)
    class_type.to_s.should eq(expected)
  end
end
