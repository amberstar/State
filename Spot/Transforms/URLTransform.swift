public final class URLTransform: ValueTransform {
    public typealias ValueType = NSURL
    public typealias TransformedType = String
    
    public static func  transform(value: ValueType?) -> TransformedType? {
        if let URL = value {
            return URL.absoluteString
        }
        return nil
    }
    
    public static func reverseTransform(value: AnyObject?) -> ValueType? {
        if let URLString = value as? String {
            return NSURL(string: URLString)
        }
        return nil
    }
}