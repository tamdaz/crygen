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
class Crygen::Types::Alias < Crygen::Abstract::GeneratorInterface
  include Crygen::Modules::Comment

  def initialize(@name : String, @types : Array(String)); end

  # Generates an alias.
  def generate : String
    String.build do |str|
      @comments.each { |comment| str << "# #{comment}\n" }
      str << "alias " << @name << " = "
      types_count = @types.size
      @types.each_with_index do |type, idx|
        str << type
        str << " | " unless idx == types_count - 1
      end
    end
  end
end
