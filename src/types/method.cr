require "./../modules/*"

class Crygen::Types::Method
  include Crygen::Modules::Comment
  include Crygen::Modules::Scope
  include Crygen::Modules::Arg

  def initialize(@name : String, @return_type : String); end

  def generate : String
    String.build do |str|
      @comments.each { |comment| str << "# #{comment}\n" }
      str << @scope.to_s + " " unless @scope == :public
      str << "def #{@name}#{generate_args} : #{@return_type}\n"
      str << "end"
    end
  end
end
