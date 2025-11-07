# The static class that enables to control the indentation of the code. This is useful when we
# create the nested objects (for example: class in a class and struct in a struct).
# TODO: Document this static class.
class Crygen::Utils::Indentation
  @@number_of_spaces : Int32 = 0
  @@saved_number : Int32 = 0

  # Add indentation
  def self.add_indent(size : Number = 2) : Void
    @@number_of_spaces += size
  end

  def self.remove_indent(size : Number = 2) : Void
    @@number_of_spaces -= size
  end

  def self.reset : Void
    @@saved_number = @@number_of_spaces
    @@number_of_spaces = 0
  end

  def self.complete_reset : Void
    @@number_of_spaces = 0
    @@saved_number = 0
  end

  def self.restore : Void
    @@number_of_spaces = @@saved_number
    @@saved_number = 0
  end

  def self.generate : String
    String.build do |str|
      @@number_of_spaces.times { str << ' ' }
    end
  end
end
