require "./types/**"
require "./modules/**"
require "./generators/**"

abstract class String::IndentedBuilder
  @@indent = 0

  def self.with_indent(io, *, by : Int = 2, &)
    @@indent += by

    yield io, " " * @@indent
  ensure
    @@indent -= by
  end
end

# **crygen** is a library that allows to generate a Crystal file. It is inspired by the PHP
# library : [nette/php-generator](https://github.com/nette/php-generator).
module Crygen
  # Library version
  VERSION = "0.6.0"

  # CGT is an alias of "**C**ry**G**en **T**ypes".
  alias ::CGT = Crygen::Types

  # CGE is an alias of "**C**ry**G**en **E**nums".
  alias ::CGE = Crygen::Enums

  # CGG is an alias of "**C**ry**G**en **G**enerators".
  alias ::CGG = Crygen::Generators
end
