#Spot [![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

Spot is a model framework that uses swift structs. You can design models using Xcode's Core Data model design tool. Model code is  generated automatically using [Mogenerator](https://github.com/rentzsch/mogenerator) and provides serialization to and from Plists, XML Plists, or JSON.

####Key Features: 

- Swift struct based models
- design model objects and enums in the Xcode model designer
- automatic model code generation
- immutable, optional, and non-optional properties 
- one-to-one, and one-to-many relationships to other models, and enums
- serialization to/from Plists and JSON 
- model versioning and migration setup for you, but you control
- make fast changes and additions to your model layer
- no heavy subclassing required

##Usage
### Design your model layer in Xcode's data model tool:
 <img src="https://cloud.githubusercontent.com/assets/84623/7208746/e8ff0658-e510-11e4-9327-1fad64ab9a93.png">

### Swift struct model code is generated automatically:
The code is generated using [Mogenerator](https://github.com/rentzsch/mogenerator) and the Spot templates. 

 ```swift
import Spot

/************************************************
            MACHINE GENERATED FILE
 ************************************************/

public struct Issue {
	let product: Product
    var comment: String?
    var title: String
    var assignee: Developer
    
    var status: IssueStatus?
    var type: IssueType

    init(comment: String?, title: String, assignee: Developer, product: Product, status: IssueStatus?, type: IssueType) {

        self.comment = comment
        self.title = title
        self.assignee = assignee
        self.product = product
        self.status = status
        self.type = type

    }
}

extension Issue : Decodable {

    static func create(comment: String?)(title: String)(assignee: Developer)(product: Product)(status: IssueStatus?)(type: IssueType) -> Issue  {

        return Issue(comment: comment, title: title, assignee: assignee, product: product, status: status, type: type)
    }

    public init?(decoder: Decoder) {
        let instance: Issue? = Issue.create
        <^> decoder.decodeOptional("comment")
        <*> decoder.decode("title")
        <*> decoder.decodeObject("assignee")
        <*> decoder.decodeObject("product")
        <*> decoder.decodeOptionalObject("status")
        <*> decoder.decodeObject("type")

        if let i = instance { self = i } else { return nil }
    }
}

extension Issue : Encodable {

    public func encode(encoder: Encoder) {
        encoder.encode(self.comment, forKey: "comment")
        encoder.encode(self.title, forKey: "title")
        encoder.encode(self.assignee, forKey: "assignee")
        encoder.encode(self.product, forKey: "product")
        encoder.encode(self.status, forKey: "status")
        encoder.encode(self.type, forKey: "type")

    }
}
```

##Serialization
Spot provides serialization using a data adapter. A data adapter is a  class responsible for reading and writing one specific data type. Serialization is done in two-phases:

1. Phase 1 Encoding   [ Model Types  -> Key-Value Data]
2. Phase 2  Serialization  [Key-Value Data -> Data adapter -> Output]

* deserialization is the exact reversal of this process.

During phase one an encoder encodes the model to raw key-value data. This is  similar NSCoding but for structs. 

Once model data is encoded to key-value data, a data adapter is used to write it to its output endpoint.

You can choose any one of the built in data adapters, or you can subclass the Data.swift data adapter to make your own.

Three data adapters are provided:

1. Data. -> uses NSKeyValueArchiver to read and write binary archive plist files
2. Plist. -> reads and writes XML plist files
3. JSON. -> read and write JSON files

The data adapters can do the following in it's respective format: 
- Read/Write files
- Read/Write NSData
- Read/Write to a String (if supported)
- Print to std out
- Read from a URL

#### Write models to JSON or .Plist files:

The API for the various data adapters are all the same.

```swift
// Write issues out to a json file
JSON.write(Encoder.encodeModel(issues), path: documentPathFor("issues.json"))

// Write issues out to a binary Plist file
Data.write(Encoder.encodeModel(issues), path: documentPathFor("issues.plist"))

// Write issues out to a XML Plist file
Plist.write(Encoder.encodeModel(issues), path: documentPathFor("issues.plist"))
```

#### Read models from JSON  or .Plist files.
```swift
// Read JSON and decode issues model
let loadedIssues: Issues? = Decoder.decodeModel(JSON.read(documentPathFor("issues.json")))

// Read binary Plist and decode issues model
let loadedIssues: Issues? = Decoder.decodeModel(Data.read(documentPathFor("issues.plist")))

// Read XML Plist and decode issues model
let loadedIssues: Issues? = Decoder.decodeModel(Plist.read(documentPathFor("issues.plist")))
```
### About The Human File
Two files are generated from your model design when you run Mogenerator.
- _FileName.swift  (the 'machine' file)
- FileName.swift    (the 'human' file)

The machine file is updated every time you regenerate your code after modifying the model design file. The human file is only generated once the first time you generate code. Therefore the human file is not overwritten and is safe for you to use for extending your models via. a swift extension.

The human file serves the following purposes:

- extend your model code via a swift extension in this file
- hook in to the encoding and decoding process, so you can read and write additional data during decoding and encoding if needed.
- delegate versioning and migration, giving you complete control over the model versioning and migration process.

[See an example human generated file](https://github.com/amberstar/Spot/blob/master/SpotTests/Models/TestModels/Company.swift)

### Versioning and Migration Management 
The versioning and migration management scheme is opt in, and allows you to fully control the process. The machine layer of your model passes delegation to the human layer of the model.  It's in the human layer that you  specify and control all of the following:
- if models should be versioned when encoded
- a versionKey to use for the version encoding
- the current version, with AnyObject type as the version
- if version checking and migration is done at all
- specify if a given version found in the data model needs migration
- directly migrate raw key-value data to the current version before attempting to decode a model

Two versioning variables are provided during the process that are sourced from  the  model design file. The following are available for you to determine if a model version about to be decoded is a different version than the current version of your model code.
```swift
/**
    These are provided from the data model designer
    and can be used to determine if the model is
    a different version.
    */
    static var modelVersionHash: String {
        return "<ab73b735 b1201428 cbab765c 5357fbe9 b413a176 90618f51 b3efae27 d31a5116>"
    }

    static var modelVersionHashModifier: String? {
        return nil
    }
```
Below are the methods that are implemented for you in your human file. You can modify the implementations as approptiate to control the version and migration process:

```swift
///MARK: Migration
extension Company {

    /**
    true if the encoder should include a model version
    when encoding the model.
    */
    static var shouldEncodeVersion: Bool {
        return false
    }

    /**
    true if the decoder should perform a migration if needed
    during decoding of the model
    */
    static var shouldMigrateIfNeeded: Bool {
        return false
    }

    /**
    a key to use for encoding the model version
    */
    static var versionKey: String {
        return "model_version"
    }

    /**
     the current model version
    :param: modelVersionHash a unique hash from the model design that generated the model
    :param: modelVersionHashModifier a hash modifier if any from the model design that generated the model
    :returns: an object the represents the model version used to denote the model "version"
    :Discussion: This method is called during encoding and decoding when the version is needed.
    The modelVersionHash and modelVersionHashModifier are provided from the model designer to help denote
    a unique version. What type, and how to make that denotation is unspecified
    */
    static func version(modelVersionHash: String, modelVersionHashModifier: String?) -> AnyObject? {
        return modelVersionHash
    }

    /**
    determines if the model data being decoded needs migration
    :param: dataVersion the version of the data to be decoded
    :returns: true if a migration is needed
    :Discussion: This method is called during decoding if
        - shouldMigrateIfNeeded returns true
        - a version was found in the data using the versionKey
    given the dataVersion parameter, this method should determine if the data being decoded is a different version
    than the current version, and needs to be migrated.
    */
    static func needsMigration(dataVersion: AnyObject) -> Bool {
        if let dataVersion = dataVersion as? String,
            currentVersion = version( modelVersionHash, modelVersionHashModifier: modelVersionHashModifier) as? String {
            return dataVersion != currentVersion
        } else {
            return false
        }
    }

    /**
    migrate model data before decoding
    :param: data model data that needs migration
    :param: dataVersion the version of the data to be migrated
    :returns: migrated data
    :Discussion: This method is called during decoding if the following are true:
    - shouldMigrateIfNeeded returns true
    - a version was found in the data using the versionKey
    - needsMigration returns true
    This method should perform the migration needed to prepare the data for decoding.
    Here you can add keys and values, remove keys and values, rename properties, etc.
    migrated data returned will then be used for decoding the model.
    Note: the data version will automatically be updated the next time the model is encoded.
    */
    static func migrateDataForDecoding(data: [String : AnyObject], dataVersion: AnyObject) -> [String : AnyObject] {
        return data
    }
}

```

##Getting Started

### 1. Adding Spot to your project

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

### 2. Install Mogenerator
[Mogenerator](https://github.com/rentzsch/mogenerator) is a command line tool that is easy to install and use. Mogenerator is used with the Spot templates to generate your model classes. 

You can download Mogenerator [here](http://rentzsch.github.io/mogenerator/), or to install using [homebrew](http://mxcl.github.com/homebrew)  use $ brew install mogenerator 

###3.  Set-up a target to automatically generate model code every time you build.

See [The Wiki Page for instructions] (https://github.com/amberstar/Spot/wiki/How-to-set-up-a-target-to-automatically-generate-model-code-every-time-you-build-your-host.)

####System Requirements
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



