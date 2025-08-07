require "./spec_helper"

describe Crygen::Types::LibC do
  it "creates a C library" do
    expected = <<-CRYSTAL
    lib C
    end
    CRYSTAL

    lib_c = Crygen::Types::LibC.new("C")
    lib_c.generate.should eq(expected)
    lib_c.to_s.should eq(expected)
  end

  it "creates a C library with one function" do
    expected = <<-CRYSTAL
    lib C
      fun getch : Int32
    end
    CRYSTAL

    lib_c = Crygen::Types::LibC.new("C").add_function("getch", "Int32")
    lib_c.generate.should eq(expected)
    lib_c.to_s.should eq(expected)
  end

  it "creates a C library with one function and a parameter" do
    expected = <<-CRYSTAL
    lib C
      fun getch(arg : String) : Int32
    end
    CRYSTAL

    lib_c = Crygen::Types::LibC.new("C").add_function("getch", "Int32", [{"arg", "String"}])
    lib_c.generate.should eq(expected)
    lib_c.to_s.should eq(expected)
  end

  it "creates a C library with one function and more parameters" do
    args = [
      {"arg", "String"},
      {"value", "Int32"},
    ]

    expected = <<-CRYSTAL
    lib C
      fun getch(arg : String, value : Int32) : Int32
    end
    CRYSTAL

    libc_type = Crygen::Types::LibC.new("C")
    libc_type.add_function("getch", "Int32", args)
    libc_type.generate.should eq(expected)
    libc_type.to_s.should eq(expected)
  end

  it "creates a C library with many functions" do
    expected = <<-CRYSTAL
    lib C
      fun getch : Int32
      fun time : Int32
      fun getpid : Int32
    end
    CRYSTAL

    libc_type = Crygen::Types::LibC.new("C")
    libc_type.add_function("getch", "Int32")
    libc_type.add_function("time", "Int32")
    libc_type.add_function("getpid", "Int32")
    libc_type.generate.should eq(expected)
    libc_type.to_s.should eq(expected)
  end

  it "creates a C library with one struct" do
    expected = <<-CRYSTAL
    lib C
      struct TimeZone
        field_one : Int32
        field_two : Int32
      end
    end
    CRYSTAL

    libc_type = Crygen::Types::LibC.new("C")
    libc_type.add_struct("TimeZone", [
      {"field_one", "Int32"},
      {"field_two", "Int32"},
    ])

    libc_type.generate.should eq(expected)
    libc_type.to_s.should eq(expected)
  end

  it "creates a C library with many structs" do
    expected = <<-CRYSTAL
    lib C
      struct TimeZone
        field_one : Int32
        field_two : Int32
      end

      struct DateTime
        timestamp : Int64
      end
    end
    CRYSTAL

    libc_type = Crygen::Types::LibC.new("C")
    libc_type.add_struct("TimeZone", [
      {"field_one", "Int32"},
      {"field_two", "Int32"},
    ])

    libc_type.add_struct("DateTime", [
      {"timestamp", "Int64"},
    ])

    libc_type.generate.should eq(expected)
    libc_type.to_s.should eq(expected)
  end

  it "creates a C library with one union" do
    expected = <<-CRYSTAL
    lib C
      union IntOrFloat
        some_int : Int32
        some_float : Float64
      end
    end
    CRYSTAL

    libc_type = Crygen::Types::LibC.new("C")
    libc_type.add_union("IntOrFloat", [
      {"some_int", "Int32"},
      {"some_float", "Float64"},
    ])
    libc_type.generate.should eq(expected)
    libc_type.to_s.should eq(expected)
  end

  it "creates a C library with many unions" do
    expected = <<-CRYSTAL
    lib C
      union IntOrFloat
        some_int : Int32
        some_float : Float64
      end

      union CharOrString
        some_char : Char
        some_string : String
      end
    end
    CRYSTAL

    libc_type = Crygen::Types::LibC.new("C")
    libc_type.add_union("IntOrFloat", [
      {"some_int", "Int32"},
      {"some_float", "Float64"},
    ])
    libc_type.add_union("CharOrString", [
      {"some_char", "Char"},
      {"some_string", "String"},
    ])
    libc_type.generate.should eq(expected)
    libc_type.to_s.should eq(expected)
  end

  it "creates a C library with functions, structs and unions" do
    expected = <<-CRYSTAL
    lib C
      struct TimeZone
        field_one : Int32
        field_two : Int32
      end

      struct DateTime
        timestamp : Int64
      end

      union IntOrFloat
        some_int : Int32
        some_float : Float64
      end

      union CharOrString
        some_char : Char
        some_string : String
      end

      fun getch : Int32
      fun time : Int32
      fun getpid : Int32
    end
    CRYSTAL

    libc_type = Crygen::Types::LibC.new("C")
    libc_type.add_function("getch", "Int32")
    libc_type.add_function("time", "Int32")
    libc_type.add_function("getpid", "Int32")
    libc_type.add_struct("TimeZone", [
      {"field_one", "Int32"},
      {"field_two", "Int32"},
    ])
    libc_type.add_struct("DateTime", [
      {"timestamp", "Int64"},
    ])
    libc_type.add_union("IntOrFloat", [
      {"some_int", "Int32"},
      {"some_float", "Float64"},
    ])
    libc_type.add_union("CharOrString", [
      {"some_char", "Char"},
      {"some_string", "String"},
    ])

    libc_type.generate.should eq(expected)
    libc_type.to_s.should eq(expected)
  end

  it "creates a C library with `#as_link` helper" do
    args = [
      {"arg", "String"},
      {"value", "Int32"},
    ]

    expected = <<-CRYSTAL
    @[Link("mylink")]
    lib C
      fun getch(arg : String, value : Int32) : Int32
    end
    CRYSTAL

    libc_type = Crygen::Types::LibC.new("C")
    libc_type.add_function("getch", "Int32", args)
    libc_type.link("mylink")

    libc_type.generate.should eq(expected)
    libc_type.to_s.should eq(expected)
  end
end
