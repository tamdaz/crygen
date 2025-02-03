require "./../spec_helper"

describe Crygen::Types::Struct do
  describe "(instance vars only)" do
    it "creates a struct with one instance var" do
      test_point_struct().add_instance_var("full_name", "String").generate.should eq(<<-CRYSTAL)
      struct Point
        @full_name : String
      end
      CRYSTAL
    end

    it "creates a struct with one instance var with the default value" do
      test_point_struct().add_instance_var("full_name", "String", "John Doe").generate.should eq(<<-CRYSTAL)
      struct Point
        @full_name : String = "John Doe"
      end
      CRYSTAL
    end

    it "creates a struct with many instance vars" do
      struct_type = test_point_struct()
      struct_type.add_instance_var("first_name", "String")
      struct_type.add_instance_var("last_name", "String")
      struct_type.generate.should eq(<<-CRYSTAL)
      struct Point
        @first_name : String
        @last_name : String
      end
      CRYSTAL
    end

    it "creates a struct with many instance vars with one default value" do
      struct_type = test_point_struct()
      struct_type.add_instance_var("first_name", "String", "John")
      struct_type.add_instance_var("last_name", "String")
      struct_type.generate.should eq(<<-CRYSTAL)
      struct Point
        @first_name : String = "John"
        @last_name : String
      end
      CRYSTAL
    end

    it "creates a struct with many instance vars with default values" do
      struct_type = test_point_struct()
      struct_type.add_instance_var("first_name", "String", "John")
      struct_type.add_instance_var("last_name", "String", "Doe")
      struct_type.generate.should eq(<<-CRYSTAL)
      struct Point
        @first_name : String = "John"
        @last_name : String = "Doe"
      end
      CRYSTAL
    end
  end
end
