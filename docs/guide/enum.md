# Enum

To generate an enumeration, use `Crygen::Types::Enum` *(here abbreviated as `CGT::Enum`)*.

```cr
enum_type = CGT::Enum.new("Person")
puts enum_type
```

Output:

```cr
enum Person
end
```

## Included modules

- `Crygen::Modules::Annotation`
- `Crygen::Modules::Comment`
- `Crygen::Modules::Method`

## Adding Constants

You can add constants to the enumeration in two ways:

### 1. Using the `#add_constant` Method

Add each constant individually:

```cr
enum_type = CGT::Enum.new("Person")
enum_type.add_constant("Employee")
enum_type.add_constant("Student")
enum_type.add_constant("Intern")
puts enum_type
```

### 2. Using the `#add_constants` Method

Add multiple constants at once:

```cr
enum_type = CGT::Enum.new("Person")
enum_type.add_constants(
  {"Employee", "1"},
  {"Student", "2"},
  {"Intern", "3"}
)
puts enum_type
```

!!! note
    When you assign `nil` to a specific constant, this latter will not have a value.

In both cases, the result is the same:

```cr
enum Person
  Employee = 1
  Student = 2
  Intern = 3
end
```

!!! info
    For the next version of crygen, it might be interesting to format the enumeration during the codegen
    so the assignment and values are in the right place.

## Add the comments

`Crygen::Types::Enum` provides a method for adding comments on the enumeration

```cr
enum_type = CGT::Enum.new("Person")
enum_type.add_constants(
  {"Employee", "1"}, {"Student", "2"}, {"Intern", "3"}
)

enum_type.add_comment("This is my enumeration for Person")

puts enum_type
```

```cr
# This is my enumeration for Person
enum Person
  Employee = 1
  Student = 2
  Intern = 3
end
```

## Add the annotation

Also, it's possible to add one or many annotation on the enum.

```cr
enum_type = CGT::Enum.new("Person")
enum_type.add_constants(
  {"Employee", "1"}, {"Student", "2"}, {"Intern", "3"}
)

annotation_type = CGT::Annotation.new("MyAnnotation")

enum_type.add_comment("This is my enumeration for Person")
enum_type.add_annotation(annotation_type)

puts enum_type
```

!!! warning
    If you assign each constant to a value *(numbers for example)*, these will not be double quoted during the code
    generation.


```cr
# This is my enumeration for Person
@[MyAnnotation]
enum Person
  Employee = 1
  Student = 2
  Intern = 3
end
```

!!! info
    If you add both a comment and annotations, the comment will appear at the top,
    followed by the annotation(s) and the code.

## Add a method in an enumeration

You can add one or more methods to an enumeration using the `#add_method` or `#add_methods` methods. Each method should be an instance of `Crygen::Types::Method` (here abbreviated as `CGT::Method`).

```crystal
enum_type = CGT::Enum.new("Person")
enum_type.add_constants(
  {"Employee", nil},
  {"Student", nil},
  {"Intern", nil},
)

method_is_student = CGT::Method.new("student?", "Bool")
method_is_student.add_body("self == Person::Student")

enum_type.add_method(method_is_student)

puts enum_type
```

Output:

```crystal
enum Person
  Employee
  Student
  Intern

  def student? : Bool
    self == Person::Student
  end
end
```

You can add several methods at once using `add_methods`:

```crystal
method_is_employee = CGT::Method.new("employee?", "Bool")
method_is_employee.add_body("self == Person::Employee")

method_is_intern = CGT::Method.new("intern?", "Bool")
method_is_intern.add_body("self == Person::Intern")

enum_type.add_methods(method_is_student, method_is_employee, method_is_intern)
```