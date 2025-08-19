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
end
