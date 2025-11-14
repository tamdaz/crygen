require "./../spec_helper"

describe Crygen::Types::Struct do
  it "create nested structs" do
    expected = <<-CRYSTAL
    struct Point
      struct Point
      end
    end
    CRYSTAL

    nested_structs = test_point_struct()
      .add_struct(test_point_struct())

    assert_is_expected(nested_structs, expected)
  end

  it "create 3 structs in the struct" do
    expected = <<-CRYSTAL
    struct Point
      struct Point
      end

      struct Point
      end

      struct Point
      end
    end
    CRYSTAL

    nested_structs = test_point_struct()
      .add_struct(test_point_struct())
      .add_struct(test_point_struct())
      .add_struct(test_point_struct())

    assert_is_expected(nested_structs, expected)
  end

  it "create 3 structs in 2 structs in the struct" do
    expected = <<-CRYSTAL
    struct Point
      struct Point
        struct Point
        end

        struct Point
        end

        struct Point
        end
      end

      struct Point
        struct Point
        end

        struct Point
        end

        struct Point
        end
      end
    end
    CRYSTAL

    nested_structs = test_point_struct()
      .add_struct(
        test_point_struct()
          .add_struct(test_point_struct())
          .add_struct(test_point_struct())
          .add_struct(test_point_struct())
      )
      .add_struct(
        test_point_struct()
          .add_struct(test_point_struct())
          .add_struct(test_point_struct())
          .add_struct(test_point_struct())
      )

    assert_is_expected(nested_structs, expected)
  end

  it "create a recursive struct with a method & comments." do
    expected = <<-CRYSTAL
    # Point struct
    struct Point
      # value method
      def value : Nil
      end

      # Another Point struct
      struct Point
        # value method
        def value : Nil
        end
      end
    end
    CRYSTAL

    value_method = Crygen::Types::Method.new("value", "Nil").add_comment("value method")

    point_struct = test_point_struct()
      .add_comment("Point struct")
      .add_method(value_method)

    nested_point_struct = test_point_struct()
      .add_comment("Another Point struct")
      .add_method(value_method)

    point_struct.add_struct(nested_point_struct)

    assert_is_expected(point_struct, expected)
  end
end
