require "./../spec_helper"

describe Crygen::Types::Struct do
  it "creates a class" do
    expected = <<-CRYSTAL
    struct Point
    end
    CRYSTAL

    test_point_struct().generate.should eq(expected)
    test_point_struct().to_s.should eq(expected)
  end

  it "creates a child struct with an inherited abstract struct" do
    expected = <<-CRYSTAL
    struct Point < Geometry
    end
    CRYSTAL

    CGT::Struct.new("Point", "Geometry").generate.should eq(expected)
    CGT::Struct.new("Point", "Geometry").to_s.should eq(expected)
  end

  it "creates a class with one annotation" do
    expected = <<-CRYSTAL
    @[Experimental]
    struct Point
    end
    CRYSTAL

    struct_type = test_point_struct().add_annotation(CGT::Annotation.new("Experimental"))
    struct_type.generate.should eq(expected)
    struct_type.to_s.should eq(expected)
  end

  it "creates a class with many annotations" do
    expected = <<-CRYSTAL
    @[Experimental]
    @[MyAnnotation]
    struct Point
    end
    CRYSTAL

    struct_type = test_point_struct()
    struct_type.add_annotations(
      CGT::Annotation.new("Experimental"),
      CGT::Annotation.new("MyAnnotation")
    )
    struct_type.generate.should eq(expected)
    struct_type.to_s.should eq(expected)
  end

  it "creates a class with one line comment" do
    expected = <<-CRYSTAL
    # This is an example class concerning a person.
    struct Point
    end
    CRYSTAL

    struct_type = test_point_struct().add_comment("This is an example class concerning a person.")
    struct_type.generate.should eq(expected)
    struct_type.to_s.should eq(expected)
  end

  it "creates a class with multiple lines comment" do
    expected = <<-CRYSTAL
    # This is a multiline comment.
    # The name class is Person.
    struct Point
    end
    CRYSTAL

    struct_type = test_point_struct()
    struct_type.add_comment(<<-STR)
    This is a multiline comment.
    The name class is Person.
    STR

    struct_type.generate.should eq(expected)
    struct_type.to_s.should eq(expected)
  end

  it "creates a class with one method" do
    expected = <<-CRYSTAL
    struct Point
      def full_name : String
        "John Doe"
      end
    end
    CRYSTAL

    method_type = CGT::Method.new("full_name", "String")
    method_type.add_body("John Doe".dump)
    struct_type = test_point_struct()
    struct_type.add_method(method_type)
    struct_type.generate.should eq(expected)
    struct_type.to_s.should eq(expected)
  end

  it "creates a class with many methods" do
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
    struct_type.add_methods(
      CGT::Method.new("first_name", "String").add_body("John".dump),
      CGT::Method.new("last_name", "String").add_body("Doe".dump)
    )
    struct_type.generate.should eq(expected)
    struct_type.to_s.should eq(expected)
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
    struct_type.add_property(CGE::PropVisibility::Property, "x", "Int32")
    struct_type.add_property(CGE::PropVisibility::Getter, "y", "Int32")
    struct_type.add_property(CGE::PropVisibility::Setter, "z", "Int32")
    struct_type.generate.should eq(expected)
    struct_type.to_s.should eq(expected)

    struct_type = test_point_struct()
    struct_type.add_property(:property, "x", "Int32")
    struct_type.add_property(:getter, "y", "Int32")
    struct_type.add_property(:setter, "z", "Int32")
    struct_type.generate.should eq(expected)
    struct_type.to_s.should eq(expected)
  end

  it "creates a struct with nilable properties" do
    expected = <<-CRYSTAL
    struct Point
      property? x : Int32
      getter? y : Int32
    end
    CRYSTAL

    struct_type = test_point_struct()
    struct_type.add_property(CGE::PropVisibility::NilProperty, "x", "Int32")
    struct_type.add_property(CGE::PropVisibility::NilGetter, "y", "Int32")
    struct_type.generate.should eq(expected)
    struct_type.to_s.should eq(expected)

    expected = <<-CRYSTAL
    struct Point
      property? x : Int32
      getter? y : Int32
    end
    CRYSTAL

    struct_type = test_point_struct()
    struct_type.add_property(:nil_property, "x", "Int32")
    struct_type.add_property(:nil_getter, "y", "Int32")
    struct_type.generate.should eq(expected)
    struct_type.to_s.should eq(expected)
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
    struct_type.add_property(:property, "x", "Int32")
    struct_type.add_property(:getter, "y", "Int32", scope: :protected)
    struct_type.add_property(:setter, "z", "Int32", scope: :private)
    struct_type.generate.should eq(expected)
    struct_type.to_s.should eq(expected)
  end

  it "creates a struct with nilable scoped properties" do
    expected = <<-CRYSTAL
    struct Point
      private property? x : Int32
      protected getter? y : Int32
    end
    CRYSTAL

    struct_type = test_point_struct()
    struct_type.add_property(:nil_property, "x", "Int32", scope: :private)
    struct_type.add_property(:nil_getter, "y", "Int32", scope: :protected)
    struct_type.generate.should eq(expected)
    struct_type.to_s.should eq(expected)
  end

  it "creates a struct with mixins" do
    expected = <<-CRYSTAL
    struct Point
      include MyMixin
    end
    CRYSTAL

    struct_type = test_point_struct()
    struct_type.add_include("MyMixin")
    struct_type.generate.should eq(expected)
    struct_type.to_s.should eq(expected)

    expected = <<-CRYSTAL
    struct Point
      include MyMixin
      include AnotherMixin
    end
    CRYSTAL

    struct_type = test_point_struct()
    struct_type.add_includes(%w[MyMixin AnotherMixin])
    struct_type.generate.should eq(expected)
    struct_type.to_s.should eq(expected)
  end

  it "creates a struct with extensions" do
    expected = <<-CRYSTAL
    struct Point
      extend MyExtension
    end
    CRYSTAL

    struct_type = test_point_struct()
    struct_type.add_extend("MyExtension")
    struct_type.generate.should eq(expected)
    struct_type.to_s.should eq(expected)

    expected = <<-CRYSTAL
    struct Point
      extend MyExtension
      extend AnotherExtension
    end
    CRYSTAL

    struct_type = test_point_struct()
    struct_type.add_extends(%w[MyExtension AnotherExtension])
    struct_type.generate.should eq(expected)
    struct_type.to_s.should eq(expected)
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

    test_point_struct().add_instance_var("x", "Int32", "32", annotations).to_s.should eq(expected)
  end

  it "adds one annotation to the instance var (struct)" do
    the_annotation = Crygen::Types::Annotation.new("Number")

    expected = <<-CRYSTAL
    struct Point
      @[Number]
      @x : Int32 = 32
    end
    CRYSTAL

    test_point_struct().add_instance_var("x", "Int32", "32", the_annotation).to_s.should eq(expected)
  end

  it "adds the #initialize method" do
    expected = <<-CRYSTAL
    struct Point
      def initialize : Nil
      end
    end
    CRYSTAL

    test_point_struct().add_initialize.to_s.should eq(expected)
  end

  it "adds the #initialize method (with block)" do
    expected = <<-CRYSTAL
    struct Point
      def initialize(@x : Int32, @y : Int32) : Nil
      end
    end
    CRYSTAL

    person_class = test_point_struct().add_initialize do |method|
      method.add_arg("@x", "Int32")
      method.add_arg("@y", "Int32")
    end

    person_class.to_s.should eq(expected)
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

    person_class = test_point_struct()
    person_class.add_initialize
    person_class.add_initialize do |method|
      method.add_arg("@x", "Int32")
      method.add_arg("@y", "Int32")
    end
    person_class.to_s.should eq(expected)
  end

  it "adds the spaces (includes, props and nested classes)" do
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
    nested_struct.add_include("JSON::Serializable")
    nested_struct.add_property(:getter, "bool", "Bool")

    list_struct = CGT::Struct.new("List")
    list_struct.add_include("JSON::Serializable")
    list_struct.add_property(:getter, "int", "Int64")

    class_type = CGT::Struct.new("Foo")
    class_type.add_include("JSON::Serializable")
    class_type.add_property(:getter, "int", "Int64")
    class_type.add_property(:getter, "string", "String")
    class_type.add_property(:getter, "time", "Time")
    class_type.add_property(:getter, "nested", "Nested")
    class_type.add_property(:getter, "list", "Array(List)")
    class_type.add_struct(nested_struct, list_struct)

    class_type.generate.should eq(expected)
    class_type.to_s.should eq(expected)
  end
end
