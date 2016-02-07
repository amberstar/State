# Using Protocols


State is built with a protocol oriented design. This allows you to extend models by extending each model type, and now also extend all of them by extending the `Model` protocol itself. 

State has native support for protocols in the model layer itself. What does native protocol support mean in a model framework? Protocol support allows you to model protocols just like any other model type, compose them, and serialize them. 

Here are a few of the highlights to using protocols with State:

* Protocols can inherit from other protocols
* Protocol requirements can be other model items
* Model items can compose with protocols and vice versa
* ==Protocol compositions can be serialized and de-serialized  ==

The last item on that list is a bit tricky. How can we serialize and deserialize some unknown type that is a conformer to a protocol? Let's go through a few examples to see how State handles this.

Let's say we have a model item, `Company`. `Company` has `Employees`. So the model item `Company` has a collection of `Employee` types.`Employee` is a protocol. So we say, "The model type Company composes the protocol Employee".  `Managers`, `Engineers`, and `SalesPeople` are all conforming model types of `Employee`. 

`Company` has a collection of `Employee` types because it has a one-to-many relationship to them. What happens when you serialize out `Company` that contains `Employees`? What happens when you try to de-serialize them back in? How will the decoder know what each conforming model type is, and how will it be able to instantiate the correct conforming model type, and compose it into the collection of `Companies`  `Employee` types?

It turns out this is a common situation. So common that I decided to build this capability in to State. The answer is State handles all of this automatically, but let's take a closer look.

Let's look at another example. Here is an example model design of an Asset Library. `Asset` is a protocol.  `FileAsset` is a protocol that inherits from `Asset`. AssetGroup has a one-to-many relationship to the `Asset` protocol. `ColorAsset`, `ImageAsset`, and `SoundAsset` are all conforming to the `Asset` protocol.

![](/resources/protocol_2.png)

Any one of the conforming types can be added to the `AssetGroup`'s assets collection. When you serialize the model out, and back, each type is restored. 
```swift
// create two assets
let colorAsset = ColorAsset(red: 0, alpha: 1, name: "BlackColor", blue: 0, green: 0, type:.Color)
let soundAsset = SoundAsset(name: "test Asset", path:"this is a test", type:.Sound)

// add the assets
assetLibrary.addAsset("Test.Domain", group: "TestGroup", asset: colorAsset)
assetLibrary.addAsset("Test.Domain", group: "TestGroup", asset: soundAsset)

// save the asset library to a plist file
assetLibrary.save(.Plist, path: "testAsset.plist")

// Read the model back in
let inAssetLibrary = AssetLibrary(.Plist, path: "testAsset.plist")

// fetch the color asset
let inColorAsset = assetLibrary.fetchAsset("asset://Test.Domain/TestGroup/BlackColor")
```

How does this work? How does the decoder know what type to create from the data being deserialized? When a conforming type is encoded to a file a model type key is added to the encoded data: 
```swift
// Note: All of this code is generated automatically by the State Framework code generator. 
extension ColorAsset : Encodable {
    public func encode(encoder: Encoder) {
        encoder.encode(red, "red")
        encoder.encode(alpha, "alpha")
        encoder.encode(name, "name")
        encoder.encode(blue, "blue")
        encoder.encode(green, "green")
        encoder.encode(type, "type")

        // encode model type
        encoder.encode("ColorAsset", model_type_key)
        
        ColorAsset.encodeVersionIfNeeded(encoder)
        self.willFinishEncodingWithEncoder(encoder)
    }
}
```
When State generates the code for the protocol, it searches for conforming types and generates a type lookup function that returns a type: 

```swift
private func AssetTypeForKey(key: String) -> Asset.Type? {
    switch key {
    case "ColorAsset":
        return ColorAsset.self
    case "SoundAsset":
        return SoundAsset.self
    case "ImageAsset":
        return ImageAsset.self
    default:
        return nil
    }
}
```
An extension on the decoder is generated for decoding conforming types to the protocol:

```swift
public func decodeAsset(key: String) -> Asset? {
    let data = self.extractData()
    let d = data[key] as? [String : AnyObject]
    return d.flatMap(_decodeAsset)
}

private func _decodeAsset(data: [String : AnyObject]) -> Asset? {
    guard let dataTypeKey = data[model_type_key] as? String else { return nil }

    // call the type lookup function with the model type key
    if let t = AssetTypeForKey(dataTypeKey) {
        return t.init(decoder: Decoder(data: data))
    }
    return nil
}
```

The protocol plays the role of a type `stub`, looking up the type and initiating the decoding on the conforming type.

Protocol support in State now means being able to generate model code quickly and still take advantage of Swift's protocols. 
