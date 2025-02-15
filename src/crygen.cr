require "./types/**"
require "./modules/**"

# **crygen** is a library that allows to generate a Crystal file. It is inspired by the PHP
# library : [nette/php-generator](https://github.com/nette/php-generator).
module Crygen
  # Library version
  VERSION = "0.3.1"

  # CGT is an alias of "**C**ry**G**en **T**ypes".
  alias ::CGT = Crygen::Types

  # CGE is an alias of "**C**ry**G**en **E**nums".
  alias ::CGE = Crygen::Enums
end
