# crygen

> [!WARNING]
> This library is under development, it is not completely finished.

**crygen** is a library that allows to generate a Crystal file. It is inspired by the PHP
library : [nette/php-generator](https://github.com/nette/php-generator).

- [Installation](#installation)
- [Examples usage](#examples-usage)
  - [Method](#method)
  - [Class](#class)
  - [Instance variables](#instance-variables)
  - [Class variables](#class-variables)
  - [Abstract class](#abstract-class)
  - [Enum](#enum)
  - [Annotation](#annotation)
  - [Struct](#struct)

## Installation

1. Add the dependency to your `shard.yml`:

```yaml
dependencies:
  crygen:
    github: tamdaz/crygen
```

2. Run `shards install`

## Examples usage

To generate code, you can find classes in the `CGT` module (`Crygen::Types`)

### Method

```crystal
# Create a method with one comment and a body.
method_type = CGT::Method.new("add", "Int32")
method_type.add_comment("Adds the two numbers.")
method_type.add_arg("a", "Int32")
method_type.add_arg("b", "Int32")
method_type.add_body("a + b")

puts method_type.generate
```

Once the method is generated, it will look like this : 

```crystal
# Adds the two numbers.
def add(a : Int32, b : Int32) : Int32
  a + b
end
```

> [!TIP]
> You can add new lines of comments and code to the method by calling the
> `add_comment` and `add_body` methods several times.


### Class

In addition to creating methods, you can add them to a class using the `add_method`
method of the `CGT::Class` class.

```crystal
# Create a method with one comment and a body.
method_full_name = CGT::Method.new("full_name", "String")
method_full_name.add_comment("Gets the person's full name.")
method_full_name.add_body("John Doe".dump)

# Create a class with one comment and a method.
class_person = CGT::Class.new("Person")
class_person.add_comment("This is a class called Person.")
class_person.add_method(method_full_name)

# Print the generated code.
puts class_person.generate
```

Once the code is generated, the code will look like this : 

```crystal
# This is a class called Person.
class Person
  # Gets the person's full name.
  def full_name : String
    "John Doe"
  end
end
```

### Instance variables

In a class, instance variables can be added.
```crystal
class_person = CGT::Class.new("Person")
class_type.add_instance_var("first_name", "String", "John")
class_type.add_instance_var("last_name", "String", "Doe")
puts class_person.generate
```

```crystal
class Person
  @first_name : String = "John"
  @last_name : String = "Doe"
end
```

### Class variables

In addition of instance variables, class variables can also be added.
```crystal
class_person = CGT::Class.new("Person")
class_type.add_class_var("count", "Int32", "0")
puts class_person.generate
```

```crystal
class Person
  @@count : Int32 = 0
end
```

### Abstract class
Abstract class can be generated.

```crystal
class_person = CGT::Class.new("Person")
class_type.as_abstract # Set this class as abstract.
class_type.add_method(CGT::Method.new("first_name", "String"))
class_type.add_method(CGT::Method.new("last_name", "String"))
class_type.add_method(CGT::Method.new("full_name", "String"))
puts class_person.generate
```

```crystal
abstract class Person
  abstract def first_name : String
  abstract def last_name : String
  abstract def full_name : String
end
```

> [!NOTE]  
> If you add code to an abstract method, only the method signature will be generated.

### Enum

```crystal
enum_type = CGT::Enum.new("Person")

enum_type.add_constant("Employee")
enum_type.add_constant("Student")
enum_type.add_constant("Intern")

puts enum_type.generate
```

Once the code is generated, the enum will look like this : 

```crystal
enum Person
  Employee
  Student
  Intern
end
```

In addition to this, you can specify the types of constants by passing the type as
a second argument, as well as defining default values for any constant.

```crystal
enum_type = CGT::Enum.new("Person", "Int32")
enum_type.add_constant("Employee", "1")
enum_type.add_constant("Student", "2")
enum_type.add_constant("Intern", "3")

puts enum_type.generate
```

```crystal
enum Person : Int32
  Employee = 1
  Student = 2
  Intern = 3
end
```

### Annotation

```crystal
annotation_type = CGT::Annotation.new("MyAnnotation")

puts annotation_type.generate
```

Output : 
```crystal
@[MyAnnotation]
```

With the annotation, you can add it to the method or class that allows to add metadata.

```crystal
class_type = test_person_class()
class_type.add_annotation(CGT::Annotation.new("Experimental"))
puts class_type.generate

method_type = CGT::Method.new("full_name", "String")
method_type.add_annotation(CGT::Annotation.new("MyAnnotation"))
puts method_type.generate

class_type.add_method(method_type)
puts class_type.generate
```

Output : 
```crystal
# Annotation on class
@[Experimental]
class Person
end

# Annotation on method
@[Experimental]
def full_name : String
  "John Doe"
end

# Annotation on class and method.
@[Experimental]
class Person
  @[Experimental]
  def full_name : String
    "John Doe"
  end
end
```

> [!TIP]
> You can add many annotations as you want thanks to the `add_annotation` method.

### Struct

```crystal
method_first_name = CGT::Method.new("first_name", "String")
method_first_name.add_body("John".dump)

method_last_name = CGT::Method.new("last_name", "String")
method_last_name.add_body("Doe".dump)

struct_type = CGT::Struct.new("Point")
struct_type.add_method(method_first_name)
struct_type.add_method(method_last_name)

puts struct_type.generate
```
Output : 
```crystal
struct Point
  def first_name : String
    "John"
  end

  def last_name : String
    "Doe"
  end
end
```

> More examples will be added soon.

## Usage

This library can be used to save time. In particular, the frameworks have features
for generating code more easily, without having to rewrite everything by hand.
For example, frameworks such as Adonis, Laravel and Symfony include features
for generating classes.

# Todos
- [x] : Add an instance var
- [x] : Add a class var
- [ ] : Add attributes for class (`setter`, `property` and `getter`)
- [x] : Add an enum
- [x] : Add an annotation
- [ ] : Add a module
- [x] : Add a struct
- [ ] : Add a macro
- [ ] : Add a lib (C binding)

Once the todos have been checked, this library will be released.

_Check out the references : https://crystal-lang.org/reference/1.15/syntax_and_semantics/index.html_

If there's something missing from the todo, don't hesitate to add it.

## Contributing

1. Fork it (<https://github.com/tamdaz/crygen/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [tamdaz](https://github.com/tamdaz) - creator and maintainer
