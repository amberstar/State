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

   public static func decode(decoder: Decoder) -> TestProtocolContainter? {
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
        didFinishDecodingWithDecoder(decoder)
    }
}

extension TestProtocolContainter : Encodable {

    public func encode(encoder: Encoder) {
        encoder.encode(testProtocol, "testProtocol")
        encoder.encode(testProtocols, "testProtocols")
        encoder.encode(testProtocolsDict, "testProtocolsDict")

        TestProtocolContainter.encodeVersionIfNeeded(encoder)

        self.willFinishEncodingWithEncoder(encoder)
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

extension NSUserDefaults {

   //****************************************************************************//
   // MARK: NSUserDefault Getters
   //****************************************************************************//

   public func getTestProtocolContainter(key: String) -> TestProtocolContainter? {
      guard let dictionary = dictionaryForKey(key) else { return nil }
      return TestProtocolContainter.decode(dictionary)
   }

   public func getTestProtocolContainter(key: String) -> [TestProtocolContainter]? {
      guard let array = arrayForKey(key) else { return nil }
      return sequence(array.map(TestProtocolContainter.decode))
   }

   public func getTestProtocolContainter(key: String) -> [String : TestProtocolContainter]? {
      guard let dictionary = dictionaryForKey(key) else { return nil }
      return sequence(dictionary.map { TestProtocolContainter.decode($0) })
   }

   public func getTestProtocolContainter(key: String, defaultValue: TestProtocolContainter) -> TestProtocolContainter {
      return getTestProtocolContainter(key) ?? defaultValue
   }

   public func getTestProtocolContainter(key: String, defaultValue: [TestProtocolContainter]) -> [TestProtocolContainter] {
      return getDecodable(key) ?? defaultValue
   }

   public func getTestProtocolContainter(key: String,  defaultValue: [String : TestProtocolContainter]
   ) -> [String : TestProtocolContainter] {
      return getTestProtocolContainter(key) ?? defaultValue
   }

   //****************************************************************************//
   // MARK: NSUserDefault Setters
   //****************************************************************************//

   public func setTestProtocolContainter(value: TestProtocolContainter, forKey key: String) {
      setObject(value.encode(), forKey: key)
   }

   public func setTestProtocolContainter(value: [TestProtocolContainter], forKey key: String) {
      setObject(value.map { $0.encode() }, forKey: key)
   }

   public func setTestProtocolContainter(value: [String : TestProtocolContainter], forKey key: String) {
      setObject(value.map { $0.encode() }, forKey: key)
   }
}

extension KVStore {

   public func getTestProtocolContainter(key: String) -> TestProtocolContainter? {
      return getValue(key)
   }

   public func getTestProtocolContainter(key: String, defaultValue: TestProtocolContainter) -> TestProtocolContainter {
      return getTestProtocolContainter(key) ?? defaultValue
   }

   public func getTestProtocolContainters(key: String) -> [TestProtocolContainter]? {
      return getValue(key)
   }

   public func getTestProtocolContainters(key: String, defaultValue: [TestProtocolContainter]) -> [TestProtocolContainter] {
      return getTestProtocolContainters(key) ?? defaultValue
   }

   public func getTestProtocolContainterDictionary(key: String) -> [String : TestProtocolContainter]? {
      return getValue(key)
   }

   public func getTestProtocolContainterDictionary(key: String, defaultValue: [String : TestProtocolContainter]) -> [String : TestProtocolContainter] {
      return getTestProtocolContainterDictionary(key) ?? defaultValue
   }
}

