require "./../spec_helper"

describe Crygen::Types::Struct do
  it "creates a struct" do
    expected = <<-CRYSTAL
    struct Point
    end
    CRYSTAL

    assert_is_expected(test_point_struct(), expected)
  end

  it "creates a child struct with an inherited abstract struct" do
    expected = <<-CRYSTAL
    struct Point < Geometry
    end
    CRYSTAL

    assert_is_expected(CGT::Struct.new("Point", "Geometry"), expected)
  end

  it "creates a struct with one annotation" do
    expected = <<-CRYSTAL
    @[Experimental]
    struct Point
    end
    CRYSTAL

    struct_type = test_point_struct()
      .add_annotation(CGT::Annotation.new("Experimental"))

    assert_is_expected(struct_type, expected)
  end

  it "creates a struct with many annotations" do
    expected = <<-CRYSTAL
    @[Experimental]
    @[MyAnnotation]
    struct Point
    end
    CRYSTAL

    struct_type = test_point_struct().add_annotations(
      CGT::Annotation.new("Experimental"),
      CGT::Annotation.new("MyAnnotation")
    )

    assert_is_expected(struct_type, expected)
  end

  it "creates a struct with one line comment" do
    expected = <<-CRYSTAL
    # This is an example struct concerning a point.
    struct Point
    end
    CRYSTAL

    struct_type = test_point_struct()
      .add_comment("This is an example struct concerning a point.")

    assert_is_expected(struct_type, expected)
  end

  it "creates a struct with multiple lines comment" do
    expected = <<-CRYSTAL
    # This is a multiline comment.
    # The name struct is Point.
    struct Point
    end
    CRYSTAL

    struct_type = test_point_struct()
      .add_comment(<<-STR)
      This is a multiline comment.
      The name struct is Point.
      STR

    assert_is_expected(struct_type, expected)
  end

  it "creates a struct with one method" do
    expected = <<-CRYSTAL
    struct Point
      def full_name : String
        "John Doe"
      end
    end
    CRYSTAL

    method_type = CGT::Method.new("full_name", "String")
      .add_body("John Doe".dump)

    struct_type = test_point_struct()
      .add_method(method_type)

    assert_is_expected(struct_type, expected)
  end

  it "creates a struct with many methods" do
    expected = <<-CRYSTAL
    struct Point
      def first_name : String
        "John"
      end

      def last_name : String
        "Doe"
      end
    end
    CRYSTAL

    struct_type = test_point_struct()
      .add_methods(
        CGT::Method.new("first_name", "String").add_body("John".dump),
        CGT::Method.new("last_name", "String").add_body("Doe".dump)
      )

    assert_is_expected(struct_type, expected)
  end

  it "creates a struct with properties" do
    expected = <<-CRYSTAL
    struct Point
      property x : Int32
      getter y : Int32
      setter z : Int32
    end
    CRYSTAL

    struct_type = test_point_struct()
      .add_property(CGE::PropVisibility::Property, "x", "Int32")
      .add_property(CGE::PropVisibility::Getter, "y", "Int32")
      .add_property(CGE::PropVisibility::Setter, "z", "Int32")

    assert_is_expected(struct_type, expected)

    struct_type = test_point_struct()
      .add_property(:property, "x", "Int32")
      .add_property(:getter, "y", "Int32")
      .add_property(:setter, "z", "Int32")

    assert_is_expected(struct_type, expected)
  end

  it "creates a struct with nilable properties" do
    expected = <<-CRYSTAL
    struct Point
      property? x : Int32
      getter? y : Int32
    end
    CRYSTAL

    struct_type = test_point_struct()
      .add_property(CGE::PropVisibility::NilProperty, "x", "Int32")
      .add_property(CGE::PropVisibility::NilGetter, "y", "Int32")

    assert_is_expected(struct_type, expected)

    expected = <<-CRYSTAL
    struct Point
      property? x : Int32
      getter? y : Int32
    end
    CRYSTAL

    struct_type = test_point_struct()
      .add_property(:nil_property, "x", "Int32")
      .add_property(:nil_getter, "y", "Int32")

    assert_is_expected(struct_type, expected)
  end

  it "creates a struct with scoped properties" do
    expected = <<-CRYSTAL
    struct Point
      property x : Int32
      protected getter y : Int32
      private setter z : Int32
    end
    CRYSTAL

    struct_type = test_point_struct()
      .add_property(:property, "x", "Int32")
      .add_property(:getter, "y", "Int32", scope: :protected)
      .add_property(:setter, "z", "Int32", scope: :private)

    assert_is_expected(struct_type, expected)
  end

  it "creates a struct with nilable scoped properties" do
    expected = <<-CRYSTAL
    struct Point
      private property? x : Int32
      protected getter? y : Int32
    end
    CRYSTAL

    struct_type = test_point_struct()
      .add_property(:nil_property, "x", "Int32", scope: :private)
      .add_property(:nil_getter, "y", "Int32", scope: :protected)

    assert_is_expected(struct_type, expected)
  end

  it "creates a struct with mixins" do
    expected = <<-CRYSTAL
    struct Point
      include MyMixin
    end
    CRYSTAL

    struct_type = test_point_struct()
      .add_include("MyMixin")

    assert_is_expected(struct_type, expected)

    expected = <<-CRYSTAL
    struct Point
      include MyMixin
      include AnotherMixin
    end
    CRYSTAL

    struct_type = test_point_struct()
      .add_includes(%w[MyMixin AnotherMixin])

    assert_is_expected(struct_type, expected)
  end

  it "creates a struct with extensions" do
    expected = <<-CRYSTAL
    struct Point
      extend MyExtension
    end
    CRYSTAL

    struct_type = test_point_struct()
      .add_extend("MyExtension")

    assert_is_expected(struct_type, expected)

    expected = <<-CRYSTAL
    struct Point
      extend MyExtension
      extend AnotherExtension
    end
    CRYSTAL

    struct_type = test_point_struct()
      .add_extends(%w[MyExtension AnotherExtension])

    assert_is_expected(struct_type, expected)
  end

  it "adds annotations to the instance var (struct)" do
    annotations = [
      Crygen::Types::Annotation.new("Number"),
      Crygen::Types::Annotation.new("Coordinate"),
    ]

    expected = <<-CRYSTAL
    struct Point
      @[Number]
      @[Coordinate]
      @x : Int32 = 32
    end
    CRYSTAL

    struct_type = test_point_struct()
      .add_instance_var("x", "Int32", "32", annotations)

    assert_is_expected(struct_type, expected)
  end

  it "adds one annotation to the instance var (struct)" do
    the_annotation = Crygen::Types::Annotation.new("Number")

    expected = <<-CRYSTAL
    struct Point
      @[Number]
      @x : Int32 = 32
    end
    CRYSTAL

    struct_type = test_point_struct()
      .add_instance_var("x", "Int32", "32", the_annotation)

    assert_is_expected(struct_type, expected)
  end

  it "adds the #initialize method" do
    expected = <<-CRYSTAL
    struct Point
      def initialize : Nil
      end
    end
    CRYSTAL

    struct_type = test_point_struct().add_initialize

    assert_is_expected(struct_type, expected)
  end

  it "adds the #initialize method (with block)" do
    expected = <<-CRYSTAL
    struct Point
      def initialize(@x : Int32, @y : Int32) : Nil
      end
    end
    CRYSTAL

    point_struct = test_point_struct().add_initialize do |method|
      method.add_arg("@x", "Int32")
        .add_arg("@y", "Int32")
    end

    assert_is_expected(point_struct, expected)
  end

  it "adds several #initialize methods" do
    # watch out to spaces between two initializers.
    expected = <<-CRYSTAL
    struct Point
      def initialize : Nil
      end

      def initialize(@x : Int32, @y : Int32) : Nil
      end
    end
    CRYSTAL

    point_struct = test_point_struct()
      .add_initialize
      .add_initialize do |method|
        method.add_arg("@x", "Int32")
          .add_arg("@y", "Int32")
      end

    assert_is_expected(point_struct, expected)
  end

  it "adds the spaces (includes, props and nested structes)" do
    expected = <<-CRYSTAL
    struct Foo
      include JSON::Serializable

      getter int : Int64
      getter string : String
      getter time : Time
      getter nested : Nested
      getter list : Array(List)

      struct Nested
        include JSON::Serializable

        getter bool : Bool
      end

      struct List
        include JSON::Serializable

        getter int : Int64
      end
    end
    CRYSTAL

    nested_struct = CGT::Struct.new("Nested")
      .add_include("JSON::Serializable")
      .add_property(:getter, "bool", "Bool")

    list_struct = CGT::Struct.new("List")
      .add_include("JSON::Serializable")
      .add_property(:getter, "int", "Int64")

    struct_type = CGT::Struct.new("Foo")
      .add_include("JSON::Serializable")
      .add_property(:getter, "int", "Int64")
      .add_property(:getter, "string", "String")
      .add_property(:getter, "time", "Time")
      .add_property(:getter, "nested", "Nested")
      .add_property(:getter, "list", "Array(List)")
      .add_struct(nested_struct, list_struct)

    assert_is_expected(struct_type, expected)
  end

  it "determines equality" do
    method_first_name = CGT::Method.new("first_name", "String")
      .add_body("John")
    
    method_last_name = CGT::Method.new("last_name", "String")
      .add_body("Doe".dump)

    struct1 = CGT::Struct.new("Person")
      .add_instance_var("name", "String", "value")
      .add_method(method_first_name)
    
    struct2 = CGT::Struct.new("Person")
      .add_instance_var("name", "String", "value")
      .add_method(method_first_name)

    struct3 = CGT::Struct.new("OtherPerson")
      .add_instance_var("name", "String", "value")
      .add_method(method_first_name)
    
    struct4 = CGT::Struct.new("Person")
      .add_instance_var("name", "String", "value")
      .add_method(method_last_name)

    struct1.should eq(struct2)
    struct1.should_not eq(struct3)
    struct1.should_not eq(struct4)
  end
end
