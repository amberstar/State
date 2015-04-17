#Spot
An ultra lightweight model framework designed for Swift structs. Design model entities using Xcode's Core Data model design tool. Model code is  generated automatically using [Mogenerator](https://github.com/rentzsch/mogenerator). Generated code provides serialization to and from Plists, XML Plists, or JSON.

###Why?
It's for using lightweight structs, encoding the properties to key value data, and serializing that data to a file. It's a simple, and lightweight approach. It's also about the power of code generation, modeling your entities graphically, generating model code automatically and making changes and additions to your model design quickly. Regenerating  code in seconds rather than hours of tedious coding is great. It's not for every project, but if you understand the benefits and limitation of structs, and you want a lightweight solution you might find this useful.

####Some Points: 

- zero code model generation
- one line of code for Plist and JSON serialization 
- immutable, optional, and non-optional properties
- Use enums (design enums directly in the model designer)
- No heavy model layer subclassing
- Extend your model entities with Swift extensions (generated for you)
- Make fast changes and additions to your model layer

###It's beta
It has not been fully integrated into a production project. I am releasing it now to get feedback and possible help building it further for the benefit of anyone who might find it useful. 

##tl;dr:
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
### Write models to JSON (or .plists):

```swift
// Write issues out to a json file
JSON.write(Encoder.encode(issues), path: documentPathFor("issues.json"))
```



```json
"openIssues" : [
    {
      "product" : {
        "name" : "iSpot Pro"
      },
      "comment" : "write more tests",
      "assignee" : {
        "name" : "Spiff Johnson"
      },
      "status" : {
        "value" : 1
      },
      "type" : {
        "value" : "task"
      },
      "title" : "New Issue"
    },
```

### Read models from JSON  (or .plists).
```swift
// Read JSON and decode issues model
let loadedIssues: Issues? = Decoder.decode(JSON.read(documentPathFor("issues.json")))
```
##System Requirements
- Swift 1.2
- Xcode 6.3
- iOS 8.0
- Mogenerator 1.28

-


##Getting Started

### 1. Adding Spot to your project

### [Carthage]

[Carthage]: https://github.com/Carthage/Carthage

Add the following to your Cartfile:

```
github "amberstar/Spot"
```

Then run `carthage update`.

