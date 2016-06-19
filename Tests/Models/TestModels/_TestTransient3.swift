/************************************************

        WARNING: MACHINE GENERATED FILE

 ************************************************/
import Foundation
import State

public struct TestTransient3 : Model {
    public var myNonTransient1: Double?
    public var myNonTransient2: String?
    public var myTransientRelationship: Gender?

}

extension TestTransient3 : Decodable {

   public static func decode(_ decoder: Decoder) -> TestTransient3? {
      return self.init(decoder: decoder)
   }

    public init?(decoder d: Decoder) {
        var decoder = d
        decoder = TestTransient3.performMigrationIfNeeded(decoder)

        let myNonTransient1: Double? = decoder.decode("myNonTransient1")
        let myNonTransient2: String? = decoder.decode("myNonTransient2")

        self.myNonTransient1 = myNonTransient1
        self.myNonTransient2 = myNonTransient2
        didFinishDecodingWithDecoder(decoder)
    }
}

extension TestTransient3 : Encodable {

    public func encode(_ encoder: Encoder) {
        encoder.encode(myNonTransient1, "myNonTransient1")
        encoder.encode(myNonTransient2, "myNonTransient2")

        TestTransient3.encodeVersionIfNeeded(encoder)

        self.willFinishEncodingWithEncoder(encoder)
    }
}

extension TestTransient3 {

    /// These are provided from the data model designer
    /// and can be used to determine if the model is
    /// a different version.
    public static func modelVersionHash() -> String {
        return "<05b69b5d 1e7b7b56 3e25a035 1e39a111 32b6a4e5 35fd06b5 f81d5fe0 9fbcf182>"
    }

    public static func modelVersionHashModifier() -> String? {
        return nil
    }
}

//****************************************************************************//
// MARK: UserDefaults support
//****************************************************************************//
extension UserDefaults {

   public func getTestTransient3(forKey key: String) -> TestTransient3? {
      guard let dictionary = dictionary(forKey: key) else { return nil }
      return TestTransient3.decode(dictionary)
   }

   public func getTestTransient3(forKey key: String) -> [TestTransient3]? {
      guard let array = array(forKey: key) else { return nil }
      return sequence(array.map(TestTransient3.decode))
   }

   public func getTestTransient3(forKey key: String) -> [String : TestTransient3]? {
      guard let dictionary = dictionary(forKey: key) else { return nil }
      return sequence(dictionary.map { TestTransient3.decode($0) })
   }

   public func getTestTransient3(forKey key: String, defaultValue: TestTransient3) -> TestTransient3 {
      return getTestTransient3(forKey: key) ?? defaultValue
   }

   public func getTestTransient3(forKey key: String, defaultValue: [TestTransient3]) -> [TestTransient3] {
      return getDecodable(key) ?? defaultValue
   }

   public func getTestTransient3(forKey key: String,  defaultValue: [String : TestTransient3]
   ) -> [String : TestTransient3] {
      return getTestTransient3(forKey: key) ?? defaultValue
   }

   public func setTestTransient3(value: TestTransient3, forKey key: String) {
      set(value.encode(), forKey: key)
   }

   public func setTestTransient3(value: [TestTransient3], forKey key: String) {
      set(value.map { $0.encode() }, forKey: key)
   }

   public func setTestTransient3(value: [String : TestTransient3], forKey key: String) {
      set(value.map { $0.encode() }, forKey: key)
   }
}

//****************************************************************************//
// MARK: KVStore support
//****************************************************************************//
extension KVStore {

   public func getTestTransient3(forKey key: String) -> TestTransient3? {
      return getValue(forKey: key)
   }

   public func getTestTransient3(forKey key: String, defaultValue: TestTransient3) -> TestTransient3 {
      return getTestTransient3(forKey: key) ?? defaultValue
   }

   public func getTestTransient3s(forKey key: String) -> [TestTransient3]? {
      return getValue(forKey: key)
   }

   public func getTestTransient3s(forKey key: String, defaultValue: [TestTransient3]) -> [TestTransient3] {
      return getTestTransient3s(forKey: key) ?? defaultValue
   }

   public func getTestTransient3Dictionary(forKey key: String) -> [String : TestTransient3]? {
      return getValue(forKey: key)
   }

   public func getTestTransient3Dictionary(forKey key: String, defaultValue: [String : TestTransient3]) -> [String : TestTransient3] {
      return getTestTransient3Dictionary(forKey: key) ?? defaultValue
   }
}

