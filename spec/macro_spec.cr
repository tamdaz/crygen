require "./spec_helper"

describe Crygen::Types::Macro do
  it "creates a macro" do
    expected = <<-CRYSTAL
    macro example
    end
    CRYSTAL

    macro_type = Crygen::Types::Macro.new("example")

    macro_type.generate.should eq(expected)
    macro_type.to_s.should eq(expected)
  end

  it "creates a macro with one arg" do
    expected = <<-CRYSTAL
    macro example(name)
    end
    CRYSTAL

    macro_type = Crygen::Types::Macro.new("example").add_arg("name")
    macro_type.generate.should eq(expected)
    macro_type.to_s.should eq(expected)
  end

  it "creates a macro with many args" do
    expected = <<-CRYSTAL
    macro example(name, value)
    end
    CRYSTAL

    macro_type = Crygen::Types::Macro.new("example")
    macro_type.add_arg("name")
    macro_type.add_arg("value")
    macro_type.generate.should eq(expected)
    macro_type.to_s.should eq(expected)
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
    macro_type.add_arg("name")
    macro_type.add_arg("value")
    macro_type.add_body("puts {{ name }}")
    macro_type.add_body("puts {{ value }}")
    macro_type.add_body("puts {{ \"Hello world\" }}")
    macro_type.generate.should eq(expected)
    macro_type.to_s.should eq(expected)
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
    macro_type.add_arg("name")
    macro_type.add_arg("value")
    macro_type.body = <<-CRYSTAL
    {% for i in 1..10 %}
      puts {{ name }}
      puts {{ value }}
      puts {{ "Hello world" }}
    {% end %}
    CRYSTAL

    macro_type.generate.should eq(expected)
    macro_type.to_s.should eq(expected)
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

    result.should eq expected
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

    result.should eq expected
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
    result.should eq expected
  end

  it "generates a verbatim block" do
    expected = <<-CRYSTAL
    {% verbatim do %}
      example code
    {% end %}
    CRYSTAL

    result = Crygen::Types::Macro.verbatim do |str, indent|
      str << indent << "example code\n"
    end
    result.should eq expected
  end
end
