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
end
