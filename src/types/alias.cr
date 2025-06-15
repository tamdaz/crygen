require "./../modules/*"
require "./../interfaces/generator_interface"

# Class that is used to generate the aliases.
# ```
# alias_type = CGT::Alias.new("MyAlias", %w[Foo Bar])
# puts alias_type.generate
# ```
# Output:
# ```
# alias MyAlias = Foo | Bar
# ```
class Crygen::Types::Alias < Crygen::Interfaces::GeneratorInterface
  include Crygen::Modules::Comment

  def initialize(@name : String, @types : Array(String)); end

  # Generates an alias.
  def generate : String
    String.build do |str|
      str << CGG::Comment.generate(@comments)

      str << "alias " << @name << " = "

      @types.each_with_index do |type, index|
        str << type
        str << " | " unless index == @types.size - 1
      end
    end
  end
end
