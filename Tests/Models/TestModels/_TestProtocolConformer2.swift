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

   public static func decode(_ decoder: Decoder) -> TestProtocolConformer2? {
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
        didFinishDecoding(decoder: decoder)
    }
}

extension TestProtocolConformer2 : Encodable {

    public func encode(_ encoder: Encoder) {
        encoder.encode(name, "name")
        encoder.encode(ss_number, "ss_number")

        encoder.encode("TestProtocolConformer2", "TestParentProtocol")

        TestProtocolConformer2.encodeVersionIfNeeded(encoder)

        self.willFinishEncoding(encoder: encoder)
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

//****************************************************************************//
// MARK: UserDefaults support
//****************************************************************************//
extension UserDefaults {

   public func getTestProtocolConformer2(forKey key: String) -> TestProtocolConformer2? {
      guard let dictionary = dictionary(forKey: key) else { return nil }
      return TestProtocolConformer2.decode(dictionary)
   }

   public func getTestProtocolConformer2(forKey key: String) -> [TestProtocolConformer2]? {
      guard let array = array(forKey: key) else { return nil }
      return sequence(array.map(TestProtocolConformer2.decode))
   }

   public func getTestProtocolConformer2(forKey key: String) -> [String : TestProtocolConformer2]? {
      guard let dictionary = dictionary(forKey: key) else { return nil }
      return sequence(dictionary.map { TestProtocolConformer2.decode($0) })
   }

   public func getTestProtocolConformer2(forKey key: String, defaultValue: TestProtocolConformer2) -> TestProtocolConformer2 {
      return getTestProtocolConformer2(forKey: key) ?? defaultValue
   }

   public func getTestProtocolConformer2(forKey key: String, defaultValue: [TestProtocolConformer2]) -> [TestProtocolConformer2] {
      return getDecodable(key) ?? defaultValue
   }

   public func getTestProtocolConformer2(forKey key: String,  defaultValue: [String : TestProtocolConformer2]) -> [String : TestProtocolConformer2] {
      return getTestProtocolConformer2(forKey: key) ?? defaultValue
   }

   public func setTestProtocolConformer2(value: TestProtocolConformer2, forKey key: String) {
      set(value.encode(), forKey: key)
   }

   public func setTestProtocolConformer2(value: [TestProtocolConformer2], forKey key: String) {
      set(value.map { $0.encode() }, forKey: key)
   }

   public func setTestProtocolConformer2(value: [String : TestProtocolConformer2], forKey key: String) {
      set(value.map { $0.encode() }, forKey: key)
   }
}

//****************************************************************************//
// MARK: KVStore support
//****************************************************************************//
extension KVStore {

   public func getTestProtocolConformer2(forKey key: String) -> TestProtocolConformer2? {
      return getValue(forKey: key)
   }

   public func getTestProtocolConformer2(forKey key: String, defaultValue: TestProtocolConformer2) -> TestProtocolConformer2 {
      return getTestProtocolConformer2(forKey: key) ?? defaultValue
   }

   public func getTestProtocolConformer2s(forKey key: String) -> [TestProtocolConformer2]? {
      return getValue(forKey: key)
   }

   public func getTestProtocolConformer2s(forKey key: String, defaultValue: [TestProtocolConformer2]) -> [TestProtocolConformer2] {
      return getTestProtocolConformer2s(forKey: key) ?? defaultValue
   }

   public func getTestProtocolConformer2Dictionary(forKey key: String) -> [String : TestProtocolConformer2]? {
      return getValue(forKey: key)
   }

   public func getTestProtocolConformer2Dictionary(forKey key: String, defaultValue: [String : TestProtocolConformer2]) -> [String : TestProtocolConformer2] {
      return getTestProtocolConformer2Dictionary(forKey: key) ?? defaultValue
   }
}

