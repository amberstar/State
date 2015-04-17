#Spot
swift struct models

- Design  model entities using Xcode's data model designer
- Use swift structs and enums for  model entities
- Serialize to and from plists, or JSON
- Use optional, non-optional, and immutable types
- Automatically generate model code with mogenerator tool. 





### Entity Key-Value Reference
| Key                              | Description                | Values            |
| -------------------------------- | -------------------------- | :----------------:|
| `Spot.Enum`    | Entity is an enum. All attributes are considered cases. Specify raw value type with `STModel.Type` . | `YES`, `NO` |
| `Spot.Type`       | Raw value type for  enum. | The exact name of the type to use as the raw value type for the enum entity.  |

### Attribute Key-Value Reference
| Key                              | Description                | Values            |
| -------------------------------- | -------------------------- | :----------------:|
| `Spot.Immutable`    | Attribute is immutable (use `let` instead of `var`) | `YES`, `NO` |
| `Spot.Type`       | The type of the attribute. useful for transformable. (if this key is present it overrides the option selected in the data model inspector)| The exact name of the type to use for entity.  |
| `Spot.Value`	| The raw value of the enum case. used when entity is an enum. each attribute is considered a case of the enum. the value specified is the raw value of the current case. | The exact value of the case. (strings must be in quotes)


