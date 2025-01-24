# Classes located in the `src/types` folder must always have a public method named `generate`.
abstract class Crygen::Abstract::GeneratorInterface
  # This method generates a class.
  abstract def generate : String
end
