#Transformables

STState uses a Key-Value coding process. This means all types must be codeable to key-value dictionaries. A transformable is a type that can be transformed to and from a codeable type before and after decoding using a `ValueTransform`. By implementing a `ValueTransform` for a type it allows non-model complex types to participate in serialization. 



```swift
public protocol ValueTransform {
    typealias ValueType
    typealias TransformedType
    
    static  func transform(value: ValueType?) -> TransformedType?
    static  func reverseTransform(value: AnyObject?) -> ValueType?
}

```

###Example
For example, how would a UIColor be represented as Key-Value data? Here we have ValueTransform for UIColor that converts it to a dictionary of String : CGFloat Key-Value data, so that it can be serialized. 

```swift
public final class UIColorTransform: ValueTransform {
    public typealias ValueType = UIColor
    public typealias TransformedType = [String : CGFloat]
    
    public static func  transform(value: ValueType?) -> TransformedType? {
        if let color = value {
            var colorValues = [String : CGFloat]()
            var red, green, blue, alpha  : CGFloat
            red = 0; green = 0; blue = 0; alpha = 0
            color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
            colorValues["red"] = red
            colorValues["green"] = green
            colorValues["blue"] = blue
            colorValues["alpha"] = alpha
            return colorValues
        }
        return nil
    }
    
    public static func reverseTransform(value: AnyObject?) -> ValueType? {
        if let colorValues = value as? [String : CGFloat],
        red = colorValues["red"], green = colorValues["green"], blue = colorValues["blue"], alpha = colorValues["alpha"]{
            return UIColor(red: red, green: green, blue: blue, alpha: alpha)
        }
        return nil
    }
}

```

### The following ValueTransforms are included with STState
* UIColorTransform
* UInt64Transform
* URLTransform
* DessolverTransform
