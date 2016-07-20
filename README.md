# State Model Framework

### Features:
- [x] design models in Xcode data modeler
- [x] automatic code generation
- [x] `struct`, `enum`, and `protocol`  models
- [x] store models as plists or json
- [x] versioning, and migration

### Topics:
- [Getting Started] (GetStarted.md)
- [Enums](Enums.md)
- [Protocols](Protocols.md)
- [Model Designer Reference](Reference.md)
- [Setup code generation](Setup.md)
- [Version and Migration](Versioning.md)


# Designing Models in the Xcode model design tool
Add a new data model file to the project, but do not link it to any targets. In the modeler elements correspond to the model as follows:

|    Data Model Type    |          Swift Model Type          |
|-------------------|----------------------------------|
| Entity              | struct \| enum                      |
| Entity.Attribute    | property \| enum: case |
| Entity.Relationship | model property \| enum associated value <ul> <li>if source is enum: target is associated value </li><li>if target is enum: enum property</li><li>if one-to-many, property is collection.</li></ul>|


## Modeler Settings
The following tables show the keys and values you can enter into the user-info section of the data modeler inspector window to use the options described.
## Entity Settings
| Key                              | Description                | Values            |
| -------------------------------- | -------------------------- | :----------------:|
| `State.Enum` | Specify entity is an enum. All attributes are considered cases of the enum. Specify raw value type with `State.Type` . *required for enums. | `YES`, `NO` |
| `State.Protocol` | Specify entity is a protocol. (**note:** you can also check the abstract checkbox) | `YES`, `NO` |
| `State.Type`       | When used on `Enum` entities, declares the enum as a raw value enum, and specifies it's raw value type. When used on `Protocol` entities specifies protocol inheritance.  |**For Enums:** The exact type for `Enum` **-or**  **For Protocols:** comma seperated list of protocols to inherit  |
| `State.Model`       | Used for raw value enums, and specifies it's raw value type as a model type.  |`Model`, `ModelArray`, `ModelDictionary`  |
| `State.Transformable`       | Used for raw value enums, and specifies it's raw value type as transformable.  |The exact name of the transform type to use. |

## Attribute Settings

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
| `State.Transformable`       | Used on relationships, Specify a relationship to a model item uses a transform  |The exact name of the transform type to use. |


## Optionals:
Select the optional check box for an attribute in the data modeler inspector window and the property will be implemented as an optional type.

## Default Values:
You can specify a default value in the inspector window, or use `State.Value` in the user info section to give a property a default value. **Note:** because of swift 1.2 bugs, default values are not fully supported. Current limitations are:
1. Not supported for optional types
2. Some type inference problems can occur but will be caught at compile time if so.

## Transients (experimental)
There is preliminary support for transient properties. Mark the attribute as transient in the inspector. Transients MUST be optional OR have a default value.

## Enums
You can design the following types of enums in the Xcode data modeler:
* enums
* raw value enums
* enums with cases that have associated values

To create an enum in the modeler:

1. Add the key `State.Enum` and the value `YES` to an entity in the user info area of the inspector to specify an entity as an enum.
 
2. Add attributes to create cases for the enum. The name of the attribute becomes the name of the case.

### Associated values for enum cases:
Enum cases can have an associated type. To specify the associated value type of an enum case:

* Add the key `State.Type` to the user info section of the inspector for the attribute and specify the 
type in the value field.

*-or-*

*  Create a relationship to another model entity to specify the destination entity type as the associated value type.

### Raw value enums:
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

## Protocols 
You can create protocols in the data model designer.
You  create protocols by specifying the `State.Protocol` key or checking the abstract checkbox in the inspector for the entity to be a protocol. 

### Function requirements
You can specify function requirements on protocols using the `State.ProtocolRequirementType` and the `State.Func` key on the protocol entities attributes. 
**Note:** an empty implementation is added to the **manual** file only the first time it is generated. If you already generated code before adding this requirement
you may have to manually add it to the manual file.

On the protocol requiment attribute:
- Set State.ProtocolRequirementType to Func
- Set State.Func to the exact function signature of the requirement

### Read only variable requirements
You can specify a variable requirement as get only using the `State.ProtocolRequirementType` with a value of `get` on protocol attributes and relationships.
**Note:** an empty implementation is added to the **manual** file only the first time it is generated. If you already generated code before adding this requirement
you may have to manually add it to the manual file.

### Protocol inheritance  
There are two ways you can specify a protocol inherits from other protocols. 

1. Set one protocol entity as the parent of another protocol entity
2. Use the `State.Type` key on a protocol entity to specify additional protocols. These are entered as a comma separated list. For example if you want your protocol
to also inherit from `CustomStringConvertible` and `CustomDebugStringConvertible` you would enter `CustomStringConvertible, CustomStringConvertible` as the value for 
`State.Type` on the protocol entity.

**Note:** you can use these two methods in combination if needed

### Protocol Conformance
To specify a model item has conformance to a protocol, set the protocol as the parent entity of a model item. 

**Note:** Only structs can conform at this time. You do not need to re-specify the protocols requirements in your conforming entity, they will be inherited and implemented automatically.

### Using protocols

You can use protocols as types just like struct and enum types. A protocol extension is started for you in the manual file so you can extend your protocol if needed.

You can compose with protocols. For example, one model item can have a one to many composition to a protocol type. This allows you to add any conforming type into the composition collection of the containing model type. 

#### Example or using protocols:
The following shows a valid model design for an AssetLibrary. AssetGroup has assets which is a one-to-many relationship to the `Asset protocol type`. `FileAsset` is protocol that inherits from `Asset`. ColorAsset, ImageAsset, and SoundAsset are all conforming model types.

