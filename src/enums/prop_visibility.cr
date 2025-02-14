# Enum that identifies the property visibility such as `getter`, `property` and `setter`.
@[Flags]
enum Crygen::Enums::PropVisibility
  Getter
  NilGetter
  Property
  NilProperty
  Setter
end
