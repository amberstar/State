# Creating Enum Models


Enumerations are first-class types in Swift. Without good support for enumerations in a model framework, you wouldn't be able to take advantage of this powerful aspect of Swift. 

Let's define an enum.

```swift
public enum Temperature {
    case Cold
    case Hot
}
```

######Creating a model
To create a model we have to implement the `Model` protocol. The `Model` protocol has no requirements, but inherits from `Decodable`, `Encodable`, and `Migratable`.

```swift
public protocol Model : Decodable, Encodable, Migratable {}
```

Let's declare Temperature as a model:
```swift
public enum Temperature : Model {
    case Cold
    case Hot
}
```

`Encodable` has one requirement `func encode(encoder: Encoder)`  here we will encode the case name as the value and the string "type" as the key.:

```swift
extension Temperature : Encodable {
    public func encode(encoder: Encoder) {
        switch self {
            case .Cold:
                encoder.encode("Cold", "type")
            case .Hot:
                encoder.encode("Hot", "type")
        }
    }
}
```

`Decodable` has one requirement `init?(decoder: Decoder)` a failable initializer. Here we will decode the string we encoded earlier and match the value in a switch statement: 

```swift
extension Temperature : Decodable {
    public init?(decoder: Decoder) {
        guard let type: String = decoder.decode("type") else { return nil }
        switch type {
            case "Cold":
                self = .Cold
            case "Hot":
                self = .Hot
            default:
                return nil
        }
    }
}
```


`Migratable` is a protocol that provides migration and version management. It gives models the ability to check it's version before decoding to see if it's the current version, and migrate  if needed. If we don't want to support migration and versioning of our model we do not have to do anything at this point, because the `Migratable` protocol provides a default implementation that disables migration. For the purposes of this article we will skip migration, and I will cover it in another article. Just remember, this model is complete without migration because migration is opt-in only.

#####Serializing the model
Instances of Temperature can now be saved to a file and re-initialized from the file:

```swift
// create an instance of Temperature.
let myTemperature = Temperature.Hot
// save to JSON file
myTemperature.save(.JSON, "myTemperatureFile.json")
// init from file
let myFileTemperature = Temperature(.JSON, "myTemperatureFile.json")
```

###### Associated Values
Enumerations can have associated values too.  Let's add a temperature value to our enum.

```swift
<pre><code class="swift"> public enum Temperature : Model {
    case Cold (Double)
    case Hot (Double)
}
```

We have to update our `Encodable` extension. First we update the switch case statements to match on the associated value, and to encode the value in the case:

```swift
extension Temperature : Encodable {
    public func encode(encoder: Encoder) {
        switch self {
            case let .Cold(value):
                encoder.encode("Cold", "type")
                encoder.encode(value, "value")
            case .Hot(value):
                encoder.encode("Hot", "type")
                encoder.encode(value, "value")
        }
    }
}
```

The `Decodable` extension is updated. We added a guard statement to decode the associated value, and we then use the value when we assign to self.

```swift
extension Temperature : Decodable {
    public init?(decoder: Decoder) {
        guard let type: String = decoder.decode("type"), let value: Double = decoder.decode("value") else { return nil }
        switch type {
            case "Cold":
                self = .Cold(value)
            case "Hot":
                self = .Hot(value)
            default:
                return nil
        }
    }
}
```

###### Raw Values
As an alternative to associated values, enumerations can have raw values. The enum is declared with a type and each case has a default value.  Let's change our Temperature enum to a raw value enum.

```swift 
public enum Temperature : Double, Model {
    case Freeze = 32.0
    case Boil = 212.0
}
```

The code to encode and decode raw value enums becomes even simpler because all we have to be concerned with is the raw value itself.

```swift
extension Temperature : Encodable {
    public func encode(encoder: Encoder) {
        encoder.encode(self.rawValue, "value")
    }
}
```

```swift
extension Temperature : Decodable {
    public init?(decoder: Decoder) {
        guard let value: Double = decoder.decode("value") else { return nil }
        self.init(rawValue: value)
    }
}
```

As you can see implementing enumeration models using State is very straightforward. 

A few things to note:

* Model types can compose(have as properties) enum models
* Enums can have associated and raw values and those values can be other model types.
* If you are designing your model layer using State's Xcode data model design support, you can model enums right in the data model design tool. (for more information see: [Enum Design Guide](https://github.com/STLabs/State/blob/master/Docs/Enums.md))

