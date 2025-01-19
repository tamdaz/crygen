require "./spec_helper"

describe Crygen::Types::Enum do
  it "creates an annotation" do
    annotation_type = Crygen::Types::Annotation.new("MyAnnotation")

    annotation_type.generate.should eq(<<-CRYSTAL)
    @[MyAnnotation]
    CRYSTAL
  end

  it "creates an annotation with one parameter" do
    annotation_type = Crygen::Types::Annotation.new("MyAnnotation")
    annotation_type.add_arg("true")
    annotation_type.generate.should eq(<<-CRYSTAL)
    @[MyAnnotation(true)]
    CRYSTAL
  end

  it "creates an annotation with many parameters" do
    annotation_type = Crygen::Types::Annotation.new("MyAnnotation")
    annotation_type.add_arg("true")
    annotation_type.add_arg("1")
    annotation_type.add_arg("Hello World".dump)
    annotation_type.generate.should eq(<<-CRYSTAL)
    @[MyAnnotation(true, 1, "Hello World")]
    CRYSTAL
  end
end
