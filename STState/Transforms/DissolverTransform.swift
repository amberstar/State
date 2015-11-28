



// Turns an empty collection into nil, and vice versa

public final class DissolverTransform<T: protocol<Monoid, CollectionType>>: ValueTransform {
    public typealias ValueType = T
    public typealias TransformedType = ValueType
    public typealias DecodedType = ValueType
    
    public static func  transform(value: ValueType?) -> TransformedType? {
        if let value = value where value.count > 0 {
            return value
        }
        return nil
    }
    
    public static func reverseTransform(value: DecodedType?) -> ValueType? {
        if let value = value {
            return value
        }
        return T.mempty
    }
}