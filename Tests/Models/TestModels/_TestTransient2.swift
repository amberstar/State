/************************************************

        WARNING: MACHINE GENERATED FILE

 ************************************************/
import Foundation
import State

public struct TestTransient2 : Model {
    public var transient2: Int?
    public var transient1: String?
    public var myNonTransient: Gender?

}

extension TestTransient2 : Decodable {

   public static func decode(decoder: Decoder) -> TestTransient2? {
      return self.init(decoder: decoder)
   }

    public init?(decoder d: Decoder) {
        var decoder = d
        decoder = TestTransient2.performMigrationIfNeeded(decoder)

        let myNonTransient: Gender? = decoder.decode("myNonTransient")

        self.myNonTransient = myNonTransient
        didFinishDecodingWithDecoder(decoder)
    }
}

extension TestTransient2 : Encodable {

    public func encode(encoder: Encoder) {
        encoder.encode(myNonTransient, "myNonTransient")

        TestTransient2.encodeVersionIfNeeded(encoder)

        self.willFinishEncodingWithEncoder(encoder)
    }
}

extension TestTransient2 {

    /// These are provided from the data model designer
    /// and can be used to determine if the model is
    /// a different version.
    public static func modelVersionHash() -> String {
        return "<3bdb5dca 2d9104fe d8d34881 3d5e8518 763ba9eb 44d3c0b4 c57a65ec 1c4e4924>"
    }

    public static func modelVersionHashModifier() -> String? {
        return nil
    }
}

extension KVStore {

   public func getTestTransient2(key: String) -> TestTransient2? {
      return getValue(key)
   }

   public func getTestTransient2(key: String, defaultValue: TestTransient2) -> TestTransient2 {
      return getValue(key) ?? defaultValue
   }

   public func getTestTransient2s(key: String) -> [TestTransient2]? {
      return getValue(key)
   }

   public func getTestTransient2s(key: String, defaultValue: [TestTransient2]) -> [TestTransient2] {
      return getValue(key) ?? defaultValue
   }
}

