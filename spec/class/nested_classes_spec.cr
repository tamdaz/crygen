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

  it "create a recursive class with a method & comments." do
    expected = <<-CRYSTAL
    # Node class
    class Node
      # value method
      def value : Nil
      end

      # SubNode class
      class SubNode
        # value method
        def value : Nil
        end
      end
    end
    CRYSTAL

    node_class = Crygen::Types::Class.new("Node")
    node_class.add_comment("Node class")
    node_class.add_method(
      Crygen::Types::Method.new("value", "Nil").add_comment("value method")
    )

    nested_node = Crygen::Types::Class.new("SubNode")
    nested_node.add_comment("SubNode class")
    nested_node.add_method(
      Crygen::Types::Method.new("value", "Nil").add_comment("value method")
    )
    node_class.add_class(nested_node)

    node_class.to_s.should eq(expected)
  end
end
