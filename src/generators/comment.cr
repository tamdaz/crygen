class Crygen::Generators::Comment
  def self.generate(comments : Array(String)) : String
    String.build do |str|
      comments.each do |comment|
        str << "# " << comment << "\n"
      end
    end
  end
end
