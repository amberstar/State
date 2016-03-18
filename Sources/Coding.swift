import Foundation

//===----------------------------------------------------------------------===//
//                               Encodable
//===----------------------------------------------------------------------===//

public protocol Encodable {
   func encode(encoder: Encoder)
   func willFinishEncodingWithEncoder(encoder: Encoder)
}

public extension Encodable {
   
   func encode() -> [String : AnyObject] {
      let coder = Encoder()
      self.encode(coder)
      return coder.data
   }
   
   func encodeToFile(converter: Converter.Type, path: String) {
      converter.write(self.encode(), path: path)
   }
   
   /// Called when encoding will finish on the receiver
   ///
   /// - parameter encoder: the encoder used for encoding
   /// - note: This method is called right before encoding finishes.
   /// It provides a chance to encode any further data with the encoder.
   func willFinishEncodingWithEncoder(encoder: Encoder) { }
}

//===----------------------------------------------------------------------===//
//                               Encoder
//===----------------------------------------------------------------------===//

public protocol EncoderType : class {
   var data : [String : AnyObject] { get set }
}

extension EncoderType {
   public func encode<T: Encodable>(value: T?, _ key: String) {
      value.apply { self.data[key] = $0.encode() }
   }
   
   public func encode<T: Encodable>(value: [T]?, _ key: String) {
      value.apply { self.data[key] = $0.map { $0.encode() } }
   }
   
   public func encode<T: Encodable>(value: [String : T]?, _ key: String) {
      value.apply { self.data[key] = $0.map { $0.encode() } }
   }
   
   public func encode<V>(value: V?, _ key: String) {
      value.apply{ self.data[key] = $0 as? AnyObject }
   }
}

public final class Encoder : EncoderType {
   public var data = [String : AnyObject]()
}


//===----------------------------------------------------------------------===//
//                               Decodable
//===----------------------------------------------------------------------===//

public protocol Decodable {
   static func decode(decoder: Decoder) -> Self?
   func didFinishDecodingWithDecoder(decoder: Decoder)
}

public extension Decodable {
   
   public static func decode(data: [String : AnyObject]) -> Self? {
      let decoder = Decoder(data: data)
      return Self.decode(decoder)
   }

   public static func decode(data: AnyObject?) -> Self? {
      
      if let data = data as? [String : AnyObject] {
         return Self.decode(data)
      }
      return nil
   }
   
   public static func decodeFromFile(
      converter: Converter.Type,
      path: String) -> Self? {
      return decode(converter.read(path))
   }
   
   /// decoding is finished on the receiver
   /// - parameter decoder: the decoder used for decoding
   ///
   /// - note: This method is called after decoding takes place.
   /// It provides a way to decode any further data with the decoder
   /// or to do any initialization needed after decoding.
   func didFinishDecodingWithDecoder(decoder: Decoder) {
      
   }
}

//===----------------------------------------------------------------------===//
//                               Decoder
//===----------------------------------------------------------------------===//

public protocol DecoderType {
   var data :[String : AnyObject] { get set }
}

extension DecoderType {
   
   /// decode a decodable element
   /// - parameter key: a dictionary to use for decoding
   /// - returns: return element of type T or nil if decoding failed
   public func decode<T:Decodable>(key: String) -> T? {
      let d = data[key] as? [String : AnyObject]
      return d.flatMap(_decodeDecodable)
   }
   
   /// decode a decodable array of element T
   /// - parameter key: a dictionary to use for decoding
   /// - returns: return an optional array of T or nil 
   /// if decoding failed
   public func decode<T:Decodable>(key: String) -> [T]? {
      let d = data[key] as? [[String : AnyObject]]
      return d.flatMap { sequence($0.map( _decodeDecodable)) }
   }
   
   /// decode a dictionary of string,decodable element T
   /// - parameter key: a dictionary to use for decoding
   /// - returns: return a dictionary of string, element T 
   /// or nil if decoding failed
   public func decode<T: Decodable>(key: String) -> [String : T]? {
      let d = data[key] as? [String : [String : AnyObject]]
      return d.flatMap { sequence($0.map(_decodeDecodable)) }
   }
   
   /// decode a value element V
   /// - parameter key: a dictionary to use for decoding
   /// - returns: return an element V or nil if decoding failed
   public func decode<V>(key: String) -> V? {
      return data[key] as? V
   }
   
   private func _decodeDecodable<T: Decodable>(
      data: [String : AnyObject]) -> T? {
      return T.decode(Decoder(data: data))
   }
}

public final class Decoder : DecoderType {
   public var data = [String : AnyObject]()
   
   /// initialize a new decoder with data
   /// - parameter data: a dictionary to use for decoding
   /// - returns: returns a decoder
   public init(data: [String : AnyObject]) {
      self.data = data
   }
}
