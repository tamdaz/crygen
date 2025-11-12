require "./../spec_helper"

describe Crygen::Types::Class do
  it "adds a space between the getter and the method" do
    expected = <<-CRYSTAL
    class FooParser < SuperClassParser
      getter value : JSON::Any

      def method(arg1 : String) : JSON::Any
        @value = JSON.parse(string)
      end
    end
    CRYSTAL

    class_type = CGT::Class.new("FooParser", "SuperClassParser")
    class_type.add_property(:getter, "value", "JSON::Any")

    method_type = CGT::Method.new("method", "JSON::Any")
    method_type.add_arg("arg1", "String")
    method_type.add_body("@value = JSON.parse(string)")

    class_type.add_method(method_type)

    class_type.generate.should eq(expected)
    class_type.to_s.should eq(expected)
  end

  it "adds a space between the properties and the method" do
    expected = <<-CRYSTAL
    class FooParser < SuperClassParser
      getter value : JSON::Any
      property value : JSON::Any

      def method(arg1 : String) : JSON::Any
        @value = JSON.parse(string)
      end
    end
    CRYSTAL

    class_type = CGT::Class.new("FooParser", "SuperClassParser")
    class_type.add_property(:getter, "value", "JSON::Any")
    class_type.add_property(:property, "value", "JSON::Any")

    method_type = CGT::Method.new("method", "JSON::Any")
    method_type.add_arg("arg1", "String")
    method_type.add_body("@value = JSON.parse(string)")

    class_type.add_method(method_type)

    class_type.generate.should eq(expected)
    class_type.to_s.should eq(expected)
  end

  it "adds a space between instance vars and the method" do
    expected = <<-CRYSTAL
    class FooParser < SuperClassParser
      @instance_var : JSON::Any
      @instance_var2 : JSON::Any

      def method(arg1 : String) : JSON::Any
        @value = JSON.parse(string)
      end
    end
    CRYSTAL

    class_type = CGT::Class.new("FooParser", "SuperClassParser")
    class_type.add_instance_var("instance_var", "JSON::Any")
    class_type.add_instance_var("instance_var2", "JSON::Any")

    method_type = CGT::Method.new("method", "JSON::Any")
    method_type.add_arg("arg1", "String")
    method_type.add_body("@value = JSON.parse(string)")

    class_type.add_method(method_type)

    class_type.generate.should eq(expected)
    class_type.to_s.should eq(expected)
  end

  it "adds a space between class vars and the method" do
    expected = <<-CRYSTAL
    class FooParser < SuperClassParser
      @@class_var : JSON::Any
      @@class_var2 : JSON::Any

      def method(arg1 : String) : JSON::Any
        @value = JSON.parse(string)
      end
    end
    CRYSTAL

    class_type = CGT::Class.new("FooParser", "SuperClassParser")
    class_type.add_class_var("class_var", "JSON::Any")
    class_type.add_class_var("class_var2", "JSON::Any")

    method_type = CGT::Method.new("method", "JSON::Any")
    method_type.add_arg("arg1", "String")
    method_type.add_body("@value = JSON.parse(string)")

    class_type.add_method(method_type)

    class_type.generate.should eq(expected)
    class_type.to_s.should eq(expected)
  end

  it "adds the spaces (includes, props and nested classes)" do
    expected = <<-CRYSTAL
    class Foo
      include JSON::Serializable

      getter int : Int64
      getter string : String
      getter time : Time
      getter nested : Nested
      getter list : Array(List)

      class Nested
        include JSON::Serializable

        getter bool : Bool
      end

      class List
        include JSON::Serializable

        getter int : Int64
      end
    end
    CRYSTAL

    nested_class = CGT::Class.new("Nested")
    nested_class.add_include("JSON::Serializable")
    nested_class.add_property(:getter, "bool", "Bool")

    list_class = CGT::Class.new("List")
    list_class.add_include("JSON::Serializable")
    list_class.add_property(:getter, "int", "Int64")

    class_type = CGT::Class.new("Foo")
    class_type.add_include("JSON::Serializable")
    class_type.add_property(:getter, "int", "Int64")
    class_type.add_property(:getter, "string", "String")
    class_type.add_property(:getter, "time", "Time")
    class_type.add_property(:getter, "nested", "Nested")
    class_type.add_property(:getter, "list", "Array(List)")
    class_type.add_class(nested_class, list_class)

    class_type.generate.should eq(expected)
    class_type.to_s.should eq(expected)
  end
end
