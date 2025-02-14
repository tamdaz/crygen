require "./../spec_helper"

describe Crygen::Types::Struct do
  it "creates a class" do
    test_point_struct().generate.should eq(<<-CRYSTAL)
    struct Point
    end
    CRYSTAL
  end

  it "creates a class with one annotation" do
    test_point_struct().add_annotation(CGT::Annotation.new("Experimental")).generate.should eq(<<-CRYSTAL)
    @[Experimental]
    struct Point
    end
    CRYSTAL
  end

  it "creates a class with many annotations" do
    struct_type = test_point_struct()
    struct_type.add_annotation(CGT::Annotation.new("Experimental"))
    struct_type.add_annotation(CGT::Annotation.new("MyAnnotation"))
    struct_type.generate.should eq(<<-CRYSTAL)
    @[Experimental]
    @[MyAnnotation]
    struct Point
    end
    CRYSTAL
  end

  it "creates a class with one line comment" do
    test_point_struct().add_comment("This is an example class concerning a person.").generate.should eq(<<-CRYSTAL)
    # This is an example class concerning a person.
    struct Point
    end
    CRYSTAL
  end

  it "creates a class with multiple lines comment" do
    struct_type = test_point_struct()
    struct_type.add_comment(<<-STR)
    This is a multiline comment.
    The name class is Person.
    STR

    struct_type.generate.should eq(<<-CRYSTAL)
    # This is a multiline comment.
    # The name class is Person.
    struct Point
    end
    CRYSTAL
  end

  it "creates a class with one method" do
    method_type = CGT::Method.new("full_name", "String")
    method_type.add_body("John Doe".dump)
    struct_type = test_point_struct()
    struct_type.add_method(method_type)
    struct_type.generate.should eq(<<-CRYSTAL)
    struct Point
      def full_name : String
        "John Doe"
      end
    end
    CRYSTAL
  end

  it "creates a class with many methods" do
    method_first_name = CGT::Method.new("first_name", "String")
    method_first_name.add_body("John".dump)

    method_last_name = CGT::Method.new("last_name", "String")
    method_last_name.add_body("Doe".dump)

    struct_type = test_point_struct()
    struct_type.add_method(method_first_name)
    struct_type.add_method(method_last_name)

    struct_type.generate.should eq(<<-CRYSTAL)
    struct Point
      def first_name : String
        "John"
      end

      def last_name : String
        "Doe"
      end
    end
    CRYSTAL
  end

  it "creates a struct with properties" do
    struct_type = test_point_struct()
    struct_type.add_property(CGE::PropVisibility::Property, "x", "Int32")
    struct_type.add_property(CGE::PropVisibility::Getter, "y", "Int32")
    struct_type.add_property(CGE::PropVisibility::Setter, "z", "Int32")

    struct_type.generate.should eq(<<-CRYSTAL)
    struct Point
      property x : Int32
      getter y : Int32
      setter z : Int32
    end
    CRYSTAL

    struct_type = test_point_struct()
    struct_type.add_property(:property, "x", "Int32")
    struct_type.add_property(:getter, "y", "Int32")
    struct_type.add_property(:setter, "z", "Int32")

    struct_type.generate.should eq(<<-CRYSTAL)
    struct Point
      property x : Int32
      getter y : Int32
      setter z : Int32
    end
    CRYSTAL
  end

  it "creates a struct with nilable properties" do
    struct_type = test_point_struct()
    struct_type.add_property(CGE::PropVisibility::NilProperty, "x", "Int32")
    struct_type.add_property(CGE::PropVisibility::NilGetter, "y", "Int32")

    struct_type.generate.should eq(<<-CRYSTAL)
    struct Point
      property? x : Int32
      getter? y : Int32
    end
    CRYSTAL

    struct_type = test_point_struct()
    struct_type.add_property(:nil_property, "x", "Int32")
    struct_type.add_property(:nil_getter, "y", "Int32")

    struct_type.generate.should eq(<<-CRYSTAL)
    struct Point
      property? x : Int32
      getter? y : Int32
    end
    CRYSTAL
  end

  it "creates a struct with scoped properties" do
    struct_type = test_point_struct()
    struct_type.add_property(:property, "x", "Int32")
    struct_type.add_property(:getter, "y", "Int32", :protected)
    struct_type.add_property(:setter, "z", "Int32", :private)

    struct_type.generate.should eq(<<-CRYSTAL)
    struct Point
      property x : Int32
      protected getter y : Int32
      private setter z : Int32
    end
    CRYSTAL
  end


  it "creates a class with nilable scoped properties" do
    struct_type = test_point_struct()
    struct_type.add_property(:nil_property, "x", "Int32", :private)
    struct_type.add_property(:nil_getter, "y", "Int32", :protected)

    struct_type.generate.should eq(<<-CRYSTAL)
    struct Point
      private property? x : Int32
      protected getter? y : Int32
    end
    CRYSTAL
  end
end
