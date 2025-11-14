require "./spec_helper"

describe Crygen::Types::Enum do
  it "creates an enum" do
    enum_type = Crygen::Types::Enum.new("Person")
      .add_constant("Employee")
      .add_constant("Student")
      .add_constant("Intern")

    expected = <<-CRYSTAL
    enum Person
      Employee
      Student
      Intern
    end
    CRYSTAL

    assert_is_expected(enum_type, expected)
  end

  it "creates an enum with the comment" do
    enum_type = Crygen::Types::Enum.new("Person")
      .add_comment("Hello world")
      .add_constant("Employee")
      .add_constant("Student")
      .add_constant("Intern")

    expected = <<-CRYSTAL
    # Hello world
    enum Person
      Employee
      Student
      Intern
    end
    CRYSTAL

    assert_is_expected(enum_type, expected)
  end

  it "creates an enum (with #add_constants method)" do
    enum_type = Crygen::Types::Enum.new("Person")
      .add_constants({"Employee", nil}, {"Student", nil}, {"Intern", nil})

    expected = <<-CRYSTAL
    enum Person
      Employee
      Student
      Intern
    end
    CRYSTAL

    assert_is_expected(enum_type, expected)
  end

  it "creates an enum with the value of constants (with #add_constants method)" do
    enum_type = Crygen::Types::Enum.new("Person")
      .add_constants({"Employee", "1"}, {"Student", "2"}, {"Intern", "3"})

    expected = <<-CRYSTAL
    enum Person
      Employee = 1
      Student = 2
      Intern = 3
    end
    CRYSTAL

    assert_is_expected(enum_type, expected)
  end

  it "creates an enum with one method" do
    method_is_student = Crygen::Types::Method.new("student?", "Bool")
      .add_body("self == Person::Student")

    enum_type = Crygen::Types::Enum.new("Person")
      .add_constant("Employee")
      .add_constant("Student")
      .add_constant("Intern")
      .add_method(method_is_student)

    expected = <<-CRYSTAL
    enum Person
      Employee
      Student
      Intern

      def student? : Bool
        self == Person::Student
      end
    end
    CRYSTAL

    assert_is_expected(enum_type, expected)
  end

  it "creates an enum with many methods" do
    method_is_student = Crygen::Types::Method.new("student?", "Bool")
      .add_body("self == Person::Student")

    method_is_employee = Crygen::Types::Method.new("employee?", "Bool")
      .add_body("self == Person::Employee")

    method_is_intern = Crygen::Types::Method.new("intern?", "Bool")
      .add_body("self == Person::Intern")

    enum_type = Crygen::Types::Enum.new("Person")
      .add_constant("Employee")
      .add_constant("Student")
      .add_constant("Intern")
      .add_methods(method_is_student, method_is_employee, method_is_intern)

    expected = <<-CRYSTAL
    enum Person
      Employee
      Student
      Intern

      def student? : Bool
        self == Person::Student
      end

      def employee? : Bool
        self == Person::Employee
      end

      def intern? : Bool
        self == Person::Intern
      end
    end
    CRYSTAL

    assert_is_expected(enum_type, expected)
  end

  it "creates an enum with a type" do
    enum_type = Crygen::Types::Enum.new("Person", "Int8")
      .add_constant("Employee")
      .add_constant("Student")
      .add_constant("Intern")

    expected = <<-CRYSTAL
    enum Person : Int8
      Employee
      Student
      Intern
    end
    CRYSTAL

    assert_is_expected(enum_type, expected)
  end

  it "creates an enum with a type and default values" do
    enum_type = Crygen::Types::Enum.new("Person", "Int8")
      .add_constant("Employee", "1")
      .add_constant("Student", "2")
      .add_constant("Intern", "3")

    expected = <<-CRYSTAL
    enum Person : Int8
      Employee = 1
      Student = 2
      Intern = 3
    end
    CRYSTAL

    assert_is_expected(enum_type, expected)
  end

  it "creates an enum with `#as_flags` annotation helper" do
    enum_type = Crygen::Types::Enum.new("Person").flags
      .add_constant("Employee")
      .add_constant("Student")
      .add_constant("Intern")

    expected = <<-CRYSTAL
    @[Flags]
    enum Person
      Employee
      Student
      Intern
    end
    CRYSTAL

    assert_is_expected(enum_type, expected)
  end

  it "creates an enum with `#as_flags` annotation helper and the comment" do
    enum_type = Crygen::Types::Enum.new("Person").flags
      .add_constant("Employee")
      .add_constant("Student")
      .add_constant("Intern")
      .add_comment("This is my Person enum.")

    expected = <<-CRYSTAL
    # This is my Person enum.
    @[Flags]
    enum Person
      Employee
      Student
      Intern
    end
    CRYSTAL

    assert_is_expected(enum_type, expected)
  end

  it "creates an enum with a comment for each method" do
    method_is_student = Crygen::Types::Method.new("student?", "Bool")
      .add_body("self == Person::Student")
      .add_comment("Comment")

    method_is_employee = Crygen::Types::Method.new("employee?", "Bool")
      .add_body("self == Person::Employee")
      .add_comment("Comment")

    method_is_intern = Crygen::Types::Method.new("intern?", "Bool")
      .add_body("self == Person::Intern")
      .add_comment("Comment")

    enum_type = Crygen::Types::Enum.new("Person")
      .add_constant("Employee")
      .add_constant("Student")
      .add_constant("Intern")
      .add_methods(method_is_student, method_is_employee, method_is_intern)
      .add_comment("Comment")

    expected = <<-CRYSTAL
    # Comment
    enum Person
      Employee
      Student
      Intern

      # Comment
      def student? : Bool
        self == Person::Student
      end

      # Comment
      def employee? : Bool
        self == Person::Employee
      end

      # Comment
      def intern? : Bool
        self == Person::Intern
      end
    end
    CRYSTAL

    assert_is_expected(enum_type, expected)
  end
end
