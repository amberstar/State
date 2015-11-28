public protocol ValueTransform {
    typealias ValueType
    typealias TransformedType
    typealias DecodedType
    
    static  func transform(value: ValueType?) -> TransformedType?
    static  func reverseTransform(value: DecodedType?) -> ValueType?
}