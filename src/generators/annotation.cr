# Static class generator that allows to generate the annotation(s).
class Crygen::Generators::Annotation
  # Generates the annotation(s).
  def self.generate(annotations : Array(Crygen::Types::Annotation)) : String
    String.build do |str|
      annotations.each do |annotation_type|
        str << annotation_type.generate << "\n"
      end
    end
  end
end
