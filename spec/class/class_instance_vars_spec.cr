require "./../spec_helper"

describe Crygen::Types::Class do
  describe "(instance vars only)" do
    it "creates a class with one instance var" do
      expected = <<-CRYSTAL
      class Person
        @full_name : String
      end
      CRYSTAL

      class_type = test_person_class().add_instance_var("full_name", "String")
      class_type.generate.should eq(expected)
      class_type.to_s.should eq(expected)
    end

    it "creates a class with one instance var with the default value" do
      expected = <<-CRYSTAL
      class Person
        @full_name : String = "John Doe"
      end
      CRYSTAL

      class_type = test_person_class().add_instance_var("full_name", "String", "John Doe")
      class_type.generate.should eq(expected)
      class_type.to_s.should eq(expected)
    end

    it "creates a class with many instance vars" do
      expected = <<-CRYSTAL
      class Person
        @first_name : String
        @last_name : String
      end
      CRYSTAL

      class_type = test_person_class()
      class_type.add_instance_var("first_name", "String")
      class_type.add_instance_var("last_name", "String")
      class_type.generate.should eq(expected)
      class_type.to_s.should eq(expected)
    end

    it "creates a class with many instance vars with one default value" do
      expected = <<-CRYSTAL
      class Person
        @first_name : String = "John"
        @last_name : String
      end
      CRYSTAL

      class_type = test_person_class()
      class_type.add_instance_var("first_name", "String", "John")
      class_type.add_instance_var("last_name", "String")
      class_type.generate.should eq(expected)
      class_type.to_s.should eq(expected)
    end

    it "creates a class with many instance vars with default values" do
      expected = <<-CRYSTAL
      class Person
        @first_name : String = "John"
        @last_name : String = "Doe"
      end
      CRYSTAL

      class_type = test_person_class()
      class_type.add_instance_var("first_name", "String", "John")
      class_type.add_instance_var("last_name", "String", "Doe")
      class_type.generate.should eq(expected)
      class_type.to_s.should eq(expected)
    end
  end
end
