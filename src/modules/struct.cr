module Crygen::Modules::Struct
  protected getter structs = [] of Crygen::Types::Struct

  # Adds the nested struct(s).
  def add_struct(*structs : Crygen::Types::Struct) : self
    @structs += structs.to_a
    self
  end
end
