require "./spec_helper"

describe Crygen::Types::Annotation do
  it "creates an annotation" do
    Crygen::Types::Annotation.new("MyAnnotation").generate.should eq(<<-CRYSTAL)
    @[MyAnnotation]
    CRYSTAL
  end

  it "creates an annotation with one parameter (value only)" do
    Crygen::Types::Annotation.new("MyAnnotation").add_arg("true").generate.should eq(<<-CRYSTAL)
    @[MyAnnotation(true)]
    CRYSTAL
  end

  it "creates an annotation with one parameter (name and value)" do
    Crygen::Types::Annotation.new("MyAnnotation").add_arg("is_cool", "true").generate.should eq(<<-CRYSTAL)
    @[MyAnnotation(is_cool: true)]
    CRYSTAL
  end

  it "creates an annotation with many parameters (values only)" do
    annotation_type = Crygen::Types::Annotation.new("MyAnnotation")
    annotation_type.add_arg("true")
    annotation_type.add_arg("1")
    annotation_type.add_arg("Hello World".dump)
    annotation_type.generate.should eq(<<-CRYSTAL)
    @[MyAnnotation(true, 1, "Hello World")]
    CRYSTAL
  end

  it "creates an annotation with many parameters (name and value)" do
    annotation_type = Crygen::Types::Annotation.new("MyAnnotation")
    annotation_type.add_arg("is_cool", "true")
    annotation_type.add_arg("number", "1")
    annotation_type.add_arg("text", "Hello World".dump)
    annotation_type.generate.should eq(<<-CRYSTAL)
    @[MyAnnotation(is_cool: true, number: 1, text: "Hello World")]
    CRYSTAL
  end

  describe "annotation helpers" do
    it "#as_deprecated" do
      Crygen::Types::Class.new("AnnotationTest").as_deprecated.generate.should eq(<<-CRYSTAL)
      @[Deprecated]
      class AnnotationTest
      end
      CRYSTAL

      Crygen::Types::Class.new("AnnotationTest").as_deprecated("Use something instead").generate.should eq(<<-CRYSTAL)
      @[Deprecated("Use something instead")]
      class AnnotationTest
      end
      CRYSTAL
    end

    it "#as_experimental" do
      Crygen::Types::Class.new("AnnotationTest").as_experimental.generate.should eq(<<-CRYSTAL)
      @[Experimental]
      class AnnotationTest
      end
      CRYSTAL

      Crygen::Types::Class.new("AnnotationTest").as_experimental("Lorem ipsum").generate.should eq(<<-CRYSTAL)
      @[Experimental("Lorem ipsum")]
      class AnnotationTest
      end
      CRYSTAL
    end

    it "#as_flags" do
      Crygen::Types::Enum.new("AnnotationTest").as_flags.generate.should eq(<<-CRYSTAL)
      @[Flags]
      enum AnnotationTest
      end
      CRYSTAL
    end

    it "#as_link" do
      Crygen::Types::LibC.new("AnnotationTest").add_link("musl").generate.should eq(<<-CRYSTAL)
      @[Link("musl")]
      lib AnnotationTest
      end
      CRYSTAL
    end
  end
end
