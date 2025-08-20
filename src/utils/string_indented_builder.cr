# An abstract class that consists of indenting the IO. By default, the indent size is set to 2.
abstract class String::IndentedBuilder
  @@indent = 0

  def self.with_indent(io, *, by : Int = 2, &)
    @@indent += by

    yield io, " " * @@indent
  ensure
    @@indent -= by
  end
end
