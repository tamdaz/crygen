# The `Crygen::Abstract::GeneratorInterface` is an interface with a method signature : `generate`.
# This latter must return a string to easily get the generated code.
# This rule is applied to classes located in the `src/types` directory.
abstract class Crygen::Abstract::GeneratorInterface
  # This method generates a class.
  abstract def generate : String
end
