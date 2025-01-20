# A class that is considered as a type must always have a "generate" method.
abstract class Crygen::Abstract::GeneratorInterface
  # This method allows to generate a class.
  abstract def generate : String
end
