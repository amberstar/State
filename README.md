#State
### The world's first protocol oriented, struct based model framework in pure Swift.

State is a light weight model framework written in pure Swift that uses `structs` and `enums` for the model layer. Models are defined just like with Core Data, using [Xcode's Core Data model design tool](https://developer.apple.com/library/ios/recipes/xcode_help-core_data_modeling_tool/Articles/about_cd_modeling_tool.html#//apple_ref/doc/uid/TP40010379-CH3-SW1). Model code is  generated automatically using [Mogenerator](https://github.com/rentzsch/mogenerator). You can extend the models with an extension. The model code provides serialization to and from Plists, JSON, or Binary.
                                                                                                                                                                                                                                                   
####Key Features: 

- Design Models just like Core Data, in the Xcode model designer
- Model code generated automatically
- Struct and Enum models (including associated types)
- Immutable, optional, and non-optional properties.
- Read and write models to and from JSON, Plists, and Binary 
- Model versioning and migration management (optional)
- Models are not subclasses
- Serialization to/from files, NSData, or Strings

## Protocol Oriented
State is implemented as a protocol oriented design giving you powerful extension points to extend all of your models

The migration scheme is implemented as a protocol and extension. When you override these protocol implementations you tap in to the migration features.

Convenient serialization API is provided using the model `protocol extension`, but that is just a start. You can add API to all of your model elements by extending the Model protocol with your own code.


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
