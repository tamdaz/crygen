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
