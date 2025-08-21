# Struct

You can create a struct by instantiating the `CGT::Struct` class *(here abbreviated as `CGT::Struct`)*
and adding methods to it.

```crystal
method_full_name = CGT::Method.new("full_name", "String")
method_full_name.add_body("John Doe".dump)

struct_type = CGT::Struct.new("Person")
struct_type.add_method(method_full_name)

puts struct_type.generate
```

Output:

```crystal
struct Person
  def full_name : String
    "John Doe"
  end
end
```

## Included modules

- `Crygen::Modules::Annotation`
- `Crygen::Modules::ClassVar`
- `Crygen::Modules::Comment`
- `Crygen::Modules::InstanceVar`
- `Crygen::Modules::Method`
- `Crygen::Modules::Mixin`
- `Crygen::Modules::Property`

## Adding multiple methods

You can add several methods at once using `add_methods`:

```crystal
method_first_name = CGT::Method.new("first_name", "String")
method_first_name.add_body("John".dump)

method_last_name = CGT::Method.new("last_name", "String")
method_last_name.add_body("Doe".dump)

struct_type = CGT::Struct.new("User")
struct_type.add_methods(method_first_name, method_last_name)

puts struct_type.generate
```

Output:

```crystal
struct User
  def first_name : String
    "John"
  end

  def last_name : String
    "Doe"
  end
end
```

## Inheriting from an abstract struct

You can specify a parent abstract struct when creating a new struct:

```crystal
struct_type = CGT::Struct.new("Employee", "AbstractEmployee")
puts struct_type.generate
```

Output:

```crystal
struct Employee < AbstractEmployee
end
```

## Adding properties, mixins, and comments

You can also add properties, mixins, and comments to your struct:

```crystal
struct_type = CGT::Struct.new("Point")
struct_type.add_property("x", "Int32")
struct_type.add_property("y", "Int32")
struct_type.add_mixin("JSON::Serializable")
struct_type.add_comment("Represents a 2D point.")

puts struct_type.generate
```

Output:

```crystal
# Represents a 2D point.
struct Point
  include JSON::Serializable

  property x : Int32
  property y : Int32
end
```