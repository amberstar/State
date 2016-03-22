/************************************************

        WARNING: MACHINE GENERATED FILE

 ************************************************/
import Foundation
import State

public struct TestOverrideType : Model {
    public var myURL: NSURL?
    public var myArrayOfString: [String]?

}

extension TestOverrideType : Decodable {

   public static func decode(decoder: Decoder) -> TestOverrideType? {
      return self.init(decoder: decoder)
   }

    public init?(decoder d: Decoder) {
        var decoder = d
        decoder = TestOverrideType.performMigrationIfNeeded(decoder)

        let myURL: NSURL? = decoder.decode("myURL")
        let myArrayOfString: [String]? = decoder.decode("myArrayOfString")

        self.myURL = myURL
        self.myArrayOfString = myArrayOfString
        didFinishDecodingWithDecoder(decoder)
    }
}

extension TestOverrideType : Encodable {

    public func encode(encoder: Encoder) {
        encoder.encode(myURL, "myURL")
        encoder.encode(myArrayOfString, "myArrayOfString")

        TestOverrideType.encodeVersionIfNeeded(encoder)

        self.willFinishEncodingWithEncoder(encoder)
    }
}

extension TestOverrideType {

    /// These are provided from the data model designer
    /// and can be used to determine if the model is
    /// a different version.
    public static func modelVersionHash() -> String {
        return "<1b2022d4 1d237610 f72665c6 67dea8a1 a68750de df8625c3 d9495017 916e62c6>"
    }

    public static func modelVersionHashModifier() -> String? {
        return nil
    }
}

extension KVStore {

   public func getTestOverrideType(key: String) -> TestOverrideType? {
      return getValue(key)
   }

   public func getTestOverrideType(key: String, defaultValue: TestOverrideType) -> TestOverrideType {
      return getTestOverrideType(key) ?? defaultValue
   }

   public func getTestOverrideTypes(key: String) -> [TestOverrideType]? {
      return getValue(key)
   }

   public func getTestOverrideTypes(key: String, defaultValue: [TestOverrideType]) -> [TestOverrideType] {
      return getTestOverrideTypes(key) ?? defaultValue
   }

   public func getTestOverrideTypeDictionary(key: String) -> [String : TestOverrideType]? {
      return getValue(key)
   }

   public func getTestOverrideTypeDictionary(key: String, defaultValue: [String : TestOverrideType]) -> [String : TestOverrideType] {
      return getTestOverrideTypeDictionary(key) ?? defaultValue
   }
}

