# State Model Framework

- [Designing Models in the Xcode Data Modeler] (#Designing-Models-in-the-Xcode-data-modeler)
- [Struct Models](#Structs)
- [Enum Models](#Enums)
- [Protocol Models](#Protocols)
- [Generating code](#Generating-Code)
- [Reading and Writing Models](#Reading-and-Writing-Models)
- [Version and Migration](#Versioning-and-Migration )


**Requirements**
- Swift 3.0
- Xcode 8.0
- iOS 8.0
- Mogenerator 1.28

---

# Designing Models in the Xcode Data Modeler
Add a new data model file to the project, but do not link it to any targets. In the modeler elements correspond to the model as follows:

|    Data Model Type    |          Swift Generated Type          |
|-------------------|----------------------------------|
| Entity              | struct \| enum                      |
| Attribute    | property \| enum: case |
| Relationship | property \| enum associated value <br><ul> <li>if source == enum -> target == associated value </li><li>if target == enum -> enum property</li><li>if one-to-many -> property is collection</li></ul>|

The following tables show the keys and values you can enter into the user-info section of the data modeler inspector window to use the options described. You only need to add these settings when you require them to be other than the default.


### Entity Settings
| Key                              | Description                | Values            |
| -------------------------------- | -------------------------- | :----------------:|
| `State.Enum` | set entity is enum | `YES`, **`NO`** |
| `State.Protocol` | set entity is protocol  | `YES`, **`NO`** |
| `State.Type`       | enum: set enum is raw value enum, and raw value type. <br> protocol: set protocol inheritance.  |enum: The exact type <br> **-or** <br>  protocol: comma separated list of inherited protocols |
| `State.Model`       | set raw value model type for a raw value enum.  |`Model`, `ModelArray`, `ModelDictionary`  |
**values in bold = default when no value is present.**

### Attribute Settings

| Key                              | Description                | Values            |
| -------------------------------- | -------------------------- | :----------------:|
| `State.Immutable`    | set is read-only, (use `let` instead of `var` for property) | `YES`, **`NO`** |
| `State.Type`       | set type for property or associated value | The exact type  |
| `State.Func`       | set the function signature for a protocol function requirement| The exact signature of the function requirement  |
| `State.Mutating`       | set a protocol function requirement is `mutating` | `YES`, **`NO`**  |
| `State.ProtocolRequirementType`       | set protocol requirement type (get = readonly property) | `func`, **`var`**, `get`  |
| `State.Value`	| set default value for a property  (only supported for non-optional properties) <br>**-or-**<br>  raw value enum: sets the raw value of a case. | The exact value
| `State.Import`	| import a module in the generated source associated with the particular attribute  | The exact module name


### Relationship Settings
| Key                              | Description                | Values            |
| -------------------------------- | -------------------------- | :----------------:|
| `State.CompositionType`       | set the collection type for a one-to-many relationship|Dictionary,  **Array**  |

**values in bold = default when no value is present.**

## Structs
Entities are structs by default.

1. Create an entity, give it a name, and set a class name in the property inspector.
2. Create attributes, and relationships as required.

## Enums
1. Add the key `State.Enum` and the value `YES` to an entity in the user info area of the inspector to specify an entity as an enum.
2. Add attributes to create cases for the enum. The name of the attribute becomes the name of the case.

### Associated values

*  Add the key `State.Type` to the user info section of the inspector for the attribute and specify the
type in the value field.

*-or-*

*  Create a relationship to another model entity to specify the destination entity type as the associated value type.

### Raw value enums

1. Specify an entity as an enum as described above

2. Add the `State.Type` key to the **Entity** in the user-info part of the inspector

3. Specify a type in the value field of the `State.Type`.

4. Add attributes to create cases for the enum. The name of the attribute becomes the name of the case.

5. Add the `State.Value` key and a value to each **Attribute** in  the user info inspector to specify the raw value of each enum case.

Notes:
* Raw values enum types can be any type including other model entities
* Optionals are not supported for raw value types
* Raw value enums cannot have associated value types in the cases

## Protocols

To create a protocol:

1. create an entity, give it name and a class name in the property inspector.
2. Add the `State.Protocol` key to the user info section, or check the abstract checkbox in the inspector.

### Function requirements
Use the `State.ProtocolRequirementType` and the `State.Func` key on the protocol entities attributes.

**Note:** an empty implementation is added to the **manual** file only the first time it is generated. If you already generated code before adding this requirement
you may have to manually add it to the manual file.

On the protocol requirement attribute:
- Set State.ProtocolRequirementType to Func
- Set State.Func to the exact function signature of the requirement

### Read-only property requirements

Use the `State.ProtocolRequirementType` with a value of `get` on protocol attributes and relationships.

**Note:** an empty implementation is added to the **manual** file only the first time it is generated. If you already generated code before adding this requirement
you may have to manually add it to the manual file.

### Protocol inheritance  
There are two ways you can specify a protocol inherits from other protocols.

1. Set one protocol entity as the parent of another protocol entity
2. Use the `State.Type` key on a protocol entity to specify additional protocols. These are entered as a comma separated list. For example if you want your protocol
to also inherit from `CustomStringConvertible` and `CustomDebugStringConvertible` you would enter `CustomStringConvertible, CustomStringConvertible` as the value for
`State.Type` on the protocol entity.

**Note:** you can use these two methods in combination if needed

### Protocol conformance
To specify a model item has conformance to a protocol, set the protocol as the parent entity of a model item.

**Note:** Only structs can conform at this time. You do not need to re-specify the protocols requirements in your conforming entity, they will be inherited and implemented automatically.

### Using protocols

You can use protocols as types just like struct and enum types. A protocol extension is started for you in the manual file so you can extend your protocol if needed.

You can compose with protocols. For example, one model item can have a one to many composition to a protocol type. This allows you to add any conforming type into the composition collection of the containing model type.

#### Example
The following shows a valid model design for an AssetLibrary. AssetGroup has assets which is a one-to-many relationship to the `Asset protocol type`. `FileAsset` is protocol that inherits from `Asset`. ColorAsset, ImageAsset, and SoundAsset are all conforming model types.

You can add any of the conforming types to the assets of `AssetGroup`. When AssetGroup is serialized and de-serialized, each type contained in the assets composition will be restored.

![<Protocol Example>](Resources/protocol_1.png)

Notes
* Protocol requirements can include other model items
* Model items can have relationships to protocol types.

## Optionals
Select the optional check box for an attribute in the data modeler inspector window and the property will be implemented as an optional type.

## Default Values
You can specify a default value in the inspector window, or use `State.Value` in the user info section to give a property a default value.

Current limitations are:
1. not supported for optional types

## Transients
There is preliminary support for transient properties. Mark the attribute as transient in the inspector. Transients MUST be optional OR have a default value.

## Data Modeler Notes / Gotchas

- You must always enter a class name in the entities property inspector or no code will be generated
- Int16, Int32 or Int64 are all currently implemented as Int.
- If you enter a custom type using `State.Type` key, it will override the type in the inspector attribute type option list. Even when using `State.Type` you have to still choose an arbitrary type (which will be ignored) in the type selection box or the build will have errors.
- Do not link the .xcdatamodel file to your target.
- Do not to generate circular dependencies in the modeler.

# Generating Code
You must have mogenerator installed and it must be the version specified
in the requirements. (newer versions of mogenerator are not supported).

To generate the model code files:

```
mogenerator --model <$path to the .xcdatamodeld file> --swift --template-path <$path to the state templates directory> <$path to the output directory>
```

## Code files

Two files for each entity in the model design are generated when you run Mogenerator.
- _Model.swift
- Model.swift  

The file with the underscore prefix is the automatic file, and the other is the manual file. The automatic file is updated every time you regenerate the code after modifying the model design file. The manual file is only generated once the first time you generate code. Therefore the manual file is not overwritten and is safe for you to use for extending the models via. a swift extension.

The manual file serves the following purposes:

- extend the model code via a swift extension in this file
- hook in to the encoding and decoding process, so you can read and write additional data during decoding and encoding if needed.
- manage the versioning and migration of the models if and when needed.

To add the files to your project drag the model code files in to your project to add them.

# Adding State framework to your project.

## Carthage

[Carthage]: https://github.com/Carthage/Carthage

Add the following to your project's Cartfile:

```
github "STLabs/State" ~> 0.1
```

Then run `carthage update`.

Follow the current instructions in [Carthage's README][carthage-installation]
for up to date installation instructions.

## Submodule
1. Add State as a submodule by going to your project directory and enter the following:
	`git submodule add https://github.com/STLabs/State.git`
2. Open the State folder and drag and drop the State.xcodeproj into the file navigator of your workspace.

3. In Xcode, select the project icon to open the target window and select your host target that will use State.

4. Select the "Build Phases" tab in the target configuration window.

5. Add State as a target dependency to the host target

6. Click on the + button at the top left and select "New Copy Files Phase". Rename this new phase to "Copy Frameworks", set the "Destination" to "Frameworks", and add State.framework.

[carthage-installation]: https://github.com/Carthage/Carthage#adding-frameworks-to-an-application


# Reading and Writing Models

Models, and collections of models can be
  written to and read from files, `Strings`, or `Data`.

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
Versioning and migration is opt-in. Models do not version or migrate by default.

To support versioning and migration implement the following methods in your model extension:

  * `static func writeVersion(with: inout Store)`

     This method is called before writing a model is finished to give the model an
     opportunity to write version information to the output.

  * `static func migrate(from: Store) -> Store`

     This method is called before reading a model to give the model
     an opportunity to migrate the store. In this method:

    -  read the version information from the store
    -  compare the version information with the "current version"
    -  add, remove, and update keys, and values to the store
    -  return the updated store

## Automatic code generation setup.

If you want to automaticly update the model code each time you build your project do the following.

1. In your Xcode project, select `file > new > target`, and under OS X select other. Choose "External Build System" and click next.

2. give your target a name such as "GenerateModels" and hit finish.

3. select your project in the project navigator and select the new target you just added

4. under the info tab for the target set up the "External Build Tool Configuration" as follows:

Build Tool: `/usr/local/bin/mogenerator`  
	(or where ever mogenerator is installed. (type `which mogenerator` in terminal to 	find the location)


Arguments:
	--model `<path to your .xcdatamodeld file>` --swift --template-path `<path to states template folder>` --output-dir `<path to save model code files>`

5. Select the target that you want to use the model entities in, and select `Build Phases` and twist open the `Target Dependencies` section at the top.

6. Click plus to add a dependency, select the GenerateModels target.
	This will tell Xcode to build your GenerateModels target before building the host target.

7. The first time you generate the code files you will have to manually add them to the project.

You should now be able to add entities to the data modeler, and the code files should generate each time you build. If not, check the issue or report navigator to investigate the cause.
