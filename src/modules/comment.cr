# Module that is used to store and add the comments.
module Crygen::Modules::Comment
  protected getter comments = [] of String

  # Add a line or multiline comments.
  def add_comment(value : String) : self
    @comments += value.lines
    self
  end
end
