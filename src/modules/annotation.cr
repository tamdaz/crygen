require "./../types/annotation"
require "./../helpers/annotation"

# Module that is used to store and add the annotations.
module Crygen::Modules::Annotation
  include Crygen::Helpers::Annotation

  @annotations = [] of Crygen::Types::Annotation

  # Adds the annotation onto object.
  # Example:
  # ```
  # class_type = CGT::Class.new("Person")
  # class_type.add_annotation(CGT::Annotation.new("Experimental"))
  # class_type.add_annotation(CGT::Annotation.new("AnotherAnnotation"))
  # ```
  # Output:
  # ```
  # @[Experimental]
  # @[AnotherAnnotation]
  # class Person
  # end
  # ```
  def add_annotation(annotation_type : Crygen::Types::Annotation) : self
    @annotations << annotation_type
    self
  end

  # Adds annotations onto object.
  # Example:
  # ```
  # class_type = CGT::Class.new("Person")
  # class_type.add_annotation(
  #   CGT::Annotation.new("Experimental"),
  #   CGT::Annotation.new("AnotherAnnotation")
  # )
  # ```
  # Output:
  # ```
  # @[Experimental]
  # @[AnotherAnnotation]
  # class Person
  # end
  # ```
  def add_annotations(*annotation_type : Crygen::Types::Annotation) : self
    @annotations += annotation_type.to_a
    self
  end
end
