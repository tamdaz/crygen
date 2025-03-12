# Module that is used to store and add the annotations.
module Crygen::Modules::Annotation
  @annotations = [] of Crygen::Types::Annotation

  # Adds annotation(s) onto object.
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
end
