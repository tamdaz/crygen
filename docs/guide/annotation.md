# Annotation

Annotations can be generated thanks to `Crygen::Types::Annotation` class *(here abbreviated as `CGT::Annotation`)*.

```cr
annotation_type = CGT::Annotation.new("MyAnnotation")
puts annotation_type.generate
```

Output:

```cr
@[MyAnnotation]
```

## Passing values as arguments

Using the `#add_arg` method, you can add values that will be passed as arguments to the annotation.

```cr
annotation_type = CGT::Annotation.new("MyAnnotation")
annotation_type.add_arg("1")
annotation_type.add_arg("Hello world".dump)

puts annotation_type.generate
```

Output:

```cr
@[MyAnnotation(1, "Hello world")]
```

In addition, you can name the argument like:

```cr
annotation_type = CGT::Annotation.new("MyAnnotation")
annotation_type.add_arg("number", "1")
annotation_type.add_arg("text", "Hello world".dump)

puts annotation_type.generate
```

Output:

```cr
@[MyAnnotation(number: 1, text: "Hello world")]
```

!!! info
    If you want to pass the string in the argument, then you have to call the [`String#dump`](https://crystal-lang.org/api/1.17.0/String.html#dump%3AString-instance-method) method.

There's an even better way: if you pass values without necessarily naming arguments, you can use the `#add_args` method:

```cr
annotation_type = CGT::Annotation.new("MyAnnotation")
annotation_type.add_args("1", true, "Hello world".dump)

puts annotation_type.generate
```

Output:

```cr
@[MyAnnotation(1, true, "Hello world")]
```