# Module that is used to store and add the comments.
module Crygen::Modules::Comment
  @comments = [] of String

  # Add a line or a multiline comment.
  def add_comment(value : String) : self
    @comments += value.lines
    self
  end
end
