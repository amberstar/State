



// Turns an empty collection into nil, and vice versa

public final class DissolverTransform<T: protocol<Monoid, CollectionType>>: ValueTransform {
    public typealias ValueType = T
    public typealias TransformedType = T
    
    public static func  transform(value: ValueType?) -> TransformedType? {
        if let value = value where value.count > 0 {
            return value
        }
        return nil
    }
    
    public static func reverseTransform(value: AnyObject?) -> ValueType? {
        if let value = value as? T {
            return value
        }
        return T.mempty
    }
}