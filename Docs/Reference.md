#Data Model Design Reference
## Entity Key-Value Reference
**Note:** You enter the keys and values below into the user-info section of the data modeler inspector window when you want to use the options.

| Key                              | Description                | Values            |
| -------------------------------- | -------------------------- | :----------------:|
| `State.Enum` | Specify entity is an enum. All attributes are considered cases of the enum. Specify raw value type with `State.Type` . *required for enums. | `YES`, `NO` |
| `State.Protocol` | Specify entity is a protocol. (**note:** you can also check the abstract checkbox) | `YES`, `NO` |
| `State.GenerateStub` | Specify a protocol stub should be generated. (see protocol docs for more info) | `YES`, `NO` |
| `State.Type`       | Raw value type for  enum. *required for enums.|The exact type  |

## Attribute Key-Value Reference
**Note:** You enter the keys and values below into the user-info section of the data modeler inspector window when you want to use the options.

| Key                              | Description                | Values            |
| -------------------------------- | -------------------------- | :----------------:|
| `State.Immutable`    | Specify an attribute is immutable (code will use `let` instead of `var` for the property) | `YES`, `NO` |
| `State.Type`       | Specify a type for the attribute. For example, `[String : Int]` would specify to use a Dictionary of String, Ints for this property **-or-** Specifies the associated value type for enum cases.| The exact type  |
| `State.Value`	| Specify a default value for a property. (only supported for non-optional properties) **-or-** The raw value of an enum case. | The exact value
| `State.Import`	| Import a module in source for attribute type  | The exact module name 
| `State.CompositionType`       | Type of collection to use for one to many compositions.|Dictionary, Array  |


## Compose models with relationships between model items
Model one-to-one, and one-to-many single direction relationships to compose models and enums together.

## Enums
See the [Enum Design Guide](Enums.md)

## Protocols 
[Protocol Design Guide](Protocols.md)

## Transients (experimental)
There is preliminary support for transient properties. Mark the attribute as transient in the inspector. Transients MUST be optional OR have a default value.

## Transformables:
Set the attribute type as transformable in the data modeler attribute type selector in the inspector window and enter a value transformer name in the name field. The value transformer name entered must be of a type that implements the [ValueTransform] (https://github.com/amberstar/State/blob/master/State/Transforms/ValueTransform.swift) protocol. Your model will automatically use the transform type to transform the attribute when encoding and decoding the element. Add a State.Type to indicate the non-transformed type. For example: for an URLTransform, enter State.Type and NSURL to indicate the type.

## Optionals:
Select the optional check box for an attribute in the data modeler inspector window and the property will be implemented as an optional type.

## Default Values:
You can specify a default value in the inspector window, or use `State.Value` in the user info section to give a property a default value. **Note:** because of swift 1.2 bugs, default values are not fully supported. Current limitations are:
1. Not supported for optional types
2. Some type inference problems can occur but will be caught at compile time if so.


## Versioning:
You can add a versionHashModifier to each entity in your model design. This value along with the versionHash are imported in to the code generated and used in the migration scheme of state. For more information see [Versioning and Migration](https://github.com/STLabs/State#versioning-and-migration)

## Data Modeler Notes:

- You must enter a class name for entities or no code will be generated 
- Int16, Int32 or Int64 are all implemented as Int.
- If you enter a custom type using `State.Type` key, it will override the type in the attribute type option list.
- No need to link the .xcdatamodel file to your target.
- Recursive type references are not supported  with swift structs without boxing, therefore be sure not to generate circular dependancies in the modeler.
