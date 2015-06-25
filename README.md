#State

State is a light weight model framework written in Swift that uses structs for your model layer. You design models just like you do with Core Data, using [Xcode's Core Data model design tool](https://developer.apple.com/library/ios/recipes/xcode_help-core_data_modeling_tool/Articles/about_cd_modeling_tool.html#//apple_ref/doc/uid/TP40010379-CH3-SW1). Model code is  generated automatically using [Mogenerator](https://github.com/rentzsch/mogenerator) and provides serialization to and from Plists, XML Plists, or JSON.
                                                                                                                                                                                                                                                   
####Key Features: 

- Design Models just Like Core Data, in the Model Designer
- Model code generated automatically
- Struct and Enum models 
- Immutable, Optional, and Non-Optional properties.
- Read and Write Models to and from JSON, Plists, and Binary 
- Model versioning and migration management (Optional)
- no subclassing required





```swift
// JSON
model.toJSON("model.json")

let loadedIssues =  model.fromJSON("issues.json")

// Plist
model.toPlist("model.plist")

let model = model.fromPlist("issues.plist")
```


## Get Started
### [ Read the Documentation](Docs/)


##System Requirements
- Swift 2.0
- Xcode 7.0
- iOS 8.0
- Mogenerator 1.28

## License

State is released under the MIT license. See
[LICENSE.md](https://github.com/STLabs/State/blob/master/LICENSE).
