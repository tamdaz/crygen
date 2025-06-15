class Crygen::Generators::Annotation
  def self.generate(annotations : Array(Crygen::Types::Annotation)) : String
    String.build do |str|
      annotations.each do |annotation_type|
        str << annotation_type.generate << "\n"
      end
    end
  end
end
