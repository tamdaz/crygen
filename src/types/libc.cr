require "./../modules/annotation"
require "./../interfaces/generator_interface"

# A class that generates a C library.
# ```
# libc_type = Crygen::Types::LibC.new("C")
# libc_type.add_function("getch", "Int32")
# libc_type.generate
# ```
#
# Output:
# ```
# lib C
#   fun getch : Int32
# end
# ```
class Crygen::Types::LibC < Crygen::Interfaces::GeneratorInterface
  include Crygen::Modules::Annotation

  alias FieldArray = Array(Tuple(String, String))

  @functions = [] of Hash(Symbol, String)
  @objects = [] of Tuple(String, Symbol, FieldArray)

  def initialize(@name : String); end

  # Adds a C function (name, return type, and optional arguments).
  # ```
  # libc_type = Crygen::Types::LibC.new("C")
  # libc_type.add_function("getch", "Int32", [{"arg1", "Int32"}, {"arg2", "Int32"}])
  # ```
  #
  # Output:
  # ```
  # lib C
  #   fun getch(arg1 : Int32, arg2 : Int32) : Int32
  # end
  # ```
  def add_function(name : String, return_type : String, args : FieldArray? = nil) : self
    @functions << {
      :name        => name,
      :args        => !args.nil? ? generate_args(args) : "",
      :return_type => return_type,
    }
    self
  end

  # Adds a struct.
  # ```
  # libc_type = Crygen::Types::LibC.new("C")
  # libc_type.add_struct("Person", [{"name", "String"}, {"age", "Int32"}])
  # ```
  #
  # Output:
  # ```
  # lib C
  #   struct Person
  #     name : String
  #     age : Int32
  #   end
  # end
  # ```
  def add_struct(name : String, fields : FieldArray) : self
    @objects << {name, :struct, fields}
    self
  end

  # Adds an union.
  # ```
  # libc_type = Crygen::Types::LibC.new("C")
  # libc_type.add_union("Person", [{"name", "String"}, {"age", "Int32"}])
  # ```
  #
  # Output:
  # ```
  # lib C
  #   union Person
  #     name : String
  #     age : Int32
  #   end
  # end
  # ```
  def add_union(name : String, fields : FieldArray) : self
    @objects << {name, :union, fields}
    self
  end

  # Generates a C lib.
  def generate : String
    String.build do |str|
      str << CGG::Annotation.generate(@annotations)
      str << Crygen::Utils::Indentation.generate
      str << "lib " << @name << "\n"

      Crygen::Utils::Indentation.add_indent

      @objects.each_with_index do |object, index|
        if index != 0
          str << "\n"
        end

        str << Crygen::Utils::Indentation.generate
        str << object[1] << ' ' << object[0] << "\n"

        Crygen::Utils::Indentation.add_indent

        object[2].each do |field|
          str << Crygen::Utils::Indentation.generate
          str << field[0] << " : " << field[1] << "\n"
        end

        Crygen::Utils::Indentation.remove_indent

        str << Crygen::Utils::Indentation.generate
        str << "end\n"
      end

      # Add a blank line between the objects and functions.
      if !@objects.empty? && !@functions.empty?
        str << "\n"
      end

      @functions.each do |function|
        str << Crygen::Utils::Indentation.generate
        str << "fun " << function[:name]
        str << function[:args] unless function[:args].empty?
        str << " : " << function[:return_type] << "\n"
      end

      Crygen::Utils::Indentation.remove_indent

      str << Crygen::Utils::Indentation.generate
      str << "end"
    end
  end

  # Generate the args.
  private def generate_args(args : Array(Tuple(String, String))) : String
    String.build do |str|
      str << '('

      args.each_with_index do |arg, index|
        str << arg[0] << " : " << arg[1]

        if index != args.size - 1
          str << ", "
        end
      end

      str << ')'
    end
  end

  # :ditto:
  def to_s(io : IO) : Nil
    io << self.generate
  end
end
