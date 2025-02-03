require "./../spec_helper"

describe "(class vars only)" do
  it "creates a struct with one class var" do
    test_point_struct().add_class_var("full_name", "String").generate.should eq(<<-CRYSTAL)
    struct Point
      @@full_name : String
    end
    CRYSTAL
  end

  it "creates a struct with one class var with the default value" do
    test_point_struct().add_class_var("full_name", "String", "John Doe").generate.should eq(<<-CRYSTAL)
    struct Point
      @@full_name : String = "John Doe"
    end
    CRYSTAL
  end

  it "creates a struct with many class vars" do
    struct_type = test_point_struct()
    struct_type.add_class_var("first_name", "String")
    struct_type.add_class_var("last_name", "String")
    struct_type.generate.should eq(<<-CRYSTAL)
    struct Point
      @@first_name : String
      @@last_name : String
    end
    CRYSTAL
  end

  it "creates a struct with many class vars with one default value" do
    struct_type = test_point_struct()
    struct_type.add_class_var("first_name", "String", "John")
    struct_type.add_class_var("last_name", "String")
    struct_type.generate.should eq(<<-CRYSTAL)
    struct Point
      @@first_name : String = "John"
      @@last_name : String
    end
    CRYSTAL
  end

  it "creates a struct with many class vars with default values" do
    struct_type = test_point_struct()
    struct_type.add_class_var("first_name", "String", "John")
    struct_type.add_class_var("last_name", "String", "Doe")
    struct_type.generate.should eq(<<-CRYSTAL)
    struct Point
      @@first_name : String = "John"
      @@last_name : String = "Doe"
    end
    CRYSTAL
  end

  it "creates a struct with many class and instance vars" do
    struct_type = test_point_struct()
    struct_type.add_instance_var("first_name", "String")
    struct_type.add_instance_var("last_name", "String")
    struct_type.add_class_var("another_first_name", "String")
    struct_type.add_class_var("another_last_name", "String")
    struct_type.generate.should eq(<<-CRYSTAL)
    struct Point
      @first_name : String
      @last_name : String
      @@another_first_name : String
      @@another_last_name : String
    end
    CRYSTAL
  end
end
