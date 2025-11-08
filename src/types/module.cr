require "./../types/*"
require "./../modules/*"
require "./../interfaces/generator_interface"

# A class thar generates a module.
# A module can include any objects, like classes, structs, enums and modules itselves.
#
# ```
# enum_type = Crygen::Types::Enum.new("Role", "Int8")
# enum_type.add_constant("Member", "1")
# enum_type.add_constant("Moderator", "2")
# enum_type.add_constant("Administrator", "3")
# module_type = Crygen::Types::Module.new("Folder::Sub::Folder")
# module_type.add_object(enum_type)
# ```
#
# Output:
# ```
# module Folder::Sub::Folder
#   enum Role : Int8
#     Member        = 1
#     Moderator     = 2
#     Administrator = 3
#   end
# end
# ```
class Crygen::Types::Module < Crygen::Interfaces::GeneratorInterface
  include Crygen::Modules::Comment

  @objects = [] of Crygen::Interfaces::GeneratorInterface

  def initialize(@name : String); end

  # Adds an object into the module.
  # ```
  # enum_type = Crygen::Types::Enum.new("Role", "Int8")
  # enum_type.add_constant("Member", "1")
  # enum_type.add_constant("Moderator", "2")
  # enum_type.add_constant("Administrator", "3")
  # module_type = Crygen::Types::Module.new("Folder::Sub::Folder")
  # module_type.add_object(enum_type)
  # ```
  # Output:
  # ```
  # module Folder::Sub::Folder
  #   enum Role : Int8
  #     Member        = 1
  #     Moderator     = 2
  #     Administrator = 3
  #   end
  # end
  # ```
  def add_object(object_type : Crygen::Interfaces::GeneratorInterface) : self
    @objects << object_type
    self
  end

  # Adds objects into the module.
  # ```
  # enum_type = Crygen::Types::Enum.new("Role", "Int8")
  # enum_type.add_constant("Member", "1")
  # enum_type.add_constant("Moderator", "2")
  # enum_type.add_constant("Administrator", "3")
  # module_type = Crygen::Types::Module.new("Folder::Sub::Folder")
  # module_type.add_object(enum_type)
  # ```
  # Output:
  # ```
  # module Folder::Sub::Folder
  #   enum Role : Int8
  #     Member        = 1
  #     Moderator     = 2
  #     Administrator = 3
  #   end
  #
  #   enum Role : Int8
  #     Member        = 1
  #     Moderator     = 2
  #     Administrator = 3
  #   end
  # end
  # ```
  def add_objects(*object_type : Crygen::Interfaces::GeneratorInterface) : self
    @objects += object_type.to_a
    self
  end

  # Generates a module.
  def generate : String
    String.build do |str|
      str << CGG::Comment.generate(@comments)

      str << Crygen::Utils::Indentation.generate
      str << "module "
      str << @name << "\n"

      can_add_whitespace = false

      Crygen::Utils::Indentation.add_indent

      # All classes from `Crygen::Types` module have the `generate` method.
      @objects.each do |object|
        str << "\n" if can_add_whitespace == true

        object.generate.each_line do |line|
          str << line << "\n"
        end

        if can_add_whitespace == false
          can_add_whitespace = true
        end
      end

      Crygen::Utils::Indentation.remove_indent

      str << Crygen::Utils::Indentation.generate
      str << "end"
    end
  end

  # :ditto:
  def to_s(io : IO) : Nil
    io << self.generate
  end
end
