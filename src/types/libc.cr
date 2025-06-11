require "./../modules/annotation"
require "./../interfaces/generator_interface"

# A class that generates a C library.
# ```
# libc_type = Crygen::Types::LibC.new("C")
# libc_type.add_function("getch", "Int32")
# libc_type.generate
# ```
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
  # Output:
  # ```
  # lib C
  #   fun getch(arg1 : Int32, arg2 : Int32) : Int32
  # end
  # ```
  def add_function(name : String, return_type : String, args : Array(Tuple(String, String)) | Nil = nil) : self
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
      @annotations.each { |annotation_type| str << annotation_type.generate + "\n" }

      str << "lib " << @name << "\n"

      can_add_whitespace = false
      @objects.each do |object|
        str << "\n" if can_add_whitespace == true
        str << "  " << object[1] << ' ' << object[0] << "\n"

        object[2].each do |field|
          str << "    #{field[0]} : #{field[1]}\n"
        end

        str << "  end\n"
        can_add_whitespace = true
      end
      str << "\n" if !@objects.empty? && !@functions.empty?
      @functions.each do |function|
        if function[:args].empty?
          str << "  fun " << function[:name]
        else
          str << "  fun " << function[:name] << function[:args]
        end

        str << " : " << function[:return_type] << "\n"
      end
      str << "end"
    end
  end

  # Generate the args.
  private def generate_args(args : Array(Tuple(String, String))) : String
    String.build do |str|
      str << '('
      args.each_with_index do |arg, i|
        str << "#{arg[0]} : #{arg[1]}"
        str << ", " if i != args.size - 1
      end
      str << ')'
    end
  end
end
