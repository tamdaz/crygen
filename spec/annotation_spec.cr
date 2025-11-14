require "./spec_helper"

describe Crygen::Types::Annotation do
  it "creates an annotation" do
    annotation_type = Crygen::Types::Annotation.new("MyAnnotation")

    assert_is_expected(annotation_type, "@[MyAnnotation]")
  end

  it "creates an annotation with one parameter (value only)" do
    annotation_type = Crygen::Types::Annotation.new("MyAnnotation")
      .add_arg("true")

    assert_is_expected(annotation_type, "@[MyAnnotation(true)]")
  end

  it "creates an annotation with one parameter (name and value)" do
    annotation_type = Crygen::Types::Annotation.new("MyAnnotation")
      .add_arg("is_cool", "true")

    assert_is_expected(annotation_type, %q<@[MyAnnotation(is_cool: true)]>)
  end

  it "creates an annotation with many parameters (values only)" do
    annotation_type = Crygen::Types::Annotation.new("MyAnnotation")
      .add_arg("true")
      .add_arg("1")
      .add_arg("Hello World".dump)

    assert_is_expected(annotation_type, %q<@[MyAnnotation(true, 1, "Hello World")]>)
  end

  it "creates an annotation with many parameters (values and #add_args method )" do
    annotation_type = Crygen::Types::Annotation.new("MyAnnotation")
      .add_args("true", "1", "Hello World".dump)

    assert_is_expected(annotation_type, %q<@[MyAnnotation(true, 1, "Hello World")]>)
  end

  it "creates an annotation with many parameters (name and value)" do
    annotation_type = Crygen::Types::Annotation.new("MyAnnotation")
      .add_arg("is_cool", "true")
      .add_arg("number", "1")
      .add_arg("text", "Hello World".dump)

    assert_is_expected(annotation_type, %q<@[MyAnnotation(is_cool: true, number: 1, text: "Hello World")]>)
  end

  describe "annotation helpers" do
    it "#deprecated" do
      expected = <<-CRYSTAL
      @[Deprecated]
      class AnnotationTest
      end
      CRYSTAL

      annotation_type = Crygen::Types::Class.new("AnnotationTest")
        .deprecated

      assert_is_expected(annotation_type, expected)

      expected = <<-CRYSTAL
      @[Deprecated("Use something instead")]
      class AnnotationTest
      end
      CRYSTAL

      annotation_type = Crygen::Types::Class.new("AnnotationTest")
        .deprecated("Use something instead")

      assert_is_expected(annotation_type, expected)
    end

    it "#experimental" do
      expected = <<-CRYSTAL
      @[Experimental]
      class AnnotationTest
      end
      CRYSTAL

      annotation_type = Crygen::Types::Class.new("AnnotationTest")
        .experimental

      assert_is_expected(annotation_type, expected)

      expected = <<-CRYSTAL
      @[Experimental("Lorem ipsum")]
      class AnnotationTest
      end
      CRYSTAL

      annotation_type = Crygen::Types::Class.new("AnnotationTest")
        .experimental("Lorem ipsum")

      assert_is_expected(annotation_type, expected)
    end

    it "#flags" do
      expected = <<-CRYSTAL
      @[Flags]
      enum AnnotationTest
      end
      CRYSTAL

      annotation_type = Crygen::Types::Enum.new("AnnotationTest")
        .flags

      assert_is_expected(annotation_type, expected)
    end

    it "#link" do
      expected = <<-CRYSTAL
      @[Link("musl")]
      lib AnnotationTest
      end
      CRYSTAL

      annotation_type = Crygen::Types::LibC.new("AnnotationTest")
        .link("musl")

      assert_is_expected(annotation_type, expected)
    end

    it "#thread_local" do
      # TODO: Complete the @[ThreadLocal] annotation spec.
      pending!("In progress...")
    end

    it "#always_inline" do
      expected = <<-CRYSTAL
      @[AlwaysInline]
      def always_inline : Void
      end
      CRYSTAL

      annotation_type = Crygen::Types::Method.new("always_inline", "Void")
        .always_inline

      assert_is_expected(annotation_type, expected)
    end

    it "#no_inline" do
      expected = <<-CRYSTAL
      @[NoInline]
      def no_inline : Void
      end
      CRYSTAL

      annotation_type = Crygen::Types::Method.new("no_inline", "Void")
        .no_inline

      assert_is_expected(annotation_type, expected)
    end

    it "#call_convention" do
      # TODO: Complete the @[CallConvention] annotation spec.
      pending!("In progress...")
    end
  end
end
