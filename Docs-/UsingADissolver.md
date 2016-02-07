# Using a Dissolver

State has support for `ValueTransforms`.  The model layer can use a `ValueTransform` to convert arbitrary types to a format compatible with the coding process. For example a `UIColor` can be transformed to an RGBA value using a `UIColorTransform` provided with the library.

```swift
public protocol ValueTransform {
    typealias ValueType
    typealias TransformedType
    typealias DecodedType
    
    static func apply(value: ValueType?) -> TransformedType?
    static func reverse(value: DecodedType?) -> ValueType?
}
```


Suppose we have a collection in the model layer that we do not want to be optional, however we do not want to persist it if it is empty? We can use a `Dissolver` to handle this.

A `Dissolver` is a `ValueTransform` that converts an empty `Monoid` `CollectionType` to nil before encoding, and from nil to empty upon decoding. The result is  empty collections do not get persisted, but get re-created upon decoding.

Suppose we have an `Item`, which can have `Attributes`. 

```swift
public struct Item : Model  {
   var name : String { get set }
   var attributes : [String : AnyObject] { get set }
}
```

`Item` may or may not have attributes, but we do not want to make attributes optional , we just do not want to persist an empty set of attributes.

```swift
extension Item : Encodable {
    public func encode(encoder: Encoder) {
       // apply the attributes collection to the Dissolver.apply function.
        encoder.encode(attributes >>> Dissolver.apply, "attributes")
        encoder.encode(name, "name")
    }
}
extension Item : Decodable {
    public init?(var decoder: Decoder) {
        guard let name: String = decoder.decode("name") else { return  nil }
        // reverse the dissolve
        self.attributes = decoder.decode("Attributes") >>> Dissolver.reverse
        self.name = name
    }
}
```

If the item has attributes, it will be encoded, but if attributes is empty, nothing will be encoded. Upon decoding, if attributes exist they are decoded, but if they don't (or if they fail to decode) an empty collection is realized.

Dissolvers are not for every situation, but if you don't mind silent failure, or do not want to have an optional they are useful.

Note: If you are using the Xcode data modeler with State, the code above is generated automatically. You set the transform in the data modeler itself.
