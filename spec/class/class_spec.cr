require "./../spec_helper"

describe Crygen::Types::Class do
  it "creates a class" do
    test_person_class().generate.should eq(<<-CRYSTAL)
    class Person
    end
    CRYSTAL
  end

  it "creates a class with one annotation" do
    class_type = test_person_class()
    class_type.add_annotation(CGT::Annotation.new("Experimental"))
    class_type.generate.should eq(<<-CRYSTAL)
    @[Experimental]
    class Person
    end
    CRYSTAL
  end

  it "creates a class with many annotations" do
    class_type = test_person_class()
    class_type.add_annotation(CGT::Annotation.new("Experimental"))
    class_type.add_annotation(CGT::Annotation.new("MyAnnotation"))
    class_type.generate.should eq(<<-CRYSTAL)
    @[Experimental]
    @[MyAnnotation]
    class Person
    end
    CRYSTAL
  end

  it "creates a class with one line comment" do
    class_type = test_person_class()
    class_type.add_comment("This is an example class concerning a person.")
    class_type.generate.should eq(<<-CRYSTAL)
    # This is an example class concerning a person.
    class Person
    end
    CRYSTAL
  end

  it "creates a class with multiple lines comment" do
    class_type = test_person_class()
    class_type.add_comment(<<-STR)
    This is a multiline comment.
    The name class is Person.
    STR

    class_type.generate.should eq(<<-CRYSTAL)
    # This is a multiline comment.
    # The name class is Person.
    class Person
    end
    CRYSTAL
  end

  it "creates a class with one method" do
    method_type = CGT::Method.new("full_name", "String")
    method_type.add_body("John Doe".dump)
    class_type = test_person_class()
    class_type.add_method(method_type)
    class_type.generate.should eq(<<-CRYSTAL)
    class Person
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

    class_type = test_person_class()
    class_type.add_method(method_first_name)
    class_type.add_method(method_last_name)

    class_type.generate.should eq(<<-CRYSTAL)
    class Person
      def first_name : String
        "John"
      end

      def last_name : String
        "Doe"
      end
    end
    CRYSTAL
  end

  it "creates a class with properties" do
    class_type = test_person_class()
    class_type.add_property(CGE::PropVisibility::Property, "full_name", "String")
    class_type.add_property(CGE::PropVisibility::Getter, "first_name", "String")
    class_type.add_property(CGE::PropVisibility::Setter, "last_name", "String")

    class_type.generate.should eq(<<-CRYSTAL)
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

    class_type.generate.should eq(<<-CRYSTAL)
    class Person
      property full_name : String
      getter first_name : String
      setter last_name : String
    end
    CRYSTAL
  end

  it "creates a class with nilable properties" do
    class_type = test_person_class()
    class_type.add_property(CGE::PropVisibility::NilProperty, "last_name", "String")
    class_type.add_property(CGE::PropVisibility::NilGetter, "first_name", "String")

    class_type.generate.should eq(<<-CRYSTAL)
    class Person
      property? last_name : String
      getter? first_name : String
    end
    CRYSTAL

    class_type = test_person_class()
    class_type.add_property(:nil_property, "last_name", "String")
    class_type.add_property(:nil_getter, "first_name", "String")

    class_type.generate.should eq(<<-CRYSTAL)
    class Person
      property? last_name : String
      getter? first_name : String
    end
    CRYSTAL
  end

  it "creates a class with nilable scoped properties" do
    class_type = test_person_class()
    class_type.add_property(:nil_property, "last_name", "String", comment: "My comment", scope: :private)
    class_type.add_property(:nil_getter, "first_name", "String", comment: "My other comment", scope: :protected)

    class_type.generate.should eq(<<-CRYSTAL)
    class Person
      # My comment
      private property? last_name : String
      # My other comment
      protected getter? first_name : String
    end
    CRYSTAL
  end
end
