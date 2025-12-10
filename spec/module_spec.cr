require "./spec_helper"

describe Crygen::Types::Module do
  it "creates a module with simple name" do
    expected = <<-CRYSTAL
    module Folder
    end
    CRYSTAL

    module_type = Crygen::Types::Module.new("Folder")
    module_type.generate.should eq(expected)
    module_type.to_s.should eq(expected)
  end

  it "creates a module with long name" do
    expected = <<-CRYSTAL
    module Folder::Sub::Folder
    end
    CRYSTAL

    module_type = Crygen::Types::Module.new("Folder::Sub::Folder")
    module_type.generate.should eq(expected)
    module_type.to_s.should eq(expected)
  end

  it "creates a module with one method" do
    expected = <<-CRYSTAL
    module Folder::Sub::Folder
      def file_name : String
      end
    end
    CRYSTAL

    module_type = Crygen::Types::Module.new("Folder::Sub::Folder")
    module_type.add_object(Crygen::Types::Method.new("file_name", "String"))
    module_type.generate.should eq(expected)
    module_type.to_s.should eq(expected)
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
    module_type.add_object(Crygen::Types::Method.new("name", "String"))
    module_type.add_object(Crygen::Types::Method.new("size", "String"))
    module_type.generate.should eq(expected)
    module_type.to_s.should eq(expected)
  end

  it "creates a module with one class" do
    expected = <<-CRYSTAL
    module Folder::Sub::Folder
      class File
      end
    end
    CRYSTAL

    module_type = Crygen::Types::Module.new("Folder::Sub::Folder")
    module_type.add_object(Crygen::Types::Class.new("File"))
    module_type.generate.should eq(expected)
    module_type.to_s.should eq(expected)
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
    module_type.add_objects(
      Crygen::Types::Class.new("File"),
      Crygen::Types::Class.new("Symlink")
    )
    module_type.generate.should eq(expected)
    module_type.to_s.should eq(expected)
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
    enum_type.add_constant("Member", "1")
    enum_type.add_constant("Moderator", "2")
    enum_type.add_constant("Administrator", "3")

    module_type = Crygen::Types::Module.new("Folder::Sub::Folder")
    module_type.add_object(enum_type)
    module_type.generate.should eq(expected)
    module_type.to_s.should eq(expected)
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
    first_enum_type.add_constant("Member", "1")
    first_enum_type.add_constant("Moderator", "2")
    first_enum_type.add_constant("Administrator", "3")

    second_enum_type = Crygen::Types::Enum.new("Permission", "Int8")
    second_enum_type.add_constant("Read", "4")
    second_enum_type.add_constant("Write", "2")
    second_enum_type.add_constant("Execute", "1")

    module_type = Crygen::Types::Module.new("Folder::Sub::Folder")
    module_type.add_object(first_enum_type)
    module_type.add_object(second_enum_type)
    module_type.generate.should eq(expected)
    module_type.to_s.should eq(expected)
  end

  it "creates a module with one struct" do
    expected = <<-CRYSTAL
    module Folder::Sub::Folder
      struct File
      end
    end
    CRYSTAL

    module_type = Crygen::Types::Module.new("Folder::Sub::Folder")
    module_type.add_object(Crygen::Types::Struct.new("File"))
    module_type.generate.should eq(expected)
    module_type.to_s.should eq(expected)
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
    module_type.add_object(Crygen::Types::Struct.new("File"))
    module_type.add_object(Crygen::Types::Struct.new("Symlink"))
    module_type.generate.should eq(expected)
    module_type.to_s.should eq(expected)
  end

  it "creates a module with one module (recursive)" do
    expected = <<-CRYSTAL
    module Folder
      module File
      end
    end
    CRYSTAL

    module_type = Crygen::Types::Module.new("Folder")
    module_type.add_object(Crygen::Types::Module.new("File"))
    module_type.generate.should eq(expected)
    module_type.to_s.should eq(expected)
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
    module_type.add_object(Crygen::Types::Module.new("File"))
    module_type.add_object(Crygen::Types::Module.new("Symlink"))
    module_type.generate.should eq(expected)
    module_type.to_s.should eq(expected)
  end

  it "determines equality" do
    method_first_name = CGT::Method.new("first_name", "String")
    method_first_name.add_body("John")
    method_last_name = CGT::Method.new("last_name", "String")
    method_last_name.add_body("Doe".dump)

    class1 = CGT::Class.new("Person")
    class1.add_instance_var("name", "String", "value")
    class1.add_method(method_first_name)
    class2 = CGT::Class.new("Person")
    class2.add_instance_var("name", "String", "value")
    class2.add_method(method_first_name)
    struct1 = CGT::Struct.new("Person")
    struct1.add_instance_var("name", "String", "value")
    struct1.add_method(method_last_name)

    module1 = CGT::Module.new("Folder")
    module1.add_object(class1)
    module2 = CGT::Module.new("Folder")
    module2.add_object(class2)
    module3 = CGT::Module.new("Folder")
    module3.add_object(struct1)
    module4 = CGT::Module.new("Directory")
    module4.add_object(class1)

    module1.should eq(module2)
    module1.should_not eq(module3)
    module1.should_not eq(module4)
  end
end
