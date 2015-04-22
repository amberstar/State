#![spot](https://cloud.githubusercontent.com/assets/84623/7276787/41cf145e-e8da-11e4-8ef0-0f77209eca44.png) Spot

[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

### A model framework for swift struct based models.
Spot is a swift model framework that uses structs. You design models using [Xcode's Core Data model design tool](https://developer.apple.com/library/ios/recipes/xcode_help-core_data_modeling_tool/Articles/about_cd_modeling_tool.html#//apple_ref/doc/uid/TP40010379-CH3-SW1). Model code is  generated automatically using [Mogenerator](https://github.com/rentzsch/mogenerator) and provides serialization to and from Plists, XML Plists, or JSON.

                                                                                                                                                                                                                                                      
####Key Features: 


- Design model structs and enums in the Xcode model designer
- model code automatically generated
- use immutable, optional, and non-optional properties 
- serialize/deserialize to and from Plists and JSON 
- model versioning and migration managment
- make fast changes and additions to your model layer
- no heavy subclassing required

##Getting Started
The process of creating your model is:

1.  Design your models in Xcode's data model tool
2.  Run the model design file through mogenerator using the spot templates
3.  Add the Spot framework and the model files to your poject

![diagram1](https://cloud.githubusercontent.com/assets/84623/7276947/23cae810-e8db-11e4-8061-41a1dfd68d97.png)
  
## Designing your model in the Xcode model design tool

###Create the model design file
1. In your project select file new, and select Core Data.
2. Select Data Model and click next.
3. Give your model a name and click the create button.
4. In the project navigator select the model design file.
5. In the Xcode menu select View > Utilities > Show File Inspector
6. In the file inspector uncheck any target memebership
7. Open the model design file and add the entities, attributes, and relationships you want in your model layer.

In the modeler elements correspond to your model as follows:
* Entity == Struct || Enum
* Entity.Attribute == property || if Enum == case
* One-One Relationship == composition
* One-Many Relationship == \[composition\] (array)
* Enum Relationship == Enum Type property

See the [Data Model Design Reference](https://github.com/amberstar/Spot/wiki/Data-Model-Design-Reference) for more information.

## Generating model code with Mogenerator

### The model files
Two files for each entity in your model design are generated when you run Mogenerator.
- _Model.swift
- Model.swift  

The file with the underscore prefix is the automatic file, and the other is the manual file. The automatic file is updated every time you regenerate your code after modifying the model design file. The manule file is only generated once the first time you generate code. Therefore the manual file is not overwritten and is safe for you to use for extending your models via. a swift extension.

The manual file serves the following purposes:

- extend your model code via a swift extension in this file
- hook in to the encoding and decoding process, so you can read and write additional data during decoding and encoding if needed.
- manage the versioning and migration of your models if and when needed.



###Serialization
Serialization is done with data adapters provided in the Spot framework. Three data adapters are included:

1. Data.swift to read and write binary plist files
2. Plist.swift to reads and writes XML plist files
3. JSON.swift to read and write JSON files


#### Read and write models to JSON or PLISTS :


```swift
// Encode model and write out to a JSON file
JSON.write(Encoder.encodeModel(issues), path: documentPathFor("issues.json"))

// Encode model and write out to a binary Plist file
Data.write(Encoder.encodeModel(issues), path: documentPathFor("issues.plist"))

// Encode model and write out to a XML Plist file
Plist.write(Encoder.encodeModel(issues), path: documentPathFor("issues.plist"))
```

```swift
// Read JSON and decode model
let loadedIssues: Issues? = Decoder.decodeModel(JSON.read(documentPathFor("issues.json")))

// Read binary Plist and decode model
let loadedIssues: Issues? = Decoder.decodeModel(Data.read(documentPathFor("issues.plist")))

// Read XML Plist and decode model
let loadedIssues: Issues? = Decoder.decodeModel(Plist.read(documentPathFor("issues.plist")))
```


### Versioning and Migration  
Versioning and migration management is opt in. It allows you to fully control the version and migration of the models. The automatic layer of your model code passes delegation to the manual layer.  It's in the manual layer that you  specify and control all of the following:
- if models should be versioned when encoded
- a versionKey to use for the version encoding
- the current version of the model
- if version checking and migration is done at all
- does a model need migration
- directly migrate raw key-value data to the current version before attempting to read a model

When designing your model in the model designer, you can specify a version hash modifier signifying a new model version. This version modifier get's carried over to the model code so you can determine if a model version about to be decoded is a different version than the current version of your model code




## Adding Spot to your project

#### Using Carthage

[Carthage]: https://github.com/Carthage/Carthage

Add the following to your Cartfile:

```
github "amberstar/Spot" ~> 0.1
```

Then run `carthage update`.

Follow the current instructions in [Carthage's README][carthage-installation]
for up to date installation instructions.

#### As a Submodule
1. Add Spot as a submodule by going to your project directory and enter the following:
	`git submodule add https://github.com/amberstar/Spot.git`
2. Open the Spot folder and drag and drop the Spot.xcodeproj into the file navigator of your workspace.

3. In Xcode, select the project icon to open the target window and select your host target that will use Spot.

4. Select the "Build Phases" tab in the target configuration window.

5. Add Spot as a target dependency to your host target

6. Click on the + button at the top left and select "New Copy Files Phase". Rename this new phase to "Copy Frameworks", set the "Destination" to "Frameworks", and add Spot.framework.

[carthage-installation]: https://github.com/Carthage/Carthage#adding-frameworks-to-an-application



###3.  Set-up a target to automatically generate model code every time you build.

See [The Wiki Page for instructions] (https://github.com/amberstar/Spot/wiki/How-to-set-up-a-target-to-automatically-generate-model-code-every-time-you-build-your-host.)

##System Requirements
- Swift 1.2
- Xcode 6.3
- iOS 8.0
- Mogenerator 1.28

## License

Spot is released under the MIT license. See
[LICENSE.md](https://github.com/amberstar/Spot/blob/master/LICENSE).

## More Info

- [See the example project ](https://github.com/amberstar/Spot/tree/master/SpotExample)
- [See the Wiki](https://github.com/amberstar/Spot/wiki)
- [Take a look a some models created with Spot](https://github.com/amberstar/Spot/tree/master/SpotExample/SpotExample/Models)


Have a question? Please [open an issue](https://github.com/amberstar/Spot/issues/new)



