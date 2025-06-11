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
    it "#deprecated" do
      Crygen::Types::Class.new("AnnotationTest").deprecated.generate.should eq(<<-CRYSTAL)
      @[Deprecated]
      class AnnotationTest
      end
      CRYSTAL

      Crygen::Types::Class.new("AnnotationTest").deprecated("Use something instead").generate.should eq(<<-CRYSTAL)
      @[Deprecated("Use something instead")]
      class AnnotationTest
      end
      CRYSTAL
    end

    it "#experimental" do
      Crygen::Types::Class.new("AnnotationTest").experimental.generate.should eq(<<-CRYSTAL)
      @[Experimental]
      class AnnotationTest
      end
      CRYSTAL

      Crygen::Types::Class.new("AnnotationTest").experimental("Lorem ipsum").generate.should eq(<<-CRYSTAL)
      @[Experimental("Lorem ipsum")]
      class AnnotationTest
      end
      CRYSTAL
    end

    it "#flags" do
      Crygen::Types::Enum.new("AnnotationTest").flags.generate.should eq(<<-CRYSTAL)
      @[Flags]
      enum AnnotationTest
      end
      CRYSTAL
    end

    it "#link" do
      Crygen::Types::LibC.new("AnnotationTest").link("musl").generate.should eq(<<-CRYSTAL)
      @[Link("musl")]
      lib AnnotationTest
      end
      CRYSTAL
    end

    it "#thread_local" do
      # FIXME: Complete the @[ThreadLocal] annotation spec.
    end

    it "#always_inline" do
      Crygen::Types::Method.new("always_inline", "Void").always_inline.generate.should eq(<<-CRYSTAL)
      @[AlwaysInline]
      def always_inline : Void
      end
      CRYSTAL
    end

    it "#no_inline" do
      Crygen::Types::Method.new("no_inline", "Void").no_inline.generate.should eq(<<-CRYSTAL)
      @[NoInline]
      def no_inline : Void
      end
      CRYSTAL
    end

    it "#call_convention" do
      # FIXME: Complete the @[CallConvention] annotation spec.
    end
  end
end
