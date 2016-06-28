#Enum Design Guide
You can design the following types of enums in the Xcode data modeler:
* enums
* raw value enums
* enums with cases that have associated values


## Enums:
To create an enum in the modeler:

1. Add the key `State.Enum` and the value `YES` to an entity in the user info area of the inspector to specify an entity as an enum.
 
2. Add attributes to create cases for the enum. The name of the attribute becomes the name of the case.



## Associated values for enum cases:
Enum cases can have an associated type. To specify the associated value type of an enum case:

* Add the key `State.Type` to the user info section of the inspector for the attribute and specify the 
type in the value field.

*-or-*

*  Create a relationship to another model entity to specify the destination entity type as the associated value type.

#### Transformable values
If a value type you are specifying is a transformable value type:

1. Specify the type with the `State.Type` key in the user info area of the inspector

2. select Transformable in the Attribute Type selection in the inspector

3. enter a value transformer name in the inspector. The value transformer name entered must be of a type that implements the ValueTransform protocol. Your model will automatically use the transform type to transform the associated vale when encoding and decoding the enum.

## Raw value enums:
Raw value enums are enums that have a type, and each case has a value called the raw value. To create raw value enums in the modeler:

1. Specify an entity as an enum as described in the enum section

2. Add the `State.Type` key  to **Entity** in the user-info part of the inspector 

3. Specify a type in the value field of the `State.Type`. 

4. Add attributes to create cases for the enum. The name of the attribute becomes the name of the case. 

5. Add the `State.Value` key and a value to each **Attribute** in  the user info inspector to specify the raw value of each enum case.

Notes:
* Raw values enum types can be any type including other model entities
* Optionals and transforms are not supported for raw value types
* Raw value enums cannot have associated value types in the cases
