# Static class generator that allows to generate the multiline comment(s).
class Crygen::Generators::Comment
  # Generates the n line comment.
  def self.generate(comments : Array(String)) : String
    String.build do |str|
      comments.each do |comment|
        str << "# " << comment << "\n"
      end
    end
  end
end
