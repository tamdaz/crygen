# The `Crygen::Interfaces::GeneratorInterface` is an interface with a method signature : `generate`.
# This latter must return a string to easily get the generated code.
# This rule is applied to classes located in the `src/types` directory.
abstract class Crygen::Interfaces::GeneratorInterface
  # This method is used to generates an object.
  abstract def generate : String
end
