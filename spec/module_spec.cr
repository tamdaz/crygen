require "./spec_helper"

describe Crygen::Types::Module do
  it "creates a module with simple name" do
    expected = <<-CRYSTAL
    module Folder
    end
    CRYSTAL

    module_type = Crygen::Types::Module.new("Folder")

    assert_is_expected(module_type, expected)
  end

  it "creates a module with long name" do
    expected = <<-CRYSTAL
    module Folder::Sub::Folder
    end
    CRYSTAL

    module_type = Crygen::Types::Module.new("Folder::Sub::Folder")

    assert_is_expected(module_type, expected)
  end

  it "creates a module with one method" do
    expected = <<-CRYSTAL
    module Folder::Sub::Folder
      def file_name : String
      end
    end
    CRYSTAL

    module_type = Crygen::Types::Module.new("Folder::Sub::Folder")
      .add_object(Crygen::Types::Method.new("file_name", "String"))

    assert_is_expected(module_type, expected)
  end

  it "creates a module with many methods" do
    expected = <<-CRYSTAL
    module Folder::Sub::Folder
      def name : String
      end

      def size : String
      end
    end
    CRYSTAL

    module_type = Crygen::Types::Module.new("Folder::Sub::Folder")
      .add_object(Crygen::Types::Method.new("name", "String"))
      .add_object(Crygen::Types::Method.new("size", "String"))

    assert_is_expected(module_type, expected)
  end

  it "creates a module with one class" do
    expected = <<-CRYSTAL
    module Folder::Sub::Folder
      class File
      end
    end
    CRYSTAL

    module_type = Crygen::Types::Module.new("Folder::Sub::Folder")
      .add_object(Crygen::Types::Class.new("File"))

    assert_is_expected(module_type, expected)
  end

  it "creates a module with many class" do
    expected = <<-CRYSTAL
    module Folder::Sub::Folder
      class File
      end

      class Symlink
      end
    end
    CRYSTAL

    module_type = Crygen::Types::Module.new("Folder::Sub::Folder")
      .add_objects(
        Crygen::Types::Class.new("File"),
        Crygen::Types::Class.new("Symlink")
      )

    assert_is_expected(module_type, expected)
  end

  it "creates a module with one enum" do
    expected = <<-CRYSTAL
    module Folder::Sub::Folder
      enum Role : Int8
        Member = 1
        Moderator = 2
        Administrator = 3
      end
    end
    CRYSTAL

    enum_type = Crygen::Types::Enum.new("Role", "Int8")
      .add_constant("Member", "1")
      .add_constant("Moderator", "2")
      .add_constant("Administrator", "3")

    module_type = Crygen::Types::Module.new("Folder::Sub::Folder")
      .add_object(enum_type)

    assert_is_expected(module_type, expected)
  end

  it "creates a module with many enums" do
    expected = <<-CRYSTAL
    module Folder::Sub::Folder
      enum Role : Int8
        Member = 1
        Moderator = 2
        Administrator = 3
      end

      enum Permission : Int8
        Read = 4
        Write = 2
        Execute = 1
      end
    end
    CRYSTAL

    first_enum_type = Crygen::Types::Enum.new("Role", "Int8")
      .add_constant("Member", "1")
      .add_constant("Moderator", "2")
      .add_constant("Administrator", "3")

    second_enum_type = Crygen::Types::Enum.new("Permission", "Int8")
      .add_constant("Read", "4")
      .add_constant("Write", "2")
      .add_constant("Execute", "1")

    module_type = Crygen::Types::Module.new("Folder::Sub::Folder")
      .add_object(first_enum_type)
      .add_object(second_enum_type)

    assert_is_expected(module_type, expected)
  end

  it "creates a module with one struct" do
    expected = <<-CRYSTAL
    module Folder::Sub::Folder
      struct File
      end
    end
    CRYSTAL

    module_type = Crygen::Types::Module.new("Folder::Sub::Folder")
      .add_object(Crygen::Types::Struct.new("File"))

    assert_is_expected(module_type, expected)
  end

  it "creates a module with many structs" do
    expected = <<-CRYSTAL
    module Folder::Sub::Folder
      struct File
      end

      struct Symlink
      end
    end
    CRYSTAL

    module_type = Crygen::Types::Module.new("Folder::Sub::Folder")
      .add_object(Crygen::Types::Struct.new("File"))
      .add_object(Crygen::Types::Struct.new("Symlink"))

    assert_is_expected(module_type, expected)
  end

  it "creates a module with one module (recursive)" do
    expected = <<-CRYSTAL
    module Folder
      module File
      end
    end
    CRYSTAL

    module_type = Crygen::Types::Module.new("Folder")
      .add_object(Crygen::Types::Module.new("File"))

    assert_is_expected(module_type, expected)
  end

  it "creates a module with many modules (recursive)" do
    expected = <<-CRYSTAL
    module Folder
      module File
      end

      module Symlink
      end
    end
    CRYSTAL

    module_type = Crygen::Types::Module.new("Folder")
      .add_object(Crygen::Types::Module.new("File"))
      .add_object(Crygen::Types::Module.new("Symlink"))

    assert_is_expected(module_type, expected)
  end

  it "determines equality" do
    method_first_name = CGT::Method.new("first_name", "String")
      .add_body("John")

    method_last_name = CGT::Method.new("last_name", "String")
      .add_body("Doe".dump)

    class1 = CGT::Class.new("Person")
      .add_instance_var("name", "String", "value")
      .add_method(method_first_name)
    
      class2 = CGT::Class.new("Person")
      .add_instance_var("name", "String", "value")
      .add_method(method_first_name)
    
    struct1 = CGT::Struct.new("Person")
      .add_instance_var("name", "String", "value")
      .add_method(method_last_name)

    module1 = CGT::Module.new("Folder").add_object(class1)
    module2 = CGT::Module.new("Folder").add_object(class2)
    module3 = CGT::Module.new("Folder").add_object(struct1)
    module4 = CGT::Module.new("Directory").add_object(class1)

    module1.should eq(module2)
    module1.should_not eq(module3)
    module1.should_not eq(module4)
  end
end
