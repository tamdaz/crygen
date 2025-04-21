require "./crygen"

begin
  command_name = ARGV[0]
  if command_name
    case command_name
    when "make:module"
      ARGV[1] ? make_module(ARGV[1]) : puts "Class name is required. Please retry."
    when "make:type"
      ARGV[1] ? make_type(ARGV[1]) : puts "Class name is required. Please retry."
    else
      puts "Command not found. Please retry."
      exit 1
    end
  end
rescue IndexError
  puts "No command specified. Please retry."
  exit 1
end

def make_module(module_name : String) : Nil
  module_type = CGT::Module.new("Crygen::Types::#{module_name}")
  module_type.add_comment("TODO : Write the documentation about the `#{module_name}` class.")

  path = __FILE__.gsub("console.cr", nil) + "modules/#{module_name.downcase.gsub(' ', '_')}.cr"

  File.write(path, module_type.generate)
end

def make_type(class_name : String) : Nil
  method_generate = CGT::Method.new("generate", "String")
  method_generate.add_body("# Put the code...")
  class_type = CGT::Class.new("Crygen::Types::#{class_name} < Crygen::Interfaces::GeneratorInterface")
  class_type.add_comment("TODO : Write the documentation about the `#{class_name}` class.")
  class_type.add_method(method_generate)

  path = __FILE__.gsub("console.cr", nil) + "types/#{class_name.downcase.gsub(' ', '_')}.cr"

  File.write(path, class_type.generate)
end
