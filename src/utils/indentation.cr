# The static class that enables to control the indentation of the code. This is useful when we
# create the nested objects (for example: nested classes and structs).
class Crygen::Utils::Indentation
  # Number of spaces to indent
  @@number_of_spaces : Int32 = 0

  # Used to save the number of spaces after reset.
  @@saved_number : Int32 = 0

  # Adds the indentation with the defined size.
  def self.add_indent(size : Number = 2) : Void
    if size < 0
      raise "You can't use the negative number for adding the indentation."
    end

    @@number_of_spaces += size
  end

  # Removes the indentation with the defined size.
  def self.remove_indent(size : Number = 2) : Void
    if size < 0
      raise "You can't use the negative number for removing the indentation."
    end

    if @@number_of_spaces - size >= 0
      @@number_of_spaces -= size
    else
      @@number_of_spaces = 0
    end
  end

  # Resets temporarily the indentation to zero but keep the number for restoring.
  def self.reset : Void
    @@saved_number = @@number_of_spaces
    @@number_of_spaces = 0
  end

  # Resets the indentation to zero without restoration.
  def self.complete_reset : Void
    @@number_of_spaces = 0
    @@saved_number = 0
  end

  # Restores the number of spaces for indentation.
  def self.restore : Void
    @@number_of_spaces = @@saved_number
    @@saved_number = 0
  end

  # Generate the indentation.
  def self.generate : String
    String.build do |str|
      @@number_of_spaces.times { str << ' ' }
    end
  end
end
