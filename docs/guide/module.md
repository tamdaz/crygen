# Module

!!! note 
    All classes in the `Crygen::Types` namespace implement the `Crygen::Interfaces::GeneratorInterface` interface.
    You can add any of these objects to a `Crygen::Types::Module` instance to generate a module containing them.

You can create a module by instantiating the `CGT::Module` class *(here abbreviated as `CGT::Module`)* and adding
the code to it.

```crystal
module_type = Crygen::Types::Module.new("Folder")
puts module_type.generate
```

Output:
```crystal
module Folder
end
```

## Included modules

- `Crygen::Modules::Comment`

## Create a module with a class

```crystal
module_type = Crygen::Types::Module.new("Folder")
module_type.add_object(Crygen::Types::Class.new("File"))
puts module_type.generate
```

Output:
```crystal
module Folder
  class File
  end
end
```

## Create a module with an enum

```crystal
enum_type = Crygen::Types::Enum.new("Role", "Int8")
enum_type.add_constant("Member", "1")
enum_type.add_constant("Moderator", "2")
enum_type.add_constant("Administrator", "3")
module_type = Crygen::Types::Module.new("Folder")
module_type.add_object(enum_type)
puts module_type.generate
```

Output:
```crystal
module Folder
  enum Role : Int8
    Member = 1
    Moderator = 2
    Administrator = 3
  end
end
```