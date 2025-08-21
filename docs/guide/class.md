# Class

To generate a class, use the `Crygen::Types::Class` class *(here abbreviated as `CGT::Class`)*.

```cr
class_type = Crygen::Types::Class.new("MyClass")
puts class_type
```

Output:

```cr
class MyClass
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

```cr
class_type = CGT::Class.new("MyClass")
# You can now use methods from included modules, e.g., add a comment
class_type.add_comment("This is a sample class")
puts class_type
```

Output:

```cr
# This is a sample class
class MyClass
end
```

## Add several methods

You can add as many methods as you want to the class.

```cr
class_type = CGT::Class.new("MyClass")
method_full_name = CGT::Method.new("full_name", "String")
method_is_major = CGT::Method.new("is_major?", "Bool")

class_type.add_method(method_full_name)
class_type.add_method(method_is_major)

puts class_type
```

Output:

```cr
class MyClass
  def full_name : String
  end

  def is_major? : Bool
  end
end
```

## Set the class as abstract

You can set the class as abstract using the `#as_abstract` method.

```cr
class_type = CGT::Class.new("MyClass")
class_type.as_abstract
method_full_name = CGT::Method.new("full_name", "String")
class_type.add_method(method_full_name)

puts class_type
```

Output:

```cr
abstract class MyClass
  def full_name : String
  end
end
```

## Add mixins for a class

Crygen provides functionalities to add modules you want to import or extend for the classes.

For example, you can generate a class and add modules to import or extend using `#add_includes` and `#add_extends`.

```cr
class_type = CGT::Class.new("Person")
class_type.add_includes(%w[FirstModule SecondModule])
class_type.add_extends(%w[MyExtension AnotherExtension])
puts class_type
```

Output:

```cr
class Person
  include FirstModule
  include SecondModule
  extend MyExtension
  extend AnotherExtension
end
```

!!! note
    For future versions of Crygen, it might be interesting to choose the order (includes first or extends) and
    also to choose a whitespace between the includes and the extends.

## Add instance variables

You can add instance variables to the class.

```cr
class_type = CGT::Class.new("User")
class_type.add_instance_var("name", "String")
class_type.add_instance_var("age", "Int32")
puts class_type
```

Output:

```cr
class User
  @name : String
  @age : Int32
end
```

## Add class variables

In addition to instance variables, class variables can also be added.

```cr
class_type = CGT::Class.new("Counter")
class_type.add_class_var("count", "Int32")
puts class_type
```

Output:

```cr
class Counter
  @@count : Int32
end
```

## Add properties

For the class, you can add properties: `getter`, `property`, `setter`. Nilable and static properties are also possible.

```cr
class_type = CGT::Class.new("Book")
class_type.add_property(:getter, "title", "String")
class_type.add_property(:nil_property, "author", "String")
class_type.add_property(:setter, "isbn", "String?")
class_type.add_property(:class_getter, "total_books", "Int32",)
puts class_type
```

Output:

```cr
class Book
  getter title : String
  property? author : String
  setter isbn : String?
  class_getter total_books : Int32
end
```