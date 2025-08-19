require "./../spec_helper"

describe Crygen::Types::Class do
  it "creates a class" do
    expected = <<-CRYSTAL
    class Person
    end
    CRYSTAL

    test_person_class().generate.should eq(expected)
    test_person_class().to_s.should eq(expected)
  end

  it "creates a child class with an inherited class" do
    expected = <<-CRYSTAL
    class Person < LivingBeing
    end
    CRYSTAL

    CGT::Class.new("Person", "LivingBeing").generate.should eq(expected)
    CGT::Class.new("Person", "LivingBeing").to_s.should eq(expected)
  end

  it "creates a class with one annotation" do
    expected = <<-CRYSTAL
    @[Experimental]
    class Person
    end
    CRYSTAL

    class_type = test_person_class()
    class_type.add_annotation(CGT::Annotation.new("Experimental"))
    class_type.generate.should eq(expected)
    class_type.to_s.should eq(expected)
  end

  it "creates a class with helpers" do
    expected = <<-CRYSTAL
    @[Deprecated("This class is deprecated.")]
    class Person
    end
    CRYSTAL

    class_type = test_person_class().deprecated("This class is deprecated.")
    class_type.generate.should eq(expected)
    class_type.to_s.should eq(expected)

    expected = <<-CRYSTAL
    @[Experimental("This class is experimental.")]
    class Person
    end
    CRYSTAL

    class_type = test_person_class().experimental("This class is experimental.")
    class_type.generate.should eq(expected)
    class_type.to_s.should eq(expected)
  end

  it "creates a class with many annotations" do
    expected = <<-CRYSTAL
    @[Experimental]
    @[MyAnnotation]
    class Person
    end
    CRYSTAL

    class_type = test_person_class()
    class_type.add_annotations(
      CGT::Annotation.new("Experimental"),
      CGT::Annotation.new("MyAnnotation")
    )
    class_type.generate.should eq(expected)
    class_type.to_s.should eq(expected)
  end

  it "creates a class with one line comment" do
    expected = <<-CRYSTAL
    # This is an example class concerning a person.
    class Person
    end
    CRYSTAL

    class_type = test_person_class()
    class_type.add_comment("This is an example class concerning a person.")
    class_type.generate.should eq(expected)
    class_type.to_s.should eq(expected)
  end

  it "creates a class with multiple lines comment" do
    expected = <<-CRYSTAL
    # This is a multiline comment.
    # The name class is Person.
    class Person
    end
    CRYSTAL

    class_type = test_person_class()
    class_type.add_comment(<<-STR)
    This is a multiline comment.
    The name class is Person.
    STR
    class_type.generate.should eq(expected)
    class_type.to_s.should eq(expected)
  end

  it "creates a class with one method" do
    expected = <<-CRYSTAL
    class Person
      def full_name : String
        "John Doe"
      end
    end
    CRYSTAL

    method_type = CGT::Method.new("full_name", "String")
    method_type.add_body("John Doe".dump)
    class_type = test_person_class()
    class_type.add_method(method_type)
    class_type.generate.should eq(expected)
    class_type.to_s.should eq(expected)
  end

  it "creates a class with many methods" do
    expected = <<-CRYSTAL
    class Person
      def first_name : String
        "John"
      end

      def last_name : String
        "Doe"
      end
    end
    CRYSTAL

    method_first_name = CGT::Method.new("first_name", "String")
    method_first_name.add_body("John".dump)

    method_last_name = CGT::Method.new("last_name", "String")
    method_last_name.add_body("Doe".dump)

    class_type = test_person_class()
    class_type.add_method(method_first_name)
    class_type.add_method(method_last_name)
    class_type.generate.should eq(expected)
    class_type.to_s.should eq(expected)
  end

  it "creates a class with properties" do
    expected = <<-CRYSTAL
    class Person
      property full_name : String
      getter first_name : String
      setter last_name : String
    end
    CRYSTAL

    class_type = test_person_class()
    class_type.add_property(CGE::PropVisibility::Property, "full_name", "String")
    class_type.add_property(CGE::PropVisibility::Getter, "first_name", "String")
    class_type.add_property(CGE::PropVisibility::Setter, "last_name", "String")
    class_type.generate.should eq(expected)
    class_type.to_s.should eq(expected)

    expected = <<-CRYSTAL
    class Person
      property full_name : String
      getter first_name : String
      setter last_name : String
    end
    CRYSTAL

    class_type = test_person_class()
    class_type.add_property(:property, "full_name", "String")
    class_type.add_property(:getter, "first_name", "String")
    class_type.add_property(:setter, "last_name", "String")
    class_type.generate.should eq(expected)
    class_type.to_s.should eq(expected)
  end

  it "creates a class with static properties" do
    expected = <<-CRYSTAL
    class Person
      class_property full_name : String
      class_getter first_name : String
      class_setter last_name : String
    end
    CRYSTAL

    class_type = test_person_class()
    class_type.add_property(CGE::PropVisibility::ClassProperty, "full_name", "String")
    class_type.add_property(CGE::PropVisibility::ClassGetter, "first_name", "String")
    class_type.add_property(CGE::PropVisibility::ClassSetter, "last_name", "String")
    class_type.generate.should eq(expected)
    class_type.to_s.should eq(expected)

    expected = <<-CRYSTAL
    class Person
      class_property full_name : String
      class_getter first_name : String
      class_setter last_name : String
    end
    CRYSTAL

    class_type = test_person_class()
    class_type.add_property(:class_property, "full_name", "String")
    class_type.add_property(:class_getter, "first_name", "String")
    class_type.add_property(:class_setter, "last_name", "String")
    class_type.generate.should eq(expected)
    class_type.to_s.should eq(expected)
  end

  it "creates a class with nilable properties" do
    expected = <<-CRYSTAL
    class Person
      property? last_name : String
      getter? first_name : String
    end
    CRYSTAL

    class_type = test_person_class()
    class_type.add_property(CGE::PropVisibility::NilProperty, "last_name", "String")
    class_type.add_property(CGE::PropVisibility::NilGetter, "first_name", "String")
    class_type.generate.should eq(expected)
    class_type.to_s.should eq(expected)

    expected = <<-CRYSTAL
    class Person
      property? last_name : String
      getter? first_name : String
    end
    CRYSTAL

    class_type = test_person_class()
    class_type.add_property(:nil_property, "last_name", "String")
    class_type.add_property(:nil_getter, "first_name", "String")
    class_type.generate.should eq(expected)
    class_type.to_s.should eq(expected)
  end

  it "creates a class with nilable properties" do
    expected = <<-CRYSTAL
    class Person
      class_property? last_name : String
      class_getter? first_name : String
    end
    CRYSTAL

    class_type = test_person_class()
    class_type.add_property(CGE::PropVisibility::NilClassProperty, "last_name", "String")
    class_type.add_property(CGE::PropVisibility::NilClassGetter, "first_name", "String")
    class_type.generate.should eq(expected)
    class_type.to_s.should eq(expected)

    expected = <<-CRYSTAL
    class Person
      class_property? last_name : String
      class_getter? first_name : String
    end
    CRYSTAL

    class_type = test_person_class()
    class_type.add_property(:nil_class_property, "last_name", "String")
    class_type.add_property(:nil_class_getter, "first_name", "String")
    class_type.generate.should eq(expected)
    class_type.to_s.should eq(expected)
  end

  it "creates a class with nilable scoped properties" do
    expected = <<-CRYSTAL
    class Person
      # My comment
      private property? last_name : String
      # My other comment
      protected getter? first_name : String
    end
    CRYSTAL

    class_type = test_person_class()
    class_type.add_property(:nil_property, "last_name", "String", comment: "My comment", scope: :private)
    class_type.add_property(:nil_getter, "first_name", "String", comment: "My other comment", scope: :protected)
    class_type.generate.should eq(expected)
    class_type.to_s.should eq(expected)
  end

  it "creates a class with mixins" do
    expected = <<-CRYSTAL
    class Person
      include MyMixin
    end
    CRYSTAL

    class_type = test_person_class()
    class_type.add_include("MyMixin")
    class_type.generate.should eq(expected)
    class_type.to_s.should eq(expected)

    expected = <<-CRYSTAL
    class Person
      include MyMixin
      include AnotherMixin
    end
    CRYSTAL

    class_type = test_person_class()
    class_type.add_includes(%w[MyMixin AnotherMixin])
    class_type.generate.should eq(expected)
    class_type.to_s.should eq(expected)
  end

  it "creates a class with extensions" do
    expected = <<-CRYSTAL
    class Person
      extend MyExtension
    end
    CRYSTAL

    class_type = test_person_class()
    class_type.add_extend("MyExtension")
    class_type.generate.should eq(expected)
    class_type.to_s.should eq(expected)

    expected = <<-CRYSTAL
    class Person
      extend MyExtension
      extend AnotherExtension
    end
    CRYSTAL

    class_type = test_person_class()
    class_type.add_extends(%w[MyExtension AnotherExtension])
    class_type.generate.should eq(expected)
    class_type.to_s.should eq(expected)
  end
end
