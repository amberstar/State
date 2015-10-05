#Data Model Design Reference
## Entity Key-Value Reference
**Note:** You enter the keys and values below into the user-info section of the data modeler inspector window when you want to use the options.

| Key                              | Description                | Values            |
| -------------------------------- | -------------------------- | :----------------:|
| `State.Enum` | Specify entity is an enum. All attributes are considered cases of the enum. Specify raw value type with `State.Type` . *required for enums. | `YES`, `NO` |
| `State.Protocol` | Specify entity is a protocol. (**note:** you can also check the abstract checkbox) | `YES`, `NO` |
| `State.Type`       | Used in combination with the enum option, declares the enum as a raw value enum, and specifies it's raw value type.  |The exact type  |
| `State.Model`       | Used for raw value enums, and specifies it's raw value type as a model type.  |`Model`, `ModelArray`, `ModelDictionary`  |
| `State.Transformable`       | Used for raw value enums, and specifies it's raw value type as transformable.  |The exact name of the transform type to use. |

## Attribute Key-Value Reference
**Note:** You enter the keys and values below into the user-info section of the data modeler inspector window when you want to use the options.

| Key                              | Description                | Values            |
| -------------------------------- | -------------------------- | :----------------:|
| `State.Immutable`    | Specify an attribute is immutable (code will use `let` instead of `var` for the property) | `YES`, `NO` |
| `State.Type`       | Specify a type for the attribute. For example, `[String : Int]` would specify to use a Dictionary of String, Ints for this property **-or-** Specifies the associated value type for enum cases.| The exact type  |
| `State.Func`       | Used on `State.Protocol` entities with a requirement type of `func` specifies the function signature for the requirement| The exact signature of the function requirement  |
| `State.Mutating`       | Used on `State.Protocol` entities with a requirement type of `func`  specifies the function is `mutating` | `YES`, `NO`  |
| `State.ProtocolRequirementType`       | Used on State.Protocol entities. Specifies attribute requirment type for the protocol. **note: if not specified `var` is assumed, use `get` to generate a get only variable requirement| `func`, `var`, `get`  |
| `State.Value`	| Specify a default value for a property. (only supported for non-optional properties) **-or-** The raw value of an enum case. | The exact value
| `State.Import`	| Useful when you need to import a module in the generated source for the particular attribute type  | The exact module name 
| `State.CompositionType`       | Used with one-to-many relationships. Type of collection to use for a one to many compositions.|Dictionary, Array  |


## Compose models with relationships between model items
Model one-to-one, and one-to-many single direction relationships to compose models and enums together.

## Enums
See the [Enum Design Guide](Enums.md)

## Protocols 
[Protocol Design Guide](Protocols.md)

## Transients (experimental)
There is preliminary support for transient properties. Mark the attribute as transient in the inspector. Transients MUST be optional OR have a default value.

## Transforms:
Set the attribute type as transformable in the data modeler attribute type selector in the inspector window and enter a value transformer name in the name field. The value transformer name entered must be of a type that implements the [ValueTransform] (https://github.com/amberstar/State/blob/master/State/Transforms/ValueTransform.swift) protocol. Your model will automatically use the transform type to transform the attribute when encoding and decoding the element. Add a State.Type to indicate the non-transformed type. For example: for an URLTransform, enter State.Type and NSURL to indicate the type.

To learn more about Transforms see [Transforms](Transformables.md)

## Optionals:
Select the optional check box for an attribute in the data modeler inspector window and the property will be implemented as an optional type.

## Default Values:
You can specify a default value in the inspector window, or use `State.Value` in the user info section to give a property a default value. **Note:** because of swift 1.2 bugs, default values are not fully supported. Current limitations are:
1. Not supported for optional types
2. Some type inference problems can occur but will be caught at compile time if so.


## Versioning:
You can add a versionHashModifier to each entity in your model design. This value along with the versionHash are imported in to the code generated and used in the migration scheme of state. For more information see [Versioning and Migration](vVersioning.md)

## Data Modeler Notes / Gotchas:

- You must enter a class name for entities or no code will be generated 
- Int16, Int32 or Int64 are all implemented as Int.
- If you enter a custom type using `State.Type` key, it will override the type in the attribute type option list.
- Do not link the .xcdatamodel file to your target.
- Recursive type references are not supported  with swift structs without boxing, therefore be sure not to generate circular dependancies in the modeler.
- Even if you specify a type with `State.Type` you have to still choose a type in the type selction box. (it will be ignored) If you don't, the projest will not build.
