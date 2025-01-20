require "./types/**"
require "./modules/**"

# **crygen** is a library that allows to generate a Crystal file. It is inspired by the PHP
# library : [nette/php-generator](https://github.com/nette/php-generator).
module Crygen
  # Library version
  VERSION = "0.1.0"

  # CGT is a alias of "**C**ry**G**en **T**ypes", it simplifies the name.
  alias ::CGT = Crygen::Types
end
