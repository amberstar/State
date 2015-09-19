#State

A Swift model framework that supports `structs`, `enums` and `protocols` in the model layer. Models are defined just like with Core Data, using [Xcode's Core Data model design tool](https://developer.apple.com/library/ios/recipes/xcode_help-core_data_modeling_tool/Articles/about_cd_modeling_tool.html#//apple_ref/doc/uid/TP40010379-CH3-SW1). Model code is  generated automatically using [Mogenerator](https://github.com/rentzsch/mogenerator). The framework provides serialization to and from Plists, JSON, or Binary.
                                                                                                                                                                                                                                                   
####Features: 

- Design Models just like Core Data, in the Xcode model designer
- Model code generated automatically
- Struct, Enum (including associated types), and Protocol model types supported.
- Use immutable, optional, and non-optional properties
- Read and write models to and from JSON, Plists, and Binary 
- Model versioning and migration management (optional)

## Protocol Oriented
State has a protocol oriented design with extension points to extend all of your models.
Model items can compose with protocol types with full serialization support.

![<Protocol Oriented>](Docs/Resources/diag2.png)

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
![<Protocol Oriented>](Docs/Resources/diag4.png)
# [ Read the Documentation to Get Started](Docs/)

##System Requirements
- Swift 2.0
- Xcode 7.0
- iOS 8.0
- Mogenerator 1.28

## License

State is released under the MIT license. See
[LICENSE.md](https://github.com/STLabs/State/blob/master/LICENSE).
