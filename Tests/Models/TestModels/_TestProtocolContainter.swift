/************************************************

        WARNING: MACHINE GENERATED FILE

 ************************************************/
import Foundation
import State

public struct TestProtocolContainter : Model {
    public var testProtocol: TestProtocol
    public var testProtocols: [TestParentProtocol]
    public var testProtocolsDict: [String : TestParentProtocol]

}

extension TestProtocolContainter : Decodable {

   public static func decode(_ decoder: Decoder) -> TestProtocolContainter? {
      return self.init(decoder: decoder)
   }

    public init?(decoder d: Decoder) {
        var decoder = d
        decoder = TestProtocolContainter.performMigrationIfNeeded(decoder)

         guard
            let testProtocol: TestProtocol = decoder.decodeTestProtocol("testProtocol"),
            let testProtocols: [TestParentProtocol] = decoder.decodeTestParentProtocol("testProtocols"),
            let testProtocolsDict: [String : TestParentProtocol] = decoder.decodeTestParentProtocol("testProtocolsDict")
         else { return  nil }

        self.testProtocol = testProtocol
        self.testProtocols = testProtocols
        self.testProtocolsDict = testProtocolsDict
        didFinishDecoding(decoder: decoder)
    }
}

extension TestProtocolContainter : Encodable {

    public func encode(_ encoder: Encoder) {
        encoder.encode(testProtocol, "testProtocol")
        encoder.encode(testProtocols, "testProtocols")
        encoder.encode(testProtocolsDict, "testProtocolsDict")

        TestProtocolContainter.encodeVersionIfNeeded(encoder)

        self.willFinishEncoding(encoder: encoder)
    }
}

extension TestProtocolContainter {

    /// These are provided from the data model designer
    /// and can be used to determine if the model is
    /// a different version.
    public static func modelVersionHash() -> String {
        return "<c17d56f9 43a9a5b4 345e3428 ed93f4be ca40e0e9 976d037a 6ad6110c db0ae714>"
    }

    public static func modelVersionHashModifier() -> String? {
        return nil
    }
}

//****************************************************************************//
// MARK: UserDefaults support
//****************************************************************************//
extension UserDefaults {

   public func getTestProtocolContainter(forKey key: String) -> TestProtocolContainter? {
      guard let dictionary = dictionary(forKey: key) else { return nil }
      return TestProtocolContainter.decode(dictionary)
   }

   public func getTestProtocolContainter(forKey key: String) -> [TestProtocolContainter]? {
      guard let array = array(forKey: key) else { return nil }
      return sequence(array.map(TestProtocolContainter.decode))
   }

   public func getTestProtocolContainter(forKey key: String) -> [String : TestProtocolContainter]? {
      guard let dictionary = dictionary(forKey: key) else { return nil }
      return sequence(dictionary.map { TestProtocolContainter.decode($0) })
   }

   public func getTestProtocolContainter(forKey key: String, defaultValue: TestProtocolContainter) -> TestProtocolContainter {
      return getTestProtocolContainter(forKey: key) ?? defaultValue
   }

   public func getTestProtocolContainter(forKey key: String, defaultValue: [TestProtocolContainter]) -> [TestProtocolContainter] {
      return getDecodable(key) ?? defaultValue
   }

   public func getTestProtocolContainter(forKey key: String,  defaultValue: [String : TestProtocolContainter]) -> [String : TestProtocolContainter] {
      return getTestProtocolContainter(forKey: key) ?? defaultValue
   }

   public func setTestProtocolContainter(value: TestProtocolContainter, forKey key: String) {
      set(value.encode(), forKey: key)
   }

   public func setTestProtocolContainter(value: [TestProtocolContainter], forKey key: String) {
      set(value.map { $0.encode() }, forKey: key)
   }

   public func setTestProtocolContainter(value: [String : TestProtocolContainter], forKey key: String) {
      set(value.map { $0.encode() }, forKey: key)
   }
}

//****************************************************************************//
// MARK: KVStore support
//****************************************************************************//
extension KVStore {

   public func getTestProtocolContainter(forKey key: String) -> TestProtocolContainter? {
      return getValue(forKey: key)
   }

   public func getTestProtocolContainter(forKey key: String, defaultValue: TestProtocolContainter) -> TestProtocolContainter {
      return getTestProtocolContainter(forKey: key) ?? defaultValue
   }

   public func getTestProtocolContainters(forKey key: String) -> [TestProtocolContainter]? {
      return getValue(forKey: key)
   }

   public func getTestProtocolContainters(forKey key: String, defaultValue: [TestProtocolContainter]) -> [TestProtocolContainter] {
      return getTestProtocolContainters(forKey: key) ?? defaultValue
   }

   public func getTestProtocolContainterDictionary(forKey key: String) -> [String : TestProtocolContainter]? {
      return getValue(forKey: key)
   }

   public func getTestProtocolContainterDictionary(forKey key: String, defaultValue: [String : TestProtocolContainter]) -> [String : TestProtocolContainter] {
      return getTestProtocolContainterDictionary(forKey: key) ?? defaultValue
   }
}

