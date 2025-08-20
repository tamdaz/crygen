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

!!! note
    TODO: write this section.