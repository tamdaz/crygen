require "./../spec_helper"

describe Crygen::Modules::Property do
  it "creates a class with an annotated property" do
    expected = <<-CRYSTAL
    class Person
      @[JSON::Field(key: "full_name")]
      property name : String
    end
    CRYSTAL

    class_type = test_person_class()
    class_type.add_property(
      :property, "name", "String", annotations: [
      CGT::Annotation.new("JSON::Field").add_arg("key", "full_name".dump),
    ])
    class_type.generate.should eq(expected)
  end

  it "creates a class with multiple annotated properties" do
    expected = <<-CRYSTAL
    class Person
      @[JSON::Field(key: "full_name")]
      property name : String
      @[JSON::Field(ignore: true)]
      getter age : Int32
      @[Deprecated("Use new_field instead")]
      setter old_field : String
    end
    CRYSTAL

    annotation1 = CGT::Annotation.new("JSON::Field").add_arg("key", "full_name".dump)
    annotation2 = CGT::Annotation.new("JSON::Field").add_arg("ignore", "true")
    annotation3 = CGT::Annotation.new("Deprecated").add_arg("Use new_field instead".dump)

    class_type = test_person_class()
    class_type.add_property(:property, "name", "String", annotations: [annotation1])
    class_type.add_property(:getter, "age", "Int32", annotations: [annotation2])
    class_type.add_property(:setter, "old_field", "String", annotations: [annotation3])

    class_type.generate.should eq(expected)
  end

  it "creates a class with a property having multiple annotations" do
    expected = <<-CRYSTAL
      class Person
        @[JSON::Field(key: "full_name")]
        @[Deprecated]
        property name : String
      end
      CRYSTAL

    class_type = test_person_class()

    annotation1 = CGT::Annotation.new("JSON::Field")
    annotation1.add_arg("key", "full_name".dump)

    annotation2 = CGT::Annotation.new("Deprecated")

    class_type.add_property(
      :property, "name", "String", annotations: [annotation1, annotation2]
    )
    class_type.generate.should eq(expected)
  end

  it "creates a class with annotated property with default value" do
    expected = <<-CRYSTAL
    class Person
      @[JSON::Field(emit_null: true)]
      property name : String? = nil
    end
    CRYSTAL

    the_annotation = CGT::Annotation.new("JSON::Field")
    the_annotation.add_arg("emit_null", "true")

    class_type = test_person_class()
    class_type.add_property(
      :property, "name", "String?", value: "nil", annotations: [the_annotation]
    )
    class_type.generate.should eq(expected)
  end

  it "creates a class with annotated nilable property" do
    expected = <<-CRYSTAL
    class Person
      @[JSON::Field(key: "is_active")]
      property? active : Bool
    end
    CRYSTAL

    the_annotation = CGT::Annotation.new("JSON::Field")
    the_annotation.add_arg("key", "is_active".dump)

    class_type = test_person_class()
    class_type.add_property(:nil_property, "active", "Bool", annotations: [the_annotation])
    class_type.generate.should eq(expected)
  end

  it "creates a class with annotated scoped properties" do
    expected = <<-CRYSTAL
    class Person
      @[JSON::Field(key: "id")]
      private property id : Int32
      @[Deprecated]
      protected getter name : String
    end
    CRYSTAL

    annotation1 = CGT::Annotation.new("JSON::Field")
    annotation1.add_arg("key", "id".dump)

    annotation2 = CGT::Annotation.new("Deprecated")

    class_type = test_person_class()

    class_type.add_property(:property, "id", "Int32", scope: :private, annotations: [annotation1])
    class_type.add_property(:getter, "name", "String", scope: :protected, annotations: [annotation2])

    class_type.generate.should eq(expected)
  end

  it "creates a class with annotated class properties" do
    expected = <<-CRYSTAL
    class Person
      @[ClassVar]
      class_property instances : Int32 = 0
    end
    CRYSTAL

    the_annotation = CGT::Annotation.new("ClassVar")

    class_type = test_person_class()
    class_type.add_property(
      :class_property, "instances", "Int32", value: "0", annotations: [the_annotation]
    )
    class_type.generate.should eq(expected)
  end

  it "creates a class with annotated property and comment" do
    expected = <<-CRYSTAL
    class Person
      # The person's full name
      @[JSON::Field(key: "full_name")]
      property name : String
    end
    CRYSTAL

    the_annotation = CGT::Annotation.new("JSON::Field")
    the_annotation.add_arg("key", "full_name".dump)

    class_type = test_person_class()
    class_type.add_property(
      :property, "name", "String", comment: "The person's full name", annotations: [the_annotation]
    )
    class_type.generate.should eq(expected)
  end

  it "creates a class with multiple annotations and comment on property" do
    expected = <<-CRYSTAL
    class Person
      # The person's identifier
      @[JSON::Field(key: "id")]
      @[Deprecated("Use uuid instead")]
      property id : Int32
    end
    CRYSTAL

    class_type = test_person_class()

    annotation1 = CGT::Annotation.new("JSON::Field")
    annotation1.add_arg("key", "id".dump)

    annotation2 = CGT::Annotation.new("Deprecated")
    annotation2.add_arg("Use uuid instead".dump)

    class_type.add_property(
      :property,
      "id",
      "Int32",
      comment: "The person's identifier",
      annotations: [annotation1, annotation2]
    )
    class_type.generate.should eq(expected)
  end

  it "creates a class with properties having complex annotations" do
    expected = <<-CRYSTAL
    class APIResponse
      @[JSON::Field(key: "response_code", emit_null: false)]
      property code : Int32
      @[JSON::Field(converter: Time::EpochConverter)]
      property timestamp : Time
      @[JSON::Field(ignore: true)]
      @[Deprecated("Use metadata instead")]
      getter? legacy_data : String?
    end
    CRYSTAL

    annotation1 = CGT::Annotation.new("JSON::Field")
    annotation1.add_arg("key", "response_code".dump)
    annotation1.add_arg("emit_null", "false")

    annotation2 = CGT::Annotation.new("JSON::Field")
    annotation2.add_arg("converter", "Time::EpochConverter")

    annotation3 = CGT::Annotation.new("JSON::Field")
    annotation3.add_arg("ignore", "true")

    annotation4 = CGT::Annotation.new("Deprecated")
    annotation4.add_arg("Use metadata instead".dump)

    class_type = CGT::Class.new("APIResponse")
    class_type.add_property(:property, "code", "Int32", annotations: [annotation1])
    class_type.add_property(:property, "timestamp", "Time", annotations: [annotation2])
    class_type.add_property(:nil_getter, "legacy_data", "String?", annotations: [annotation3, annotation4])

    class_type.generate.should eq(expected)
  end

  it "works with all property visibility types and annotations" do
    expected = <<-CRYSTAL
    class AllProperties
      @[Test]
      property prop : Int32
      @[Test]
      getter get : Int32
      @[Test]
      setter set : Int32
      @[Test]
      property? nil_prop : Int32
      @[Test]
      getter? nil_get : Int32
      @[Test]
      class_property class_prop : Int32
      @[Test]
      class_getter class_get : Int32
      @[Test]
      class_setter class_set : Int32
      @[Test]
      class_property? nil_class_prop : Int32
      @[Test]
      class_getter? nil_class_get : Int32
    end
    CRYSTAL

    class_type = CGT::Class.new("AllProperties")

    properties = [
      {Crygen::Enums::PropVisibility::Property, "prop"},
      {Crygen::Enums::PropVisibility::Getter, "get"},
      {Crygen::Enums::PropVisibility::Setter, "set"},
      {Crygen::Enums::PropVisibility::NilProperty, "nil_prop"},
      {Crygen::Enums::PropVisibility::NilGetter, "nil_get"},
      {Crygen::Enums::PropVisibility::ClassProperty, "class_prop"},
      {Crygen::Enums::PropVisibility::ClassGetter, "class_get"},
      {Crygen::Enums::PropVisibility::ClassSetter, "class_set"},
      {Crygen::Enums::PropVisibility::NilClassProperty, "nil_class_prop"},
      {Crygen::Enums::PropVisibility::NilClassGetter, "nil_class_get"},
    ]

    properties.each do |visibility, name|
      class_type.add_property(visibility, name, "Int32", annotations: [CGT::Annotation.new("Test")])
    end

    class_type.generate.should eq(expected)
  end
end
