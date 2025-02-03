# Allows to include instance var and methods concerning comments.
# In Crystal, we can put the comment on any objects.
module Crygen::Modules::Comment
  @comments = [] of String

  # Add a line or multiline comment on an object.
  def add_comment(value : String) : self
    value.each_line do |line|
      @comments << line
    end
    self
  end
end
