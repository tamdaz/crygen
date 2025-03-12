# Module that is used to store and add the comments.
module Crygen::Modules::Comment
  @comments = [] of String

  # Add a line or a multiline comment.
  def add_comment(value : String) : self
    value.each_line do |line|
      @comments << line
    end
    self
  end
end
