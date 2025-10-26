# The static class that enables to control the indentation of the code. This is useful when we
# create the nested objects (for example: class in a class and struct in a struct).
class Crygen::Utils::Indentation
  @@number_of_indents : Int32 = 0

  # Add indentation
  def self.add_indent(size : Number = 2) : Void
    @@number_of_indents += size
  end

  def self.remove_indent(size : Number = 2) : Void
    @@number_of_indents -= size
  end

  def self.reset : Void
    @@number_of_indents = 0
  end

  def self.generate : String
    String.build do |str|
      @@number_of_indents.times { str << ' ' }
    end
  end
end
