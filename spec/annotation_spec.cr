require "./spec_helper"

describe Crygen::Types::Enum do
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
end
