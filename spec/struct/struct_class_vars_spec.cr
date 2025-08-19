require "./../spec_helper"

describe "(class vars only)" do
  it "creates a struct with one class var" do
    expected = <<-CRYSTAL
    struct Point
      @@full_name : String
    end
    CRYSTAL

    struct_type = test_point_struct().add_class_var("full_name", "String")
    struct_type.generate.should eq(expected)
    struct_type.to_s.should eq(expected)
  end

  it "creates a struct with one class var with the default value" do
    expected = <<-CRYSTAL
    struct Point
      @@full_name : String = "John Doe"
    end
    CRYSTAL

    struct_type = test_point_struct().add_class_var("full_name", "String", "John Doe")
    struct_type.generate.should eq(expected)
    struct_type.to_s.should eq(expected)
  end

  it "creates a struct with many class vars" do
    expected = <<-CRYSTAL
    struct Point
      @@first_name : String
      @@last_name : String
    end
    CRYSTAL

    struct_type = test_point_struct()
    struct_type.add_class_var("first_name", "String")
    struct_type.add_class_var("last_name", "String")
    struct_type.generate.should eq(expected)
    struct_type.to_s.should eq(expected)
  end

  it "creates a struct with many class vars with one default value" do
    expected = <<-CRYSTAL
    struct Point
      @@first_name : String = "John"
      @@last_name : String
    end
    CRYSTAL

    struct_type = test_point_struct()
    struct_type.add_class_var("first_name", "String", "John")
    struct_type.add_class_var("last_name", "String")
    struct_type.generate.should eq(expected)
    struct_type.to_s.should eq(expected)
  end

  it "creates a struct with many class vars with default values" do
    expected = <<-CRYSTAL
    struct Point
      @@first_name : String = "John"
      @@last_name : String = "Doe"
    end
    CRYSTAL

    struct_type = test_point_struct()
    struct_type.add_class_var("first_name", "String", "John")
    struct_type.add_class_var("last_name", "String", "Doe")
    struct_type.generate.should eq(expected)
    struct_type.to_s.should eq(expected)
  end

  it "creates a struct with many class and instance vars" do
    expected = <<-CRYSTAL
    struct Point
      @first_name : String
      @last_name : String
      @@another_first_name : String
      @@another_last_name : String
    end
    CRYSTAL

    struct_type = test_point_struct()
    struct_type.add_instance_var("first_name", "String")
    struct_type.add_instance_var("last_name", "String")
    struct_type.add_class_var("another_first_name", "String")
    struct_type.add_class_var("another_last_name", "String")
    struct_type.generate.should eq(expected)
    struct_type.to_s.should eq(expected)
  end
end