Follow the current instructions in [Carthage's README][carthage-installation]
for up to date installation instructions.

[carthage-installation]: https://github.com/Carthage/Carthage#adding-frameworks-to-an-application

### 2. [Install Mogenerator] (https://github.com/rentzsch/mogenerator)
[Mogenerator](https://github.com/rentzsch/mogenerator) is a command line tool that is easy to install and use. Mogenerator is used with the Spot templates to generate your model classes. While automatic code generation is not required, it is one of the greatest benefits to using Spot.

You can download Mogenerator [here](http://rentzsch.github.io/mogenerator/), or to install using [homebrew](http://mxcl.github.com/homebrew)  use $ brew install mogenerator 

###3.  Set-up a target to automatically generate model code every time you build your host.

If you do not have Spot framework, or mogenerator installed do that first. 
 
1. In your Xcode project, select `file > new > target`, and under OS X select other. Choose "External Build System" and click next.

2. give your target a name such as "GenerateModels" and hit finish.

3. select your project in the project navigator and select the new target you just added

4. under the info tab for the target set up the "External Build Tool Configuration" as follows:

	#####Build Tool: `/usr/local/bin/mogenerator`  
	(or where ever mogenerator is installed. (type `which mogenerator` in terminal to 	find the location)
	

	#####Arguments:
	--model `<path to your .xcdatamodeld file>` --swift --template-path `<path to spots template folder>` --output-dir `<path to save model code files>`

	#####example: 
If spot is installed in a subdirectory of your project, and you had a models folder for your models, it would look something like this: --model $(SRCROOT)/ProjectName/Models/Model.xcdatamodeld --swift --template-path $(SRCROOT)/../Spot/Templates --output-dir $(SRCROOT)/ProjectName/Models/

5. Select the target that you want to use the model entities in, and select `Build Phases` and twist open the `Target Dependencies` section at the top. 

6. Click the plus to add a dependency and select the GenerateModels target you just created earlier. 
	This will tell Xcode to build your GenerateModels target before building the host target.
	
7. The first time you generate the code files you will have to manually add them to the project.

You should now be able to add entities to the data modeler, and the code files should generate each time you build. If not, check the issue or report navigator to investigate the cause.






## Data Modeler:
Note: You enter these keys and values into the user-info section of the data modeler inspector window when you want to use the options.


#####Terminology:
In the modeler an Entity will correspond to a struct or an enum in your model code. Attributes of entities will correspond to properties of structs, or cases for enums.
Relationships represent composition. A one-to-many relationship results in collection of elements being composed in the "one" side of the relationship. A one-to-one relationship is a simple composition. A relashionship to an enum corosponds to a property represented by the enum type with it's value being one of the enum cases.



### Entity Key-Value Reference
| Key                              | Description                | Values            |
| -------------------------------- | -------------------------- | :----------------:|
| `Spot.Enum` | Specify entity is an enum. All attributes are considered cases of the enum. Specify raw value type with `STModel.Type` . *required for enums. | `YES`, `NO` |
| `Spot.Type`       | Raw value type for  enum. *required for enums.| The exact name of the type to use as the raw value type for the enum entity.  |

### Attribute Key-Value Reference
| Key                              | Description                | Values            |
| -------------------------------- | -------------------------- | :----------------:|
| `Spot.Immutable`    | Specify an attribute is immutable (code will use `let` instead of `var` for the property) | `YES`, `NO` |
| `Spot.Type`       | The type of the attribute. Useful for specifying a custom type for an attribute. (select "undefined" in the inspector window when using this option)| The exact name of the type to use for entity.  |
| `Spot.Value`	| The raw value of the enum case. used when entity is an enum. each attribute is considered a case of the enum. the value specified is the raw value of the current case. *required for enums. | The exact value of the case. (strings must be in quotes)

### Relationships Between Entities
One to One, and One to Many single direction relationships are supported. One-to-many uses a typed array property.

### Enums
Raw value enums can be modeled in the modeler using the options noted in the key-value reference. Associated types are not supported, or must be implemented the old way, like an animal. (note you can however implement the Decodable, and Encodable protocols to support serialization yourself. While the API is a little verbose, it's still fairly straightforward.

### Transformables:(experimental)
Set an attribute type as transformable in the data modeler, and enter a value transformer name. The value transformer name entered must be of a type that implements the [ValueTransform] (https://github.com/amberstar/Spot/blob/master/Spot/Transforms/ValueTransform.swift) protocol. Your model will automatically use the transform type to transform the attribute when encoding and decoding the element.

### Optionals:
Select the optional check box for an attribute in the data modeler inspector window and the attribute will be implemented as an optional.

### Protocols:
Protocols are not generated, but you can model an Abstract Entity type that represents a protocol, and set it as the parent of any Entity you wish. This will declare the Abstract entity name as a protocol in the struct declaration.

### Data Modeler Notes:

- You must always enter a class name for entities or no code will be generated for that entity. (you will forget to do this, and things wont build. I warned you)
- Int16, Int32 or Int64 are all currently implemented as Int.
- If you enter a custom type using `Spot.Type` key, remember to select "undefined" as the type in the attribute option type.
- Do not link the .xcdatamodel file to your target, that's just asking for trouble. Leave the model file in your project, but just uncheck it so it doesn't link to any of your targets.
- When adding or renaming entities in your model, remember that you may need to copy the new generated files in to your project. (re-naming entities generates new files).
- Recursive type references are not supported  with swift structs without boxing, therefore be sure not to generate circular dependancies in the modeler.
- tip: You can implement your model container in the modeler. For example: Let say you want to create a model item called to-do. You can create a container item called `To-dos, with a one to many relationship. You can have more than one, one-to-many relationships, so you can have completed to-dos as a second relationship to the same container. By modeling your container, it gives you the ability to store and load the entire collection as one group. It also creates an ideal container object to implement your model substrate.
- tip: You do not have to have one entire model tree. You can implement sub-trees, or individual model entities as needed. Heck, you can even have more then one model design file if need be.




