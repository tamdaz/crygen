# Changelog

## [v0.3.1](https://github.com/tamdaz/cruml/releases/tag/v0.3.1) - 15-02-2025

## Fixed

- Update the config by (@tamdaz)(#16)
- Add the `Crygen::Modules::Annotation` module. by (@tamdaz)(#17)
- Format the hashes by (@tamdaz)(#18)

## [v0.3.0](https://github.com/tamdaz/cruml/releases/tag/v0.3.0) - 15-02-2025

## Added
- Add nullable properties by (@tamdaz)(#15)

## Changed
- Rename file name for the `Crygen::Abstract::GeneratorInterface` interface (@tamdaz)(#2).
- Update documentation by (@tamdaz)(#13)
- Improve the README by (@tamdaz)(#14)

## [v0.2.0](https://github.com/tamdaz/cruml/releases/tag/v0.2.0) - 04-02-2025

### Added

- Add methods to add C functions, enums, structs and unions (#2)(@tamdaz)
- Add methods to generate a macro (#3)(@tamdaz)
- Add enum for properties (#5)(@tamdaz)
- Change the return type for methods (#8)(@tamdaz)
- Add an optional argument to define the property scope (#10)(tamdaz)
- Add CGE alias ([3a24483](https://github.com/tamdaz/crygen/pull/5/commits/3a244834f3108aa16bfe7a063d5774cc9e6ff348))(@tamdaz)
- Add `Crygen::Enums::PropVisibility` enum ([f0614ee](https://github.com/tamdaz/crygen/pull/5/commits/f0614ee8f2212c8544b2468daf1065709f4d6d48))(@tamdaz)
- Add `Crygen::Enums::PropScope` enum ([79893b4](https://github.com/tamdaz/crygen/pull/10/commits/79893b4615ab1ddd8f088fa6ff4908d968b5ab90))(@tamdaz)
- Add `Crygen::Types::LibC` type ([9af8d2](https://github.com/tamdaz/crygen/pull/2/commits/9af8d20c8eaec2439698ac692d15bce450724122))(@tamdaz)
- Add `Crygen::Types::Macro` type ([c7014d](https://github.com/tamdaz/crygen/pull/3/commits/c7014dab6f81b2ae9712192db675c7abd1f1f835))(@tamdaz)
- Add `CGE` alias ([3a2448](https://github.com/tamdaz/crygen/pull/5/commits/3a244834f3108aa16bfe7a063d5774cc9e6ff348))(@tamdaz)

### Changed

- **Breaking**: Visibility arg is an enum instead of a symbol ([f0614ee](https://github.com/tamdaz/crygen/pull/5/commits/f0614ee8f2212c8544b2468daf1065709f4d6d48))(@tamdaz)
- Change the return type for methods ([312d34](https://github.com/tamdaz/crygen/pull/8/commits/312d34de9b9fce2ba3d4594d9a8eb381dda3d6c4))(@tamdaz)
- An `scope` optional argument is added to `Crygen::Modules::Property#add_property` overloaded methods. ([543eb6](https://github.com/tamdaz/crygen/pull/10/commits/543eb6b37111788e3ccca0c89ebc0cad28c09894))(@tamdaz)

## [v0.1.0](https://github.com/tamdaz/cruml/releases/tag/v0.1.0) - 24-01-2025

This is an initial release 🧭