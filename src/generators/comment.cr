# Static class generator that allows to generate the multiline comment(s).
class Crygen::Generators::Comment
  # Generates the n line comment.
  def self.generate(lines : Array(String)) : String
    String.build do |str|
      lines.each { |line| str << "# " << line << "\n" }
    end
  end
end
