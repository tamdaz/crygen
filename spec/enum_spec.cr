require "./spec_helper"

describe Crygen::Types::Enum do
  it "creates an enum" do
    enum_type = Crygen::Types::Enum.new("Person")
    enum_type.add_constant("Employee")
    enum_type.add_constant("Student")
    enum_type.add_constant("Intern")

    expected = <<-CRYSTAL
    enum Person
      Employee
      Student
      Intern
    end
    CRYSTAL

    enum_type.generate.should eq(expected)
    enum_type.to_s.should eq(expected)
  end

  it "creates an enum with one method" do
    method_is_student = Crygen::Types::Method.new("student?", "Bool")
    method_is_student.add_body("self == Person::Student")

    enum_type = Crygen::Types::Enum.new("Person")
    enum_type.add_constant("Employee")
    enum_type.add_constant("Student")
    enum_type.add_constant("Intern")
    enum_type.add_method(method_is_student)

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

    enum_type.generate.should eq(expected)
    enum_type.to_s.should eq(expected)
  end

  it "creates an enum with many methods" do
    method_is_student = Crygen::Types::Method.new("student?", "Bool")
    method_is_student.add_body("self == Person::Student")

    method_is_employee = Crygen::Types::Method.new("employee?", "Bool")
    method_is_employee.add_body("self == Person::Employee")

    method_is_intern = Crygen::Types::Method.new("intern?", "Bool")
    method_is_intern.add_body("self == Person::Intern")

    enum_type = Crygen::Types::Enum.new("Person")
    enum_type.add_constant("Employee")
    enum_type.add_constant("Student")
    enum_type.add_constant("Intern")
    enum_type.add_methods(method_is_student, method_is_employee, method_is_intern)

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

    enum_type.generate.should eq(expected)
    enum_type.to_s.should eq(expected)
  end

  it "creates an enum with a type" do
    enum_type = Crygen::Types::Enum.new("Person", "Int8")
    enum_type.add_constant("Employee")
    enum_type.add_constant("Student")
    enum_type.add_constant("Intern")

    expected = <<-CRYSTAL
    enum Person : Int8
      Employee
      Student
      Intern
    end
    CRYSTAL

    enum_type.generate.should eq(expected)
    enum_type.to_s.should eq(expected)
  end

  it "creates an enum with a type and default values" do
    enum_type = Crygen::Types::Enum.new("Person", "Int8")
    enum_type.add_constant("Employee", "1")
    enum_type.add_constant("Student", "2")
    enum_type.add_constant("Intern", "3")

    expected = <<-CRYSTAL
    enum Person : Int8
      Employee = 1
      Student = 2
      Intern = 3
    end
    CRYSTAL

    enum_type.generate.should eq(expected)
    enum_type.to_s.should eq(expected)
  end

  it "creates an enum with `#as_flags` annotation helper" do
    enum_type = Crygen::Types::Enum.new("Person")
    enum_type.add_constant("Employee")
    enum_type.add_constant("Student")
    enum_type.add_constant("Intern")
    enum_type.flags

    expected = <<-CRYSTAL
    @[Flags]
    enum Person
      Employee
      Student
      Intern
    end
    CRYSTAL

    enum_type.generate.should eq(expected)
    enum_type.to_s.should eq(expected)
  end
end
