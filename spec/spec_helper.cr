require "spec"
require "../src/crygen"

# Easily gets a Person class that will be generated for unit tests.
def test_person_class : CGT::Class
  CGT::Class.new("Person")
end

# Easily gets a Point class that will be generated for unit tests.
def test_point_struct : CGT::Struct
  CGT::Struct.new("Point")
end

# Assert that the generated code is equal to the expected code.
def assert_is_expected(generated_code : Crygen::Interfaces::GeneratorInterface, expected : String) : Void
  generated_code.to_s.should eq(expected)
  generated_code.generate.should eq(expected)
end

# :ditto:
def assert_is_expected(generated_code : String, expected : String) : Void
  generated_code.should eq(expected)
end
