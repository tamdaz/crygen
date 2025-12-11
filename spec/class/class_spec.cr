require "./../spec_helper"

describe Crygen::Types::Class do
  it "creates a class" do
    expected = <<-CRYSTAL
    class Person
    end
    CRYSTAL

    assert_is_expected(test_person_class(), expected)
  end

  it "creates a child class with an inherited class" do
    expected = <<-CRYSTAL
    class Person < LivingBeing
    end
    CRYSTAL

    assert_is_expected(CGT::Class.new("Person", "LivingBeing"), expected)
  end

  it "creates a class with one annotation" do
    expected = <<-CRYSTAL
    @[Experimental]
    class Person
    end
    CRYSTAL

    class_type = test_person_class().add_annotation(CGT::Annotation.new("Experimental"))

    assert_is_expected(class_type, expected)
  end

  it "creates a class with helpers" do
    expected = <<-CRYSTAL
    @[Deprecated("This class is deprecated.")]
    class Person
    end
    CRYSTAL

    class_type = test_person_class().deprecated("This class is deprecated.")

    assert_is_expected(class_type, expected)

    expected = <<-CRYSTAL
    @[Experimental("This class is experimental.")]
    class Person
    end
    CRYSTAL

    class_type = test_person_class().experimental("This class is experimental.")

    assert_is_expected(class_type, expected)
  end

  it "creates a class with many annotations" do
    expected = <<-CRYSTAL
    @[Experimental]
    @[MyAnnotation]
    class Person
    end
    CRYSTAL

    class_type = test_person_class().add_annotations(
      CGT::Annotation.new("Experimental"),
      CGT::Annotation.new("MyAnnotation")
    )

    assert_is_expected(class_type, expected)
  end

  it "creates a class with one line comment" do
    expected = <<-CRYSTAL
    # This is an example class concerning a person.
    class Person
    end
    CRYSTAL

    class_type = test_person_class().add_comment("This is an example class concerning a person.")

    assert_is_expected(class_type, expected)
  end

  it "creates a class with multiple lines comment" do
    expected = <<-CRYSTAL
    # This is a multiline comment.
    # The name class is Person.
    class Person
    end
    CRYSTAL

    class_type = test_person_class().add_comment(<<-STR)
    This is a multiline comment.
    The name class is Person.
    STR

    assert_is_expected(class_type, expected)
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
      .add_body("John Doe".dump)

    class_type = test_person_class()
      .add_method(method_type)

    assert_is_expected(class_type, expected)
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

    method_first_name = CGT::Method.new("first_name", "String").add_body("John".dump)
    method_last_name = CGT::Method.new("last_name", "String").add_body("Doe".dump)

    class_type = test_person_class()
      .add_method(method_first_name)
      .add_method(method_last_name)

    assert_is_expected(class_type, expected)
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
      .add_property(CGE::PropVisibility::Property, "full_name", "String")
      .add_property(CGE::PropVisibility::Getter, "first_name", "String")
      .add_property(CGE::PropVisibility::Setter, "last_name", "String")

    assert_is_expected(class_type, expected)

    class_type = test_person_class()
      .add_property(:property, "full_name", "String")
      .add_property(:getter, "first_name", "String")
      .add_property(:setter, "last_name", "String")

    assert_is_expected(class_type, expected)
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
      .add_property(CGE::PropVisibility::ClassProperty, "full_name", "String")
      .add_property(CGE::PropVisibility::ClassGetter, "first_name", "String")
      .add_property(CGE::PropVisibility::ClassSetter, "last_name", "String")

    assert_is_expected(class_type, expected)

    class_type = test_person_class()
      .add_property(:class_property, "full_name", "String")
      .add_property(:class_getter, "first_name", "String")
      .add_property(:class_setter, "last_name", "String")

    assert_is_expected(class_type, expected)
  end

  it "creates a class with nilable properties" do
    expected = <<-CRYSTAL
    class Person
      property? last_name : String
      getter? first_name : String
    end
    CRYSTAL

    class_type = test_person_class()
      .add_property(CGE::PropVisibility::NilProperty, "last_name", "String")
      .add_property(CGE::PropVisibility::NilGetter, "first_name", "String")

    assert_is_expected(class_type, expected)

    class_type = test_person_class()
      .add_property(:nil_property, "last_name", "String")
      .add_property(:nil_getter, "first_name", "String")

    assert_is_expected(class_type, expected)
  end

  it "creates a class with nilable properties" do
    expected = <<-CRYSTAL
    class Person
      class_property? last_name : String
      class_getter? first_name : String
    end
    CRYSTAL

    class_type = test_person_class()
      .add_property(CGE::PropVisibility::NilClassProperty, "last_name", "String")
      .add_property(CGE::PropVisibility::NilClassGetter, "first_name", "String")

    assert_is_expected(class_type, expected)

    class_type = test_person_class()
      .add_property(:nil_class_property, "last_name", "String")
      .add_property(:nil_class_getter, "first_name", "String")

    assert_is_expected(class_type, expected)
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
      .add_property(:nil_property, "last_name", "String", comment: "My comment", scope: :private)
      .add_property(:nil_getter, "first_name", "String", comment: "My other comment", scope: :protected)

    assert_is_expected(class_type, expected)
  end

  it "creates a class with mixins" do
    expected = <<-CRYSTAL
    class Person
      include MyMixin
    end
    CRYSTAL

    class_type = test_person_class()
      .add_include("MyMixin")

    assert_is_expected(class_type, expected)

    expected = <<-CRYSTAL
    class Person
      include MyMixin
      include AnotherMixin
    end
    CRYSTAL

    class_type = test_person_class()
      .add_includes(%w[MyMixin AnotherMixin])

    assert_is_expected(class_type, expected)
  end

  it "creates a class with extensions" do
    expected = <<-CRYSTAL
    class Person
      extend MyExtension
    end
    CRYSTAL

    class_type = test_person_class()
      .add_extend("MyExtension")

    assert_is_expected(class_type, expected)

    expected = <<-CRYSTAL
    class Person
      extend MyExtension
      extend AnotherExtension
    end
    CRYSTAL

    class_type = test_person_class()
      .add_extends(%w[MyExtension AnotherExtension])

    assert_is_expected(class_type, expected)
  end

  it "adds annotations to the instance var" do
    annotations = [
      Crygen::Types::Annotation.new("Identity"),
      Crygen::Types::Annotation.new("Sensitive"),
    ]

    expected = <<-CRYSTAL
    class Person
      @[Identity]
      @[Sensitive]
      @name : String = "value"
    end
    CRYSTAL

    class_type = test_person_class()
      .add_instance_var("name", "String", "value", annotations)

    assert_is_expected(class_type, expected)
  end

  it "adds one annotation to the instance var" do
    the_annotation = Crygen::Types::Annotation.new("Identity")

    expected = <<-CRYSTAL
    class Person
      @[Identity]
      @name : String = "value"
    end
    CRYSTAL

    class_type = test_person_class()
      .add_instance_var("name", "String", "value", the_annotation)

    assert_is_expected(class_type, expected)
  end

  it "adds annotations to the class var" do
    annotations = [
      Crygen::Types::Annotation.new("Identity"),
      Crygen::Types::Annotation.new("Sensitive"),
    ]

    expected = <<-CRYSTAL
    class Person
      @[Identity]
      @[Sensitive]
      @@name : String = "value"
    end
    CRYSTAL

    class_type = test_person_class()
      .add_class_var("name", "String", "value", annotations)

    assert_is_expected(class_type, expected)
  end

  it "adds one annotation to the class var" do
    the_annotation = Crygen::Types::Annotation.new("Identity")

    expected = <<-CRYSTAL
    class Person
      @[Identity]
      @@name : String = "value"
    end
    CRYSTAL

    class_type = test_person_class()
      .add_class_var("name", "String", "value", the_annotation)

    assert_is_expected(class_type, expected)
  end

  it "adds the #initialize method" do
    expected = <<-CRYSTAL
    class Person
      def initialize : Nil
      end
    end
    CRYSTAL

    assert_is_expected(test_person_class().add_initialize, expected)
  end

  it "adds the #initialize method (with block)" do
    expected = <<-CRYSTAL
    class Person
      def initialize(@name : String, @age : UInt8) : Nil
      end
    end
    CRYSTAL

    person_class = test_person_class().add_initialize do |method|
      method.add_arg("@name", "String")
        .add_arg("@age", "UInt8")
    end

    assert_is_expected(person_class, expected)
  end

  it "adds several #initialize methods" do
    # watch out to the number of spaces characters between two initializers.
    expected = <<-CRYSTAL
    class Person
      def initialize : Nil
      end

      def initialize(@name : String, @age : UInt8) : Nil
      end
    end
    CRYSTAL

    person_class = test_person_class()
      .add_initialize
      .add_initialize do |method|
        method.add_arg("@name", "String").add_arg("@age", "UInt8")
      end

    assert_is_expected(person_class, expected)
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

    class3 = CGT::Class.new("OtherPerson")
      .add_instance_var("name", "String", "value")
      .add_method(method_first_name)

    class4 = CGT::Class.new("Person")
      .add_instance_var("name", "String", "value")
      .add_method(method_last_name)

    class1.should eq(class2)
    class1.should_not eq(class3)
    class1.should_not eq(class4)
  end
end
