require "./../spec_helper"

describe Crygen::Modules::Property do
  it "creates a struct with an annotated property" do
    expected = <<-CRYSTAL
    struct Point
      @[JSON::Field(key: "x_coord")]
      property x : Int32
    end
    CRYSTAL

    the_annotation = CGT::Annotation.new("JSON::Field")
      .add_arg("key", "x_coord".dump)

    struct_type = test_point_struct()
      .add_property(:property, "x", "Int32", annotations: [the_annotation])

    assert_is_expected(struct_type, expected)
  end

  it "creates a struct with multiple annotated properties" do
    expected = <<-CRYSTAL
    struct Point
      @[JSON::Field(key: "x_coord")]
      property x : Int32

      @[JSON::Field(key: "y_coord")]
      property y : Int32
    end
    CRYSTAL

    annotation1 = CGT::Annotation.new("JSON::Field")
      .add_arg("key", "x_coord".dump)

    annotation2 = CGT::Annotation.new("JSON::Field")
      .add_arg("key", "y_coord".dump)

    struct_type = test_point_struct()
      .add_property(:property, "x", "Int32", annotations: [annotation1])
      .add_property(:property, "y", "Int32", annotations: [annotation2])

    assert_is_expected(struct_type, expected)
  end

  it "creates a struct with annotated nilable property" do
    expected = <<-CRYSTAL
    struct Point
      @[JSON::Field(emit_null: true)]
      property? z : Int32
    end
    CRYSTAL

    the_annotation = CGT::Annotation.new("JSON::Field")
      .add_arg("emit_null", "true")

    struct_type = test_point_struct()
      .add_property(:nil_property, "z", "Int32", annotations: [the_annotation])

    assert_is_expected(struct_type, expected)
  end

  it "creates a struct with annotated scoped properties" do
    expected = <<-CRYSTAL
    struct Point
      @[Internal]
      private property x : Int32

      @[Public]
      protected getter y : Int32
    end
    CRYSTAL

    annotation1 = CGT::Annotation.new("Internal")
    annotation2 = CGT::Annotation.new("Public")

    struct_type = test_point_struct()
      .add_property(:property, "x", "Int32", scope: :private, annotations: [annotation1])
      .add_property(:getter, "y", "Int32", scope: :protected, annotations: [annotation2])

    struct_type.generate.should eq(expected)
  end

  it "creates a struct with class properties having annotations" do
    expected = <<-CRYSTAL
    struct Point
      @[ThreadLocal]
      class_getter x : Int32 = 0

      @[Atomic]
      class_property? y : Int32
    end
    CRYSTAL

    annotation1 = CGT::Annotation.new("ThreadLocal")
    annotation2 = CGT::Annotation.new("Atomic")

    struct_type = test_point_struct()
      .add_property(:class_getter, "x", "Int32", value: "0", annotations: [annotation1])
      .add_property(:nil_class_property, "y", "Int32", annotations: [annotation2])

    assert_is_expected(struct_type, expected)
  end
end
