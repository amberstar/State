#State

State is a light weight model framework written in pure Swift that uses `structs` and `enums` for the model layer. Models are defined just like with Core Data, using [Xcode's Core Data model design tool](https://developer.apple.com/library/ios/recipes/xcode_help-core_data_modeling_tool/Articles/about_cd_modeling_tool.html#//apple_ref/doc/uid/TP40010379-CH3-SW1). Model code is  generated automatically using [Mogenerator](https://github.com/rentzsch/mogenerator). You can extend the models with an extension. The model code provides serialization to and from Plists, JSON, or Binary.
                                                                                                                                                                                                                                                   
####Key Features: 

- Design Models just like Core Data, in the Model Designer
- Model code generated automatically
- Struct and Enum models 
- Immutable, optional, and non-optional properties.
- Read and write models to and from JSON, Plists, and Binary 
- Model versioning and migration management (Optional)
- Models are not subclasses


Easy serialization is provided using `protocol extensions`:


```swift
// JSON
model.toJSON("model.json")

let loadedIssues =  model.fromJSON("issues.json")

// Plist
model.toPlist("model.plist")

let model = model.fromPlist("issues.plist")
```


### [ Read the Documentation To Get Started](Docs/)


##System Requirements
- Swift 2.0
- Xcode 7.0
- iOS 8.0
- Mogenerator 1.28

## License

State is released under the MIT license. See
[LICENSE.md](https://github.com/STLabs/State/blob/master/LICENSE).
