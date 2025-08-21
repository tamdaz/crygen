# C binding

You can create a C binding by instantiating the `CGT::LibC` class *(here abbreviated as `CGT::LibC`)*
and adding methods to it.

```crystal
libc_type = Crygen::Types::LibC.new("C")
puts libc_type.generate
```

Output:
```crystal
lib C
end
```

## Included modules

- `Crygen::Modules::Annotation`


## Create a binding with a function

```crystal
libc_type = Crygen::Types::LibC.new("C")
libc_type.add_function("getch", "Int32")
puts libc_type.generate
```

Output:
```crystal
lib C
  fun getch : Int32
end
```

## Create a binding with a struct

```crystal
libc_type = Crygen::Types::LibC.new("C")
libc_type.add_struct("Person", [{"name", "String"}, {"age", "Int32"}])
puts libc_type.generate
```

Output:
```crystal
lib C
  struct Person
    name : String
    age : Int32
  end
end
```

## Create a binding with a union

```crystal
libc_type = Crygen::Types::LibC.new("C")
libc_type.add_union("IntOrFloat", [
  {"some_int", "Int32"},
  {"some_float", "Float64"}
])
puts libc_type.generate
```

Output:
```crystal
lib C
  union IntOrFloat
    some_int : Int32
    some_float : Float64
  end
end
```