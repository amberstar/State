import Foundation

public final class UInt64Transform: ValueTransform {
    public typealias ValueType = UInt64
    public typealias TransformedType = Int
    
    public static func  apply(value: ValueType?) -> TransformedType? {
        if let uint = value {
            return Int(uint)
        }
        return nil
    }
    
    public static func reverse(value: AnyObject?) -> ValueType? {
        if let int = value as? Int {
            return UInt64(int)
        }
        return nil
    }
}