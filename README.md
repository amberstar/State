#State

State is model framework that uses `structs`, `enums` and `protocols` for the model layer. Models are defined just like with Core Data, using [Xcode's Core Data model design tool](https://developer.apple.com/library/ios/recipes/xcode_help-core_data_modeling_tool/Articles/about_cd_modeling_tool.html#//apple_ref/doc/uid/TP40010379-CH3-SW1). Model code is  generated automatically using [Mogenerator](https://github.com/rentzsch/mogenerator). The framework provides serialization to and from Plists, JSON, or Binary.
                                                                                                                                                                                                                                                   
####Key Features: 

- Design Models just like Core Data, in the Xcode model designer
- Model code generated automatically
- Struct, Enum (including associated types), and Protocol model types supported.
- Use immutable, optional, and non-optional properties
- Read and write models to and from JSON, Plists, and Binary 
- Model versioning and migration management (optional)

## Protocol Oriented
State is implemented as a protocol oriented design giving you extension points to extend all of your models
Model items can compose with protocol types allowing any conforming type with full support of serialization of these conforming protocol types.

## Serialization
Convenient serialization API is provided using the model `protocol extension`, but that is just a start. Not only can you extend each individual model type with an extension, you can also add API to all of your model elements by extending the Model protocol with your own protocol extension.


```swift
// JSON
model.save(.JSON, path: "model.json")
let model = ModelType(.JSON, path: "model.json")

// Plist
model.save(.Plist, path: "model.plist")
let model = ModelType(.Plist, path: "model.plist")
```

### [ Read the Documentation to Get Started](Docs/)


##System Requirements
- Swift 2.0
- Xcode 7.0
- iOS 8.0
- Mogenerator 1.28

## License

State is released under the MIT license. See
[LICENSE.md](https://github.com/STLabs/State/blob/master/LICENSE).
