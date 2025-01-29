require "./../interfaces/generator"
require "./../types/*"

# A class that generates a C library.
# ```
# libc_type = Crygen::Types::LibC.new("C")
# libc_type.add_function("getch", "Int32")
# libc_type.generate
# ```
# Output :
# ```
# lib C
#   fun getch : Int32
# end
# ```
class Crygen::Types::LibC < Crygen::Abstract::GeneratorInterface
  alias FieldArray = Array(Tuple(String, String))

  @functions = [] of Hash(Symbol, String)
  @objects = [] of Tuple(String, Symbol, FieldArray)

  def initialize(@name : String); end

  # Adds a C function (name and return type).
  def add_function(name : String, return_type : String, args : Array(Tuple(String, String)) | Nil = nil) : Nil
    @functions << {
      :name        => name,
      :args        => !args.nil? ? generate_args(args) : "",
      :return_type => return_type,
    }
  end

  # Adds a struct.
  def add_struct(name : String, fields : FieldArray) : Nil
    @objects << {name, :struct, fields}
  end

  # Adds an union.
  def add_union(name : String, fields : FieldArray) : Nil
    @objects << {name, :union, fields}
  end

  # Generates a C lib.
  def generate : String
    String.build do |str|
      str << "lib #{@name}\n"
      can_add_whitespace = false
      @objects.each do |object|
        str << "\n" if can_add_whitespace == true
        str << "  #{object[1]} #{object[0]}\n"
        object[2].each do |field|
          str << "    #{field[0]} : #{field[1]}\n"
        end
        str << "  end\n"
        can_add_whitespace = true
      end
      str << "\n" if !@objects.empty? && !@functions.empty?
      @functions.each do |function|
        if function[:args].empty?
          str << "  fun #{function[:name]} : #{function[:return_type]}\n"
        else
          str << "  fun #{function[:name]}#{function[:args]} : #{function[:return_type]}\n"
        end
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