You can add any of the conforming types to the assets of `AssetGroup`. When AssetGroup is serialized and de-serialized, each type contained in the assets composition will be restored.

![<Protocol Example>](Resources/protocol_1.png)

Notes:
* Protocol requirements can include other model items
* Model items can have relationships to protocol types.

## Data Modeler Notes / Gotchas:

- You must enter a class name for entities or no code will be generated 
- Int16, Int32 or Int64 are all implemented as Int.
- If you enter a custom type using `State.Type` key, it will override the type in the attribute type option list.
- Do not link the .xcdatamodel file to your target.
- Recursive type references are not supported  with swift structs without boxing, therefore be sure not to generate circular dependancies in the modeler.
- Even if you specify a type with `State.Type` you have to still choose a type in the type section box. (it will be ignored) If you don't, the project will not build.

# Generating Code
You must have mogenerator installed and it must be the version specified 
in the system requirements section. (newer versions of mogenerator are not supported).

Type the following in to terminal to generate the model code files.

```
mogenerator --model <$path to the .xcdatamodeld file> --swift --template-path <$path to the state templates directory> <$path to the output directory>
```

## About the model code files

Two files for each entity in the model design are generated when you run Mogenerator.
- _Model.swift
- Model.swift  

The file with the underscore prefix is the automatic file, and the other is the manual file. The automatic file is updated every time you regenerate the code after modifying the model design file. The manual file is only generated once the first time you generate code. Therefore the manual file is not overwritten and is safe for you to use for extending the models via. a swift extension.

The manual file serves the following purposes:

- extend the model code via a swift extension in this file
- hook in to the encoding and decoding process, so you can read and write additional data during decoding and encoding if needed.
- manage the versioning and migration of the models if and when needed.

# Adding the code files and State framework to your project.

## Using Carthage

[Carthage]: https://github.com/Carthage/Carthage

Add the following to your project's Cartfile:

```
github "STLabs/State" ~> 0.1
```

Then run `carthage update`.

Follow the current instructions in [Carthage's README][carthage-installation]
for up to date installation instructions.

## As a Submodule
1. Add State as a submodule by going to your project directory and enter the following:
	`git submodule add https://github.com/STLabs/State.git`
2. Open the State folder and drag and drop the State.xcodeproj into the file navigator of your workspace.

3. In Xcode, select the project icon to open the target window and select your host target that will use State.

4. Select the "Build Phases" tab in the target configuration window.

5. Add State as a target dependency to the host target

6. Click on the + button at the top left and select "New Copy Files Phase". Rename this new phase to "Copy Frameworks", set the "Destination" to "Frameworks", and add State.framework.

[carthage-installation]: https://github.com/Carthage/Carthage#adding-frameworks-to-an-application

## Adding the code files
Drag the model code files in to your project to add them.

## Automatic code generation setup.
To set up to automatically generate code every time you build the project:

If you do not have State framework, or mogenerator installed do that first. 
 
1. In your Xcode project, select `file > new > target`, and under OS X select other. Choose "External Build System" and click next.

2. give your target a name such as "GenerateModels" and hit finish.

3. select your project in the project navigator and select the new target you just added

4. under the info tab for the target set up the "External Build Tool Configuration" as follows:

	#####Build Tool: `/usr/local/bin/mogenerator`  
	(or where ever mogenerator is installed. (type `which mogenerator` in terminal to 	find the location)
	

	#####Arguments:
	--model `<path to your .xcdatamodeld file>` --swift --template-path `<path to states template folder>` --output-dir `<path to save model code files>`

	#####example: 
If state is installed in a subdirectory of your project, and you had a models folder for your models, it would look something like this: --model $(SRCROOT)/ProjectName/Models/Model.xcdatamodeld --swift --template-path $(SRCROOT)/../State/Templates --output-dir $(SRCROOT)/ProjectName/Models/

5. Select the target that you want to use the model entities in, and select `Build Phases` and twist open the `Target Dependencies` section at the top. 

6. Click the plus to add a dependency and select the GenerateModels target you just created earlier. 
	This will tell Xcode to build your GenerateModels target before building the host target.
	
7. The first time you generate the code files you will have to manually add them to the project.

You should now be able to add entities to the data modeler, and the code files should generate each time you build. If not, check the issue or report navigator to investigate the cause.



# Reading and Writing Models to JSON/Plist files, `Strings`, or `Data`.

`Models`, and collections of them can be
  written and read to files, `Strings`, or `Data`. 

```swift
// save person to JSON
person.write(to: fileURL, format: .JSON)

// make a string
var jsonPerson = person.makeString(format: .JSON))

// make data
var dataPerson = person.makeData(format: .Plist)

// load person from JSON
let person = Person(file: fileURL, format: .JSON)

// create person from json string
let person = Person(content: jsonPerson)

// create person from plist data
let person = Person(content: dataPerson)

```

# Versioning and Migration 
Versioning and migration is opt-in. By default models do not version or migrate. 

To support versioning and migration implement the following methods in your model extension:

  * `static func writeVersion(with: Store)`

     This method is called before writing a model is finished to give the model an
     opertunity to write version information to the output.

  * `static func migrate(from: Store) -> Store`

     This method is called before reading a model to give the model 
     an opertunity to migrate the store. In this method:

    -  read the version information from the store
    -  compare the version information with the "current version"
    -  add, remove, and update keys, and values to the store 
    -  return the updated store

# System Requirements

- Swift 3.0
- Xcode 8.0
- iOS 8.0
- Mogenerator 1.28

# License

State is released under the MIT license. See
[LICENSE.md](https://github.com/STLabs/State/blob/master/LICENSE).
