/************************************************

        WARNING: MACHINE GENERATED FILE

 ************************************************/
import Foundation
import State

public struct TestDefaultsChild : Model {
    public var name = "New Child"

}

extension TestDefaultsChild : Decodable {

   public static func decode(_ decoder: Decoder) -> TestDefaultsChild? {
      return self.init(decoder: decoder)
   }

    public init?(decoder d: Decoder) {
        var decoder = d
        decoder = TestDefaultsChild.performMigrationIfNeeded(decoder)

         guard
            let name: String = decoder.decode("name")
         else { return  nil }

        self.name = name
        didFinishDecodingWithDecoder(decoder)
    }
}

extension TestDefaultsChild : Encodable {

    public func encode(_ encoder: Encoder) {
        encoder.encode(name, "name")

        TestDefaultsChild.encodeVersionIfNeeded(encoder)

        self.willFinishEncodingWithEncoder(encoder)
    }
}

extension TestDefaultsChild {

    /// These are provided from the data model designer
    /// and can be used to determine if the model is
    /// a different version.
    public static func modelVersionHash() -> String {
        return "<6b3afe9f ee54b7fc e944c82f 03ec6569 96cbe98a c3f4b991 13e91cf9 2abea4f9>"
    }

    public static func modelVersionHashModifier() -> String? {
        return nil
    }
}

//****************************************************************************//
// MARK: UserDefaults support
//****************************************************************************//
extension UserDefaults {

   public func getTestDefaultsChild(forKey key: String) -> TestDefaultsChild? {
      guard let dictionary = dictionary(forKey: key) else { return nil }
      return TestDefaultsChild.decode(dictionary)
   }

   public func getTestDefaultsChild(forKey key: String) -> [TestDefaultsChild]? {
      guard let array = array(forKey: key) else { return nil }
      return sequence(array.map(TestDefaultsChild.decode))
   }

   public func getTestDefaultsChild(forKey key: String) -> [String : TestDefaultsChild]? {
      guard let dictionary = dictionary(forKey: key) else { return nil }
      return sequence(dictionary.map { TestDefaultsChild.decode($0) })
   }

   public func getTestDefaultsChild(forKey key: String, defaultValue: TestDefaultsChild) -> TestDefaultsChild {
      return getTestDefaultsChild(forKey: key) ?? defaultValue
   }

   public func getTestDefaultsChild(forKey key: String, defaultValue: [TestDefaultsChild]) -> [TestDefaultsChild] {
      return getDecodable(key) ?? defaultValue
   }

   public func getTestDefaultsChild(forKey key: String,  defaultValue: [String : TestDefaultsChild]
   ) -> [String : TestDefaultsChild] {
      return getTestDefaultsChild(forKey: key) ?? defaultValue
   }

   public func setTestDefaultsChild(value: TestDefaultsChild, forKey key: String) {
      set(value.encode(), forKey: key)
   }

   public func setTestDefaultsChild(value: [TestDefaultsChild], forKey key: String) {
      set(value.map { $0.encode() }, forKey: key)
   }

   public func setTestDefaultsChild(value: [String : TestDefaultsChild], forKey key: String) {
      set(value.map { $0.encode() }, forKey: key)
   }
}

//****************************************************************************//
// MARK: KVStore support
//****************************************************************************//
extension KVStore {

   public func getTestDefaultsChild(forKey key: String) -> TestDefaultsChild? {
      return getValue(forKey: key)
   }

   public func getTestDefaultsChild(forKey key: String, defaultValue: TestDefaultsChild) -> TestDefaultsChild {
      return getTestDefaultsChild(forKey: key) ?? defaultValue
   }

   public func getTestDefaultsChilds(forKey key: String) -> [TestDefaultsChild]? {
      return getValue(forKey: key)
   }

   public func getTestDefaultsChilds(forKey key: String, defaultValue: [TestDefaultsChild]) -> [TestDefaultsChild] {
      return getTestDefaultsChilds(forKey: key) ?? defaultValue
   }

   public func getTestDefaultsChildDictionary(forKey key: String) -> [String : TestDefaultsChild]? {
      return getValue(forKey: key)
   }

   public func getTestDefaultsChildDictionary(forKey key: String, defaultValue: [String : TestDefaultsChild]) -> [String : TestDefaultsChild] {
      return getTestDefaultsChildDictionary(forKey: key) ?? defaultValue
   }
}

