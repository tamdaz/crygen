require "./../modules/*"
require "./../interfaces/generator_interface"

class Crygen::Types::Alias < Crygen::Abstract::GeneratorInterface
  include Crygen::Modules::Comment

  def initialize(@name : String, @types : Array(String))
  end

  def generate : String
    String.build do |str|
      @comments.each { |comment| str << "# #{comment}\n" }
      str << "alias "
      str << @name
      str << " = "
      types_count = @types.size
      @types.each_with_index do |type, idx|
        str << type
        str << " | " unless idx == types_count - 1
      end
    end
  end
end
