public protocol ValueTransform {
    typealias ValueType
    typealias TransformedType
    typealias DecodedType
    
    static  func apply(value: ValueType?) -> TransformedType?
    static  func reverse(value: DecodedType?) -> ValueType?
}