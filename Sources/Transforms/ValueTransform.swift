public protocol ValueTransform {
    associatedtype ValueType
    associatedtype TransformedType
    associatedtype DecodedType
    
    static  func apply(value: ValueType?) -> TransformedType?
    static  func reverse(value: DecodedType?) -> ValueType?
}