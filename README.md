# crygen

> [!WARNING]
> This library is under development, it is not completely finished.

**crygen** is a library that allows to generate a Crystal file. It is inspired by the PHP
library : [nette/php-generator](https://github.com/nette/php-generator).

## Installation

1. Add the dependency to your `shard.yml`:

```yaml
dependencies:
  crygen:
    github: tamdaz/crygen
```

2. Run `shards install`

## Usage

```crystal
require "crygen"

module Project
  method_full_name = CGT::Method.new("full_name", "String")
  method_full_name.add_comment("Gets the person's full name.")

  class_person = CGT::Class.new("Person")
  class_person.add_method(method_full_name)
end
```

# Todos
- [ ] : Add an instance var
- [ ] : Add a class var
- [ ] : Add a block
- [ ] : Add an enum
- [ ] : Add an annotation
- [ ] : Add a module
- [ ] : Add a generic for class
- [ ] : Add a struct
- [ ] : Add a constant
- [ ] : Add a macro
- [ ] : Add a lib (C binding)

Check out the references : https://crystal-lang.org/reference/1.15/syntax_and_semantics/index.html

## Contributing

1. Fork it (<https://github.com/tamdaz/crygen/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [tamdaz](https://github.com/tamdaz) - creator and maintainer
