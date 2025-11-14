require "./spec_helper"

describe Crygen::Types::Macro do
  it "creates a macro" do
    expected = <<-CRYSTAL
    macro example
    end
    CRYSTAL

    macro_type = Crygen::Types::Macro.new("example")

    assert_is_expected(macro_type, expected)
  end

  it "creates a macro with one arg" do
    expected = <<-CRYSTAL
    macro example(name)
    end
    CRYSTAL

    macro_type = Crygen::Types::Macro.new("example").add_arg("name")

    assert_is_expected(macro_type, expected)
  end

  it "creates a macro with many args" do
    expected = <<-CRYSTAL
    macro example(name, value)
    end
    CRYSTAL

    macro_type = Crygen::Types::Macro.new("example")
      .add_arg("name")
      .add_arg("value")

    assert_is_expected(macro_type, expected)
  end

  it "creates a macro with body (one line)" do
    expected = <<-CRYSTAL
    macro example(name, value)
      puts {{ name }}
      puts {{ value }}
      puts {{ "Hello world" }}
    end
    CRYSTAL

    macro_type = Crygen::Types::Macro.new("example")
      .add_arg("name")
      .add_arg("value")
      .add_body("puts {{ name }}")
      .add_body("puts {{ value }}")
      .add_body("puts {{ \"Hello world\" }}")

    assert_is_expected(macro_type, expected)
  end

  it "creates a macro with body (multi line)" do
    expected = <<-CRYSTAL
    macro example(name, value)
      {% for i in 1..10 %}
        puts {{ name }}
        puts {{ value }}
        puts {{ "Hello world" }}
      {% end %}
    end
    CRYSTAL

    macro_type = Crygen::Types::Macro.new("example")
      .add_arg("name")
      .add_arg("value")
      .body = <<-CRYSTAL
      {% for i in 1..10 %}
        puts {{ name }}
        puts {{ value }}
        puts {{ "Hello world" }}
      {% end %}
      CRYSTAL

    assert_is_expected(macro_type, expected)
  end

  it "generates a for loop" do
    expected = <<-CRYSTAL
    {% for item in items %}
      puts {{ item }}
    {% end %}
    CRYSTAL

    result = Crygen::Types::Macro.for_loop("item", "items") do |str, indent|
      str << indent << "puts {{ item }}\n"
    end

    assert_is_expected(result, expected)
  end

  it "generates an if condition" do
    expected = <<-CRYSTAL
    {% if x > 0 %}
      puts "positive"
    {% end %}
    CRYSTAL

    result = Crygen::Types::Macro.if("x > 0") do |str, indent|
      str << indent << "puts \"positive\"\n"
    end

    assert_is_expected(result, expected)
  end

  it "generates an unless condition" do
    expected = <<-CRYSTAL
    {% unless x > 0 %}
      puts "negative or zero"
    {% end %}
    CRYSTAL

    result = Crygen::Types::Macro.unless("x > 0") do |str, indent|
      str << indent << "puts \"negative or zero\"\n"
    end

    assert_is_expected(result, expected)
  end

  it "generates a verbatim block" do
    expected = <<-CRYSTAL
    {% verbatim do %}
      "example code"
    {% end %}
    CRYSTAL

    result = Crygen::Types::Macro.verbatim do |str, indent|
      str << indent << "\"example code\"\n"
    end

    assert_is_expected(result, expected)
  end

  it "generates a recursive verbatim block" do
    expected = <<-CRYSTAL
    {% verbatim do %}
      {% verbatim do %}
        "Hello world"
      {% end %}
    {% end %}
    CRYSTAL

    result = Crygen::Types::Macro.verbatim do |str, indent|
      str << indent << Crygen::Types::Macro.verbatim do |str2, indent2|
        str2 << indent2 << "Hello world".dump << "\n"
        str2 << indent
      end

      str << "\n"
    end

    assert_is_expected(result, expected)
  end

  it "generates a recursive if condition" do
    expected = <<-CRYSTAL
    {% if x > 0 %}
      {% if y > 0 %}
        puts "x and y are positive"
      {% end %}
    {% end %}
    CRYSTAL

    result = Crygen::Types::Macro.if("x > 0") do |str, indent|
      str << indent << Crygen::Types::Macro.if("y > 0") do |str2, indent2|
        str2 << indent2 << "puts \"x and y are positive\"\n"
        str2 << indent
      end
      str << "\n"
    end

    assert_is_expected(result, expected)
  end

  it "generates a recursive unless condition" do
    expected = <<-CRYSTAL
    {% unless x > 0 %}
      {% unless y > 0 %}
        puts "x and y aren't positive"
      {% end %}
    {% end %}
    CRYSTAL

    result = Crygen::Types::Macro.unless("x > 0") do |str, indent|
      str << indent << Crygen::Types::Macro.unless("y > 0") do |str2, indent2|
        str2 << indent2 << "puts \"x and y aren't positive\"\n"
        str2 << indent
      end
      str << "\n"
    end

    assert_is_expected(result, expected)
  end

  it "generates a verbatim block with nested if and unless conditions" do
    expected = <<-CRYSTAL
    {% verbatim do %}
      {% if condition1 %}
        {% unless condition2 %}
          "verbatim > if > unless"
        {% end %}
      {% end %}
    {% end %}
    CRYSTAL

    result = Crygen::Types::Macro.verbatim do |str, indent|
      str << indent << Crygen::Types::Macro.if("condition1") do |str2, indent2|
        str2 << indent2 << Crygen::Types::Macro.unless("condition2") do |str3, indent3|
          str3 << indent3 << "\"verbatim > if > unless\"\n"
          str3 << indent2
        end
        str2 << "\n"
        str2 << indent
      end
      str << "\n"
    end

    assert_is_expected(result, expected)
  end
end
