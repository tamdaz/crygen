# Changelog

## [v0.5.1](https://github.com/tamdaz/cruml/releases/tag/v0.5.1) - 2025-04-22

## Fixed

* Rename interface to `Crygen::Interfaces::GeneratorInterface` (@tamdaz)(#31)
* Refactor the code (@tamdaz)(#32)

## [v0.5.0](https://github.com/tamdaz/cruml/releases/tag/v0.5.0) - 2025-04-21

## Added

* Add tests for mixins and possible to use mixins in structs. (@tamdaz)(#29)
* Add `sync` command. (@tamdaz)(#30)

## Changed

* Update README (@tamdaz)(#28)

## Fixed

* `Crygen::Types::Enum` implments Crygen::Abstract::GeneratorInterface (@tamdaz)(#27)

## [v0.4.0](https://github.com/tamdaz/cruml/releases/tag/v0.4.0) - 2025-03-12

## Added

* Add aliases, mixins, simplify `add_property`, fix bugs. (@nobodywasishere)(#19)
* Add `pull` cmd and `cruml` dependency. Ignore `/out` directory. (@tamdaz)(#21)
* Add docs and example for alias. (@tamdaz)(#24)
* Setup helpers for annotations. (@tamdaz)(#25)
* Test helpers for annotations. (@tamdaz)(#26)

## Changed

* Improve alias spec. (@tamdaz)(#22)

## Removed

* Delete redudant params and returns. (@tamdaz)(#20)
* Delete the `build` step. (@tamdaz)(#23)

## [v0.3.1](https://github.com/tamdaz/cruml/releases/tag/v0.3.1) - 2025-02-15

## Fixed

- Update the config by (@tamdaz)(#16)
- Add the `Crygen::Modules::Annotation` module. by (@tamdaz)(#17)
- Format the hashes by (@tamdaz)(#18)

## [v0.3.0](https://github.com/tamdaz/cruml/releases/tag/v0.3.0) - 2025-02-15

## Added
- Add nullable properties by (@tamdaz)(#15)

## Changed
- Rename file name for the `Crygen::Abstract::GeneratorInterface` interface (@tamdaz)(#2).
- Update documentation by (@tamdaz)(#13)
- Improve the README by (@tamdaz)(#14)

## [v0.2.0](https://github.com/tamdaz/cruml/releases/tag/v0.2.0) - 2025-02-04

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

## [v0.1.0](https://github.com/tamdaz/cruml/releases/tag/v0.1.0) - 2025-01-24

This is an initial release 🧭