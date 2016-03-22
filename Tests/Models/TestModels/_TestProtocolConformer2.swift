/************************************************

        WARNING: MACHINE GENERATED FILE

 ************************************************/
import Foundation
import State

public struct TestProtocolConformer2 : TestParentProtocol {
    public var name: String
    public var ss_number: String

}

extension TestProtocolConformer2 : Decodable {

   public static func decode(decoder: Decoder) -> TestProtocolConformer2? {
      return self.init(decoder: decoder)
   }

    public init?(decoder d: Decoder) {
        var decoder = d
        decoder = TestProtocolConformer2.performMigrationIfNeeded(decoder)

         guard
            let name: String = decoder.decode("name"),
            let ss_number: String = decoder.decode("ss_number")
         else { return  nil }

        self.name = name
        self.ss_number = ss_number
        didFinishDecodingWithDecoder(decoder)
    }
}

extension TestProtocolConformer2 : Encodable {

    public func encode(encoder: Encoder) {
        encoder.encode(name, "name")
        encoder.encode(ss_number, "ss_number")

        encoder.encode("TestProtocolConformer2", "TestParentProtocol")

        TestProtocolConformer2.encodeVersionIfNeeded(encoder)

        self.willFinishEncodingWithEncoder(encoder)
    }
}

extension TestProtocolConformer2 {

    /// These are provided from the data model designer
    /// and can be used to determine if the model is
    /// a different version.
    public static func modelVersionHash() -> String {
        return "<b03219a4 91869ac1 514d01f7 d3a1fca3 a52a8792 70710403 99f3e557 9da2f273>"
    }

    public static func modelVersionHashModifier() -> String? {
        return nil
    }
}

extension KVStore {

   public func getTestProtocolConformer2(key: String) -> TestProtocolConformer2? {
      return getValue(key)
   }

   public func getTestProtocolConformer2(key: String, defaultValue: TestProtocolConformer2) -> TestProtocolConformer2 {
      return getTestProtocolConformer2(key) ?? defaultValue
   }

   public func getTestProtocolConformer2s(key: String) -> [TestProtocolConformer2]? {
      return getValue(key)
   }

   public func getTestProtocolConformer2s(key: String, defaultValue: [TestProtocolConformer2]) -> [TestProtocolConformer2] {
      return getTestProtocolConformer2s(key) ?? defaultValue
   }

   public func getTestProtocolConformer2Dictionary(key: String) -> [String : TestProtocolConformer2]? {
      return getValue(key)
   }

   public func getTestProtocolConformer2Dictionary(key: String, defaultValue: [String : TestProtocolConformer2]) -> [String : TestProtocolConformer2] {
      return getTestProtocolConformer2Dictionary(key) ?? defaultValue
   }
}

