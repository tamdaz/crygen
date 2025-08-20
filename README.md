# crygen

![license](https://img.shields.io/github/license/tamdaz/crygen)
![GitHub Release](https://img.shields.io/github/v/release/tamdaz/crygen)
![ci](https://github.com/tamdaz/crygen/actions/workflows/ci.yml/badge.svg?branch=main)
![commit activity](https://img.shields.io/github/commit-activity/m/tamdaz/crygen)
![issues](https://img.shields.io/github/issues/tamdaz/crygen)
![prs](https://img.shields.io/github/issues-pr/tamdaz/crygen)

**crygen** is a library that allows to generate a Crystal file. It is inspired by the PHP
library : [nette/php-generator](https://github.com/nette/php-generator).

## Installation

1. Add the dependency to your `shard.yml`:

```yaml
dependencies:
  crygen:
    github: tamdaz/crygen
    version: ~> 0.6.0
```

2. Run `shards install`

3. Finally, import `crygen` from the entrypoint file:

```cr
require "crygen"

module App
  VERSION = "1.0.0"

  class_type = CGT::Class.new("MyClass")
  method_type = CGT::Method.new("my_method", "String")

  class_type.add_method(method_type)

  puts class_type.generate
  # or
  puts class_type

  # Output:
  # class MyClass
  #   def my_method : String
  #   end
  # end

  # You can save the generated code into the .cr file.
  File.write("src/classes/my_class.cr", class_type)
```

## Contributing

1. Fork it (<https://github.com/tamdaz/crygen/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

<a href="https://github.com/tamdaz/crygen/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=tamdaz/crygen" />
</a>
