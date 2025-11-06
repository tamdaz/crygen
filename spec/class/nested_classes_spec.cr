require "./../spec_helper"

describe Crygen::Types::Class do
  it "create nested classes" do
    expected = <<-CRYSTAL
    class Person
      class Person
      end
    end
    CRYSTAL

    test_person_class().add_class(test_person_class()).to_s.should eq(expected)
  end

  it "create 3 classes in the class" do
    expected = <<-CRYSTAL
    class Person
      class Person
      end

      class Person
      end

      class Person
      end
    end
    CRYSTAL

    test_person_class()
      .add_class(test_person_class())
      .add_class(test_person_class())
      .add_class(test_person_class())
      .to_s.should eq(expected)
  end

  it "create 3 classes in 2 classes in the class" do
    expected = <<-CRYSTAL
    class Person
      class Person
        class Person
        end

        class Person
        end

        class Person
        end
      end

      class Person
        class Person
        end

        class Person
        end

        class Person
        end
      end
    end
    CRYSTAL

    test_person_class().add_class(
      test_person_class()
        .add_class(test_person_class())
        .add_class(test_person_class())
        .add_class(test_person_class())
    ).add_class(
      test_person_class()
        .add_class(test_person_class())
        .add_class(test_person_class())
        .add_class(test_person_class())
    ).to_s.should eq(expected)
  end
end
