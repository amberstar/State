#STState

A Swift model framework. Encoding / Decoding to JSON, plists, binary, or any custom format.
                                                                                                                                                                                                                                                   
####Features: 

- struct, enum, and protocol model types
- immutable, optional, non-optional, and transient properties
- JSON, Plists, and Binary serialization
- versioning/migration 
- Use Xcode model designer and code generator (optional)

#### Articles:

- [Creating Enum Models With STState Model Framework](http://www.amberstar.org/creating-enum-models-with-state-model-framework/)
- [Using Protocols With STState Model Framework](http://www.amberstar.org/state-model-framework-protocols/)
- [Using a Dissolver with STState Model Framework](http://www.amberstar.org/using-dissolvers-with-ststate-model-framework/)

#### Saving and loading models to a file
```swift

// JSON
model.save(.JSON, path: "model.json")
let model = ModelType(.JSON, path: "model.json")

// Plist
model.save(.Plist, path: "model.plist")
let model = ModelType(.Plist, path: "model.plist")
```



#### Sample Model (Code generated automaticly):
This example shows you can have constants, optionals, and composition of other models.

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

## General Design  

STState has a protocol oriented design

![<Protocol Oriented>](Docs/Resources/diag2.png)

STState is designed for the application that has only one, or a hundred model items where you want to use lightweight plist, or JSON formats to store models, and you want to take advantage of Swift's structs, enums, and protocols.

* coding is provided through a protocol similar to NSCoding.
* light weight code base
* low dependency surface area
* The coding process is decoupled from the data conversion format. All models are encoded and decoded to an intermediate Key-Value dictionary. From there the Key-Value data is then either decoded into a model, or converted to a target format (bin, plist, json).

![<Protocol Oriented>](Docs/Resources/diag4.png)


## Using Xcode Data Model Designer, and Automatic Code Generation (optional)
STState  comes with mogenerator templates so you can design models in the Xcode data model designer.  Writing model code that reads and writes models to JSON or Plists, is a tedious unnecessary task. Being able to make changes quickly to your model layer and have your models generated automatically, with consistent clean code, when you build your project is a powerful way to save you hours of writing tedious code. This is especially useful now, because as the Swift language changes, you can easily update all of your model code by just updating to the latest version of STState.

**Q.** If I use code generation, can I still add code manually to my models?

**A.** Yes. When you use code generation, two files are created for each model. An automatic file and a manual file. The manual files is only created the first time you generate the code, so it is never overwritten again. The automatic file is regenerated every time you generate code. The manual file has an extension where you can extend your model.


## Documentation
# [ Read the Documentation to Get Started](Docs/)

##System Requirements
- Swift 2.0
- Xcode 7.0
- iOS 8.0
- Mogenerator 1.28

## License

STState is released under the MIT license. See
[LICENSE.md](https://github.com/STLabs/STState/blob/master/LICENSE).
