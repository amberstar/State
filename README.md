#Spot

Spot is a lightweight model framework designed for Swift structs. You design your model layer entities using Xcode's Core Data model design tool.You can then generate model code automatically using custom code templates for the mogenerator command line tool. The code generated provides serialization to and from raw key value dictionaries. Data adapters are provided to read and write binary Plists, XML Plists, or JSON.

-

Spot is not for every project, but if you need a simple lightweight solution, you've come to the right... *Spot*.

- Design  model entities using Xcode's data model designer
- Use swift structs and enums for  model entities
- Design enums directly in the model designer
- Automatic Serialization 
- Use optional, non-optional, and immutable types
- Automatically generate model code 
- No heavy model layer subclassing required
- Extend your model entities with Swift extensions
- Make fast changes and additions to your model entities

Turn This : <img src="https://cloud.githubusercontent.com/assets/84623/7208746/e8ff0658-e510-11e4-9327-1fad64ab9a93.png">

Into:

```swift
import Spot

/************************************************
            MACHINE GENERATED FILE
 ************************************************/

public struct Issue {
    var comment: String?
    var title: String
    var assignee: Developer
    var product: Product
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




##System Requirements
- Swift 1.2
- Xcode 6.3
- iOS 8.0
- Mogenerator 

-
### Entity Key-Value Reference
| Key                              | Description                | Values            |
| -------------------------------- | -------------------------- | :----------------:|
| `Spot.Enum` | Entity is an enum. All attributes are considered cases. Specify raw value type with `STModel.Type` . | `YES`, `NO` |
| `Spot.Type`       | Raw value type for  enum. | The exact name of the type to use as the raw value type for the enum entity.  |

### Attribute Key-Value Reference
| Key                              | Description                | Values            |
| -------------------------------- | -------------------------- | :----------------:|
| `Spot.Immutable`    | Attribute is immutable (use `let` instead of `var`) | `YES`, `NO` |
| `Spot.Type`       | The type of the attribute. useful for transformable. (if this key is present it overrides the option selected in the data model inspector)| The exact name of the type to use for entity.  |
| `Spot.Value`	| The raw value of the enum case. used when entity is an enum. each attribute is considered a case of the enum. the value specified is the raw value of the current case. | The exact value of the case. (strings must be in quotes)


