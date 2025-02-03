require "./spec_helper"

describe Crygen::Types::Macro do
  it "creates a macro" do
    Crygen::Types::Macro.new("example").generate.should eq(<<-CRYSTAL)
    macro example
    end
    CRYSTAL
  end

  it "creates a macro with one arg" do
    Crygen::Types::Macro.new("example").add_arg("name").generate.should eq(<<-CRYSTAL)
    macro example(name)
    end
    CRYSTAL
  end

  it "creates a macro with many args" do
    macro_type = Crygen::Types::Macro.new("example")
    macro_type.add_arg("name")
    macro_type.add_arg("value")
    macro_type.generate.should eq(<<-CRYSTAL)
    macro example(name, value)
    end
    CRYSTAL
  end

  it "creates a macro with body (one line)" do
    macro_type = Crygen::Types::Macro.new("example")
    macro_type.add_arg("name")
    macro_type.add_arg("value")
    macro_type.add_body("puts {{ name }}")
    macro_type.add_body("puts {{ value }}")
    macro_type.add_body("puts {{ \"Hello world\" }}")
    macro_type.generate.should eq(<<-CRYSTAL)
    macro example(name, value)
      puts {{ name }}
      puts {{ value }}
      puts {{ "Hello world" }}
    end
    CRYSTAL
  end

  it "creates a macro with body (multi line)" do
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
    macro_type.generate.should eq(<<-CRYSTAL)
    macro example(name, value)
      {% for i in 1..10 %}
        puts {{ name }}
        puts {{ value }}
        puts {{ "Hello world" }}
      {% end %}
    end
    CRYSTAL
  end
end
