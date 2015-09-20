#State

A Swift model framework for using `structs`, `enums` and `protocols` as models. Model code can written manually or be generated automatically using [Mogenerator](https://github.com/rentzsch/mogenerator). The framework provides API for serialization to and from Plists, JSON, or Binary.
                                                                                                                                                                                                                                                   
####Features: 

- struct, enum (including associated and raw values), and protocol model types
- immutable, optional, non-optional, and transient properties
- JSON, Plists, and Binary formats
- versioning and migration (optional)
- design models in the Xcode model designer and code is generated automatically (optional)


#### Articles:

[Creating Enum Models With State Model Framework](http://www.amberstar.org/creating-enum-models-with-state-model-framework/)

[Using Protocols With State Model Framework](http://www.amberstar.org/state-model-framework-protocols/)

#### Example:
It is easy to define models with State. This example shows you can have constants, optionals, and composition of other models.

```swift
public struct MyModel : Model {
    public let myDate: NSDate
    public let myArrayOfStrings: [String]
    public var myBinary: NSData?
    public var myOtherModel: MyOtherModel
    public var myModelCollection: [MyOtherModel]
}

extension MyModel : Decodable {
    public init?(var decoder: Decoder) {
        // use guard for non-optionals
        guard
            let myDate: NSDate = decoder.decode("myDate"),
            let myArrayOfStrings = decoder.decode("myArrayOfStrings"),
            let myOtherModel: MyOtherModel = decoder.decodeModel("myOtherModel"),
            let myModelCollection: [MyOtherModel] = decoder.decodeModelArray("myModelCollection"),
        else { return  nil }
        let myBinary: NSData = decoder.decode("myBinary")

        self.myDate = myDate
        self.myArrayOfStrings = myArrayOfStrings
        self.myBinary = myBinary
        self.myOtherModel = myOtherModel
        self.myModelCollection = myModelCollection
    }
}

extension MyModel : Encodable {
    public func encode(encoder: Encoder) {
        encoder.encode(myDate, "myDate")
        endcoder.encode(myArrayOfStrings, "myArraryOfStrings")
        encoder.encode(myBinary, "myBinary")
        encoder.encode(myOtherModel, "myOtherModel")
        encoder.encode(myModelCollection, "myModelCollection")
    }
}

```

#### Basic API

```swift
// encoding
encode<T: Encodable>(value: T?, _ key: String)

// decoding
decode<T>(key: String) -> T?
decodeModel<T:Decodable>(key: String) -> T?
decodeModelArray<T:Decodable>(key: String) -> [T]?
decodeModelDictionary<T:Decodeable>(key: String) ->[String : T]?

// loading and saving models
init?(_ format: Format, path: String)
func save(format: Format, path: String) -> Bool
```

## Protocol Oriented
State has a protocol oriented design with extension points to extend all of your models.
Model items can compose with protocol types with full serialization support.

![<Protocol Oriented>](Docs/Resources/diag2.png)

Not only can you extend each individual model type with an extension, you can also add API to all of your model elements by extending the Model protocol with your own protocol extension. In-fact, this is exactly how State provides a save function to every model.


## Serialization
Convenient serialization API is provided with the  `save` function by passing in the format, and the path. Load models using an initializer that takes the format and the path.

#### Saving and loading models to a file
```swift

// JSON
model.save(.JSON, path: "model.json")
let model = ModelType(.JSON, path: "model.json")

// Plist
model.save(.Plist, path: "model.plist")
let model = ModelType(.Plist, path: "model.plist")
```

## General Design Philosophy 
State is designed to be simple, lightweight, and fast. It's for the application that has only one, or a hundred model items where you want to use lightweight plist, or JSON formats to store models, and you want to take advantage of Swift's structs, enums, and protocols.

A key design point of State is that the encoding and decoding of models are not coupled to the models themselves, instead it is provided through a protocol similar to NSCoding.

Other design points:

* extremely light weight code base
* low dependency surface area


The encoding and decoding process is also decoupled from the data conversion format. All models are encoded and decoded to an intermediate Key-Value dictionary. The Key-Value data is then either decoded into a model, or converted to a target format (bin, plist, json).
![<Protocol Oriented>](Docs/Resources/diag1.png)

![<Protocol Oriented>](Docs/Resources/diag4.png)


## Using Xcode Data Model Designer, and Automatic Code Generation (optional)
State also comes with full support to design models in the Xcode data model designer just like you do with Core Data. It comes with custom Mogenerator templates, and instructions on how to use them. Writing model code that reads and writes models to JSON or Plists, is a tedius uncessary task. Being able to make changes quickly to your model layer and have your models generated automaticly, with consistent clean code, when you build your project is a powerful way to save you hours of writing tedius code. This is especially useful now, beacuse as the Swift language changes, you can easily update all of your model code by just updating to the latest version of State.

**Q.** If I use code generation, can I still add code manually to my models?

**A.** Yes. When you use code generation, two files are created for each model. An automatic file and a manual file. The manual files is only created the first time you generate the code, so it is never overwritten again. The automatic file is regenerated every time you generate code. The manual file has an extension where you can extend your model.
![<Generated Files>](Docs/Resources/diag5.png)

## Documentation
# [ Read the Documentation to Get Started](Docs/)

##System Requirements
- Swift 2.0
- Xcode 7.0
- iOS 8.0
- Mogenerator 1.28

## License

State is released under the MIT license. See
[LICENSE.md](https://github.com/STLabs/State/blob/master/LICENSE).
