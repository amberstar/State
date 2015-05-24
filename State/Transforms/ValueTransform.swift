public protocol ValueTransform {
    typealias ValueType
    typealias TransformedType
    
    static  func transform(value: ValueType?) -> TransformedType?
    static  func reverseTransform(value: AnyObject?) -> ValueType?
}