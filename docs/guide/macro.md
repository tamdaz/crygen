# Macro

To generate a macro, use the `Crygen::Types::Macro` class *(here abbreviated as `CGT::Macro`)*.

```crystal
macro_type = CGT::Macro.new("example")
macro_type.add_arg("name")
macro_type.add_body("puts {{ name }}")
puts macro_type.generate
```

Output:

```crystal
macro example(name)
  puts {{ name }}
end
```

## Generate a `for` loop macro

```crystal
puts Crygen::Types::Macro.for_loop("item", "items") do |str, indent|
  str << indent << "puts {{ item }}\n"
end
```

Output:

```crystal
{% for item in items %}
  puts {{ item }}
{% end %}
```

## Generate an `if` condition macro

```crystal
puts Crygen::Types::Macro.if("x > 0") do |str, indent|
  str << indent << 'puts "positive"\n'
end
```

Output:

```crystal
{% if x > 0 %}
  puts "positive"
{% end %}
```

## Generate an `unless` condition macro

```crystal
puts Crygen::Types::Macro.unless("x > 0") do |str, indent|
  str << indent << 'puts "negative or zero"\n'
end
```

Output:

```crystal
{% unless x > 0 %}
  puts "negative or zero"
{% end %}
```

## Generate a `verbatim` block

```crystal
puts Crygen::Types::Macro.verbatim do |str, indent|
  str << indent << "puts 123\n"
end
```

Output:

```crystal
{% verbatim do %}
  puts 123
{% end %}
```

## Recursive `if`, `unless` and `verbatim` macro

Also, Crygen allows you to nest one macro block inside another, but the code below will become complex in such cases.

```crystal
puts Crygen::Types::Macro.if("x > 0") do |str, indent|
  str << indent << Crygen::Types::Macro.if("y > 0") do |str2, indent2|
    str2 << indent2 << 'puts "x and y are positive"\n'
    str2 << indent
  end
  str << "\n"
end

puts "\n"

puts Crygen::Types::Macro.unless("x > 0") do |str, indent|
  str << indent << Crygen::Types::Macro.unless("y > 0") do |str2, indent2|
    str2 << indent2 << 'puts "x and y are negative"\n'
    str2 << indent
  end
  str << "\n"
end

puts "\n"

puts Crygen::Types::Macro.verbatim do |str, indent|
  str << indent << Crygen::Types::Macro.verbatim do |str2, indent2|
    str2 << indent2 << 'puts "nested verbatim"\n'
    str2 << indent
  end
  str << "\n"
end
```

Output:

```crystal
{% if x > 0 %}
  {% if y > 0 %}
    puts "x and y are positive"
  {% end %}
{% end %}

{% unless x > 0 %}
  {% unless y > 0 %}
    puts "x and y are negative"
  {% end %}
{% end %}

{% verbatim do %}
  {% verbatim do %}
    puts "nested verbatim"
  {% end %}
{% end %}
```

!!! warning
    If you want to do this recursively, you must carefully manage indentations. For example,
    the parent `verbatim` block should use the parameters `str` and `indent`. However, the child `verbatim` block
    should use its own parameters, such as `str2` and `indent2`. You need to differentiate these names to prevent the
    confusions.