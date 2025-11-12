# Static class generator that allows to generate the annotation(s).
class Crygen::Generators::Annotation
  # Generates the annotation(s).
  def self.generate(annotations : Array(Crygen::Types::Annotation)) : String
    String.build do |str|
      annotations.each { |ann| str << ann << "\n" }
    end
  end
end
