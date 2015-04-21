#Spot [![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

Spot is a model framework for using swift structs. You can design models using Xcode's Core Data model design tool. Model code is  generated automatically using [Mogenerator](https://github.com/rentzsch/mogenerator) and provides serialization to and from Plists, XML Plists, or JSON.

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
This code is generated using [Mogenerator](https://github.com/rentzsch/mogenerator) and the Spot templates. Note: A human file is also generated which is an extension of your struct. To extend your model layer you edit the human file.


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
### Write models to JSON or .Plist files:

```swift
// Write issues out to a json file
JSON.write(Encoder.encodeModel(issues), path: documentPathFor("issues.json"))

// Write issues out to a binary Plist file
Data.write(Encoder.encodeModel(issues), path: documentPathFor("issues.plist"))

// Write issues out to a XML Plist file
Plist.write(Encoder.encodeModel(issues), path: documentPathFor("issues.plist"))
```



### Read models from JSON  or .Plist files.
```swift
// Read JSON and decode issues model
let loadedIssues: Issues? = Decoder.decodeModel(JSON.read(documentPathFor("issues.json")))

// Read binary Plist and decode issues model
let loadedIssues: Issues? = Decoder.decodeModel(Data.read(documentPathFor("issues.plist")))

// Read XML Plist and decode issues model
let loadedIssues: Issues? = Decoder.decodeModel(Plist.read(documentPathFor("issues.plist")))
```
### The Human Generated File
Two files are generated from your model design. 
_FileName.swift = machine generated file
FileName.swift = human generated file

The human generated file serves the following purposes:

- Is where you to extend your model code
- Allows you to hook in to the encoding and decoding process, so you can read and write additional data if needed.
- Allows you to delegate versioning and migration, giving you complete control over the model versioning and migration process.

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



