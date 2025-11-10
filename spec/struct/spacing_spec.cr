require "./../spec_helper"

describe Crygen::Types::Struct do
  it "adds a space between the getter and the method" do
    expected = <<-CRYSTAL
    struct FooParser
      getter value : JSON::Any

      def method(arg1 : String) : JSON::Any
        @value = JSON.parse(string)
      end
    end
    CRYSTAL

    struct_type = CGT::Struct.new("FooParser")
    struct_type.add_property(:getter, "value", "JSON::Any")

    method_type = CGT::Method.new("method", "JSON::Any")
    method_type.add_arg("arg1", "String")
    method_type.add_body("@value = JSON.parse(string)")

    struct_type.add_method(method_type)

    struct_type.generate.should eq(expected)
    struct_type.to_s.should eq(expected)
  end

  it "adds a space between the properties and the method" do
    expected = <<-CRYSTAL
    struct FooParser
      getter value : JSON::Any
      property value : JSON::Any

      def method(arg1 : String) : JSON::Any
        @value = JSON.parse(string)
      end
    end
    CRYSTAL

    struct_type = CGT::Struct.new("FooParser")
    struct_type.add_property(:getter, "value", "JSON::Any")
    struct_type.add_property(:property, "value", "JSON::Any")

    method_type = CGT::Method.new("method", "JSON::Any")
    method_type.add_arg("arg1", "String")
    method_type.add_body("@value = JSON.parse(string)")

    struct_type.add_method(method_type)

    struct_type.generate.should eq(expected)
    struct_type.to_s.should eq(expected)
  end

  it "adds a space between instance vars and the method" do
    expected = <<-CRYSTAL
    struct FooParser
      @instance_var : JSON::Any
      @instance_var2 : JSON::Any

      def method(arg1 : String) : JSON::Any
        @value = JSON.parse(string)
      end
    end
    CRYSTAL

    struct_type = CGT::Struct.new("FooParser")
    struct_type.add_instance_var("instance_var", "JSON::Any")
    struct_type.add_instance_var("instance_var2", "JSON::Any")

    method_type = CGT::Method.new("method", "JSON::Any")
    method_type.add_arg("arg1", "String")
    method_type.add_body("@value = JSON.parse(string)")

    struct_type.add_method(method_type)

    struct_type.generate.should eq(expected)
    struct_type.to_s.should eq(expected)
  end

  it "adds a space between class vars and the method" do
    expected = <<-CRYSTAL
    struct FooParser
      @@class_var : JSON::Any
      @@class_var2 : JSON::Any

      def method(arg1 : String) : JSON::Any
        @value = JSON.parse(string)
      end
    end
    CRYSTAL

    struct_type = CGT::Struct.new("FooParser")
    struct_type.add_class_var("class_var", "JSON::Any")
    struct_type.add_class_var("class_var2", "JSON::Any")

    method_type = CGT::Method.new("method", "JSON::Any")
    method_type.add_arg("arg1", "String")
    method_type.add_body("@value = JSON.parse(string)")

    struct_type.add_method(method_type)

    struct_type.generate.should eq(expected)
    struct_type.to_s.should eq(expected)
  end
end
