require "./../spec_helper"

describe Crygen::Types::Class do
  it "create nested classes" do
    expected = <<-CRYSTAL
    struct Point
      struct Point
      end
    end
    CRYSTAL

    test_point_struct().add_struct(test_point_struct()).to_s.should eq(expected)
  end

  it "create 3 classes in the class" do
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

    test_point_struct()
      .add_struct(test_point_struct())
      .add_struct(test_point_struct())
      .add_struct(test_point_struct())
      .to_s.should eq(expected)
  end

  it "create 3 classes in 2 classes in the class" do
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

    test_point_struct().add_struct(
      test_point_struct()
        .add_struct(test_point_struct())
        .add_struct(test_point_struct())
        .add_struct(test_point_struct())
    ).add_struct(
      test_point_struct()
        .add_struct(test_point_struct())
        .add_struct(test_point_struct())
        .add_struct(test_point_struct())
    ).to_s.should eq(expected)
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

    point_struct = test_point_struct()
    point_struct.add_comment("Point struct")
    point_struct.add_method(
      Crygen::Types::Method.new("value", "Nil").add_comment("value method")
    )

    another_point_struct = test_point_struct()
    another_point_struct.add_comment("Another Point struct")
    another_point_struct.add_method(
      Crygen::Types::Method.new("value", "Nil").add_comment("value method")
    )

    point_struct.add_struct(another_point_struct)
    point_struct.to_s.should eq(expected)
  end
end
