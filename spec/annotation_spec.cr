require "./spec_helper"

describe Crygen::Types::Annotation do
  it "creates an annotation" do
    annotation_type = Crygen::Types::Annotation.new("MyAnnotation")

    annotation_type.generate.should eq("@[MyAnnotation]")
    annotation_type.to_s.should eq("@[MyAnnotation]")
  end

  it "creates an annotation with one parameter (value only)" do
    annotation_type = Crygen::Types::Annotation.new("MyAnnotation").add_arg("true")

    annotation_type.generate.should eq("@[MyAnnotation(true)]")
    annotation_type.to_s.should eq("@[MyAnnotation(true)]")
  end

  it "creates an annotation with one parameter (name and value)" do
    annotation_type = Crygen::Types::Annotation.new("MyAnnotation").add_arg("is_cool", "true")

    annotation_type.generate.should eq("@[MyAnnotation(is_cool: true)]")
    annotation_type.to_s.should eq("@[MyAnnotation(is_cool: true)]")
  end

  it "creates an annotation with many parameters (values only)" do
    annotation_type = Crygen::Types::Annotation.new("MyAnnotation")
    annotation_type.add_arg("true")
    annotation_type.add_arg("1")
    annotation_type.add_arg("Hello World".dump)

    annotation_type.generate.should eq("@[MyAnnotation(true, 1, \"Hello World\")]")
    annotation_type.to_s.should eq("@[MyAnnotation(true, 1, \"Hello World\")]")
  end

  it "creates an annotation with many parameters (name and value)" do
    annotation_type = Crygen::Types::Annotation.new("MyAnnotation")
    annotation_type.add_arg("is_cool", "true")
    annotation_type.add_arg("number", "1")
    annotation_type.add_arg("text", "Hello World".dump)

    expected = <<-CRYSTAL
    @[MyAnnotation(is_cool: true, number: 1, text: "Hello World")]
    CRYSTAL

    annotation_type.generate.should eq(expected)
    annotation_type.to_s.should eq(expected)
  end

  describe "annotation helpers" do
    it "#deprecated" do
      expected = <<-CRYSTAL
      @[Deprecated]
      class AnnotationTest
      end
      CRYSTAL

      annotation_type = Crygen::Types::Class.new("AnnotationTest").deprecated
      annotation_type.generate.should eq(expected)
      annotation_type.to_s.should eq(expected)

      expected = <<-CRYSTAL
      @[Deprecated("Use something instead")]
      class AnnotationTest
      end
      CRYSTAL

      annotation_type = Crygen::Types::Class.new("AnnotationTest").deprecated("Use something instead")
      annotation_type.generate.should eq(expected)
      annotation_type.to_s.should eq(expected)
    end

    it "#experimental" do
      expected = <<-CRYSTAL
      @[Experimental]
      class AnnotationTest
      end
      CRYSTAL

      annotation_type = Crygen::Types::Class.new("AnnotationTest").experimental
      annotation_type.generate.should eq(expected)
      annotation_type.to_s.should eq(expected)

      expected = <<-CRYSTAL
      @[Experimental("Lorem ipsum")]
      class AnnotationTest
      end
      CRYSTAL

      annotation_type = Crygen::Types::Class.new("AnnotationTest").experimental("Lorem ipsum")
      annotation_type.generate.should eq(expected)
      annotation_type.to_s.should eq(expected)
    end

    it "#flags" do
      expected = <<-CRYSTAL
      @[Flags]
      enum AnnotationTest
      end
      CRYSTAL

      annotation_type = Crygen::Types::Enum.new("AnnotationTest").flags
      annotation_type.generate.should eq(expected)
      annotation_type.to_s.should eq(expected)
    end

    it "#link" do
      expected = <<-CRYSTAL
      @[Link("musl")]
      lib AnnotationTest
      end
      CRYSTAL

      annotation_type = Crygen::Types::LibC.new("AnnotationTest").link("musl")
      annotation_type.generate.should eq(expected)
      annotation_type.to_s.should eq(expected)
    end

    it "#thread_local" do
      # FIXME: Complete the @[ThreadLocal] annotation spec.
    end

    it "#always_inline" do
      expected = <<-CRYSTAL
      @[AlwaysInline]
      def always_inline : Void
      end
      CRYSTAL

      annotation_type = Crygen::Types::Method.new("always_inline", "Void").always_inline
      annotation_type.generate.should eq(expected)
      annotation_type.to_s.should eq(expected)
    end

    it "#no_inline" do
      expected = <<-CRYSTAL
      @[NoInline]
      def no_inline : Void
      end
      CRYSTAL

      annotation_type = Crygen::Types::Method.new("no_inline", "Void").no_inline
      annotation_type.generate.should eq(expected)
      annotation_type.to_s.should eq(expected)
    end

    it "#call_convention" do
      # FIXME: Complete the @[CallConvention] annotation spec.
    end
  end
end
