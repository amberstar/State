import Foundation

extension NSURL : Encodable, Decodable {
   
   public static func decode(decoder: Decoder) -> Self? {
      if let value : String  = decoder.decode("URL") {
          return self.init(string: value)
      }
      else {
         return nil
      }
   }
   
   public func encode(encoder: Encoder) {
      encoder.encode(self.absoluteString, "URL")
   }
}