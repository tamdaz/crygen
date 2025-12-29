@[Flags]
# Enum that identifies the property visibility like `getter`, `getter?` `property`, `property?`,
# `setter` `class_getter`, `class_getter?`, `class_property`, `class_property?` and `class_setter`
enum Crygen::Enums::PropVisibility
  Getter
  NilGetter
  Property
  NilProperty
  Setter
  ClassGetter
  NilClassGetter
  ClassProperty
  NilClassProperty
  ClassSetter
end
