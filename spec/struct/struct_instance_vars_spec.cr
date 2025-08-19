require "./../spec_helper"

describe Crygen::Types::Struct do
  describe "(instance vars only)" do
    it "creates a struct with one instance var" do
      expected = <<-CRYSTAL
      struct Point
        @full_name : String
      end
      CRYSTAL

      struct_type = test_point_struct().add_instance_var("full_name", "String")
      struct_type.generate.should eq(expected)
      struct_type.to_s.should eq(expected)
    end

    it "creates a struct with one instance var with the default value" do
      expected = <<-CRYSTAL
      struct Point
        @full_name : String = "John Doe"
      end
      CRYSTAL

      struct_type = test_point_struct().add_instance_var("full_name", "String", "John Doe")
      struct_type.generate.should eq(expected)
      struct_type.to_s.should eq(expected)
    end

    it "creates a struct with many instance vars" do
      expected = <<-CRYSTAL
      struct Point
        @first_name : String
        @last_name : String
      end
      CRYSTAL

      struct_type = test_point_struct()
      struct_type.add_instance_var("first_name", "String")
      struct_type.add_instance_var("last_name", "String")
      struct_type.generate.should eq(expected)
      struct_type.to_s.should eq(expected)
    end

    it "creates a struct with many instance vars with one default value" do
      expected = <<-CRYSTAL
      struct Point
        @first_name : String = "John"
        @last_name : String
      end
      CRYSTAL

      struct_type = test_point_struct()
      struct_type.add_instance_var("first_name", "String", "John")
      struct_type.add_instance_var("last_name", "String")
      struct_type.generate.should eq(expected)
      struct_type.to_s.should eq(expected)
    end

    it "creates a struct with many instance vars with default values" do
      expected = <<-CRYSTAL
      struct Point
        @first_name : String = "John"
        @last_name : String = "Doe"
      end
      CRYSTAL

      struct_type = test_point_struct()
      struct_type.add_instance_var("first_name", "String", "John")
      struct_type.add_instance_var("last_name", "String", "Doe")
      struct_type.generate.should eq(expected)
      struct_type.to_s.should eq(expected)
    end
  end
end
