# Method

To generate a method, use the `Crygen::Types::Method` class *(here abbreviated as `CGT::Method`)*.

```cr
method_type = CGT::Method.new("full_name", "String")
puts method_type
```

Output:

```cr
def full_name : String
end
```

## Included modules

- `Crygen::Modules::Annotation`
- `Crygen::Modules::Arg`
- `Crygen::Modules::Comment`
- `Crygen::Modules::Scope`

## Writing code inside the method

Once the method is created, you can write code inside it using the `#add_body` method or by assigning to the `body` property.

```cr
method_type = CGT::Method.new("full_name", "String")
method_type.body = <<-CRYSTAL
return "John Doe"
CRYSTAL
```

Output:

```cr
def full_name : String
  return "John Doe"
end
```

It is recommended to use a heredoc when writing multiple lines of code.

## Setting the method as abstract

You can set the created method as abstract by calling the `#as_abstract` method.

```cr
method_type = CGT::Method.new("full_name", "String")
method_type.as_abstract # This method is now abstract
```

Output:

```cr
abstract def full_name : String
```

!!! info
    If you add code to the method body, this will not be shown after its code generation.