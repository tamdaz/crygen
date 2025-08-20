# Alias

Crygen provides a class to generate an alias. To do this, use `Crygen::Types::Alias`
*(here abbreviated as `CGT::Alias`)*.

This class takes 2 parameters: the alias name and an array of strings which are types name.

```cr
puts CGT::Alias.new("MyAlias", %w[Foo Bar])
```

Output:

```cr
alias MyAlias = Foo | Bar
```

## Included modules

- `Crygen::Modules::Comment`

## Add the comment on an alias

In addition of creating an alias, you can put the comment on it.

```cr
alias_type = CGT::Alias.new("MyAlias", %w[Foo Bar])
alias_type.add_comment(<<-STR)
For example, this is my alias.
STR
```

Output:

```cr
# For example, this is my alias.
alias MyAlias = Foo | Bar
```
