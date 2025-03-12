require "./spec_helper"

describe Crygen::Types::Enum do
  it "creates an enum" do
    enum_type = Crygen::Types::Enum.new("Person")
    enum_type.add_constant("Employee")
    enum_type.add_constant("Student")
    enum_type.add_constant("Intern")

    enum_type.generate.should eq(<<-CRYSTAL)
    enum Person
      Employee
      Student
      Intern
    end
    CRYSTAL
  end

  it "creates an enum with one method" do
    method_is_student = Crygen::Types::Method.new("student?", "Bool")
    method_is_student.add_body("self == Person::Student")

    enum_type = Crygen::Types::Enum.new("Person")
    enum_type.add_constant("Employee")
    enum_type.add_constant("Student")
    enum_type.add_constant("Intern")
    enum_type.add_method(method_is_student)

    enum_type.generate.should eq(<<-CRYSTAL)
    enum Person
      Employee
      Student
      Intern

      def student? : Bool
        self == Person::Student
      end
    end
    CRYSTAL
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
    enum_type.add_method(method_is_student)
    enum_type.add_method(method_is_employee)
    enum_type.add_method(method_is_intern)

    enum_type.generate.should eq(<<-CRYSTAL)
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
  end

  it "creates an enum with a type" do
    enum_type = Crygen::Types::Enum.new("Person", "Int8")
    enum_type.add_constant("Employee")
    enum_type.add_constant("Student")
    enum_type.add_constant("Intern")

    enum_type.generate.should eq(<<-CRYSTAL)
    enum Person : Int8
      Employee
      Student
      Intern
    end
    CRYSTAL
  end

  it "creates an enum with a type and default values" do
    enum_type = Crygen::Types::Enum.new("Person", "Int8")
    enum_type.add_constant("Employee", "1")
    enum_type.add_constant("Student", "2")
    enum_type.add_constant("Intern", "3")

    enum_type.generate.should eq(<<-CRYSTAL)
    enum Person : Int8
      Employee = 1
      Student = 2
      Intern = 3
    end
    CRYSTAL
  end

  it "creates an enum with `#as_flags` annotation helper" do
    enum_type = Crygen::Types::Enum.new("Person")
    enum_type.add_constant("Employee")
    enum_type.add_constant("Student")
    enum_type.add_constant("Intern")
    enum_type.as_flags

    enum_type.generate.should eq(<<-CRYSTAL)
    @[Flags]
    enum Person
      Employee
      Student
      Intern
    end
    CRYSTAL
  end
end
