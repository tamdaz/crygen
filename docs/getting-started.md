# Getting started

## Installation

To install this shard, add it to your `shard.yml` file:

```yaml
dependencies:
  crygen:
    github: tamdaz/crygen
    version: ~> 1.2.0
```

Then run `shards install`.

Once this shard is installed, you have to import crygen in your entrypoint file for example:

```cr
require "crygen"

module App
  VERSION = "1.0.0"

  # Here you can generate the Crystal code:

  class_type = CGT::Class.new("MyClass")
  method_type = CGT::Method.new("my_method", "String")

  class_type.add_method(method_type)

  puts class_type.generate
  # or
  # puts class_type

  # Output:
  # class MyClass
  #   def my_method : String
  #   end
  # end

  # You can save the generated code into the .cr file.
  File.write("src/classes/my_class.cr", class_type)
end
```

!!! info
    All classes located in the `Crygen::Types` (or `CGT`) namespace inherit from `Crygen::Interfaces::GeneratorInterface`.

Now you can explore the guide to understand how to generate the code.