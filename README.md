#STState

A Swift model framework.

STState is designed for the application that has one or many model items where you want to use lightweight plist, or JSON formats to store models, and you want to take advantage of Swift's structs, enums, and protocols.
      
- model versioning, and migration
- design model layer in Xcode model designer and generate model code
- models can be implemented as `struct`, `enum`, and `protocol` types.
- immutable, optional, non-optional, and transient properties
- custom transforms

STState is built on three protocols, `Encodeable`, `Decodable` and `Migratable`.  Together these protocols define the `Model` protocol.

![<Protocol Oriented>](Docs/Resources/diag2.png)



 The coding process is decoupled from the data conversion format. All models are encoded and decoded to intermediate key-value data. The KV data is then converted to a target format (bin, plist, json).

![<Protocol Oriented>](Docs/Resources/diag4.png)

#### Creating a model

To create a model you conform to the Model protocol.

```swift
    public struct Person : Model {
        public let name : String
        public let age: Int 
    }
    
   extension Person : Decodable {
        public init?(decoder: Decoder) {
            gaurd 
                let name: String = decoder.decode("name"),
                let age: Int = decoder.decode("age")
            else { return nil }
            
            self.name = name
            self.age = age 
        }
   }
   
   extension Person : Encodable {
        public func encode(encoder: Endcoder) {
            encoder.encode("name" : name)
            encoder.encode("age" : age)
        }
   }
    
```

#### Saving and loading models to a file
```swift

// save person to JSON
person.save(.JSON, path: "person.json")

// load person from JSON
let person = Person(.JSON, path: "person.json")


```

#### Xcode Data Model Designer, and Automatic Code Generation
STState comes with mogenerator templates so you can design models in the Xcode data model designer.  Writing model code that reads and writes models to JSON or Plists, is a tedious unnecessary task. Being able to make changes quickly to your model layer and have your models generated automatically, with consistent clean code, when you build your project is a powerful way to save you hours of writing tedious code. This is especially useful now, because as the Swift language changes, you can easily update all of your model code by just updating to the latest version of STState.

**Q.** If I use code generation, can I still add code manually to my models?

**A.** Yes. When you use code generation, two files are created for each model. An automatic file and a manual file. The manual files is only created the first time you generate the code, so it is never overwritten again. The automatic file is regenerated every time you generate code. The manual file has an extension where you can extend your model.

## Documentation
- [ STState docs](Docs/)
- [Creating Enum Models With STState Model Framework](http://www.amberstar.org/creating-enum-models-with-state-model-framework/)
- [Using Protocols Models With STState Model Framework](http://www.amberstar.org/state-model-framework-protocols/)
- [Using a Dissolver with STState Model Framework](http://www.amberstar.org/using-dissolvers-with-ststate-model-framework/)

##System Requirements
- Swift 2.0
- Xcode 7.0
- iOS 8.0
- Mogenerator 1.28

## License

STState is released under the MIT license. See
[LICENSE.md](https://github.com/STLabs/STState/blob/master/LICENSE).
