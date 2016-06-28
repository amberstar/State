/************************************************

        WARNING: MACHINE GENERATED FILE

 ************************************************/
import Foundation
import State

public struct TestMigrationV2 : Model {
    public var age: Int?
    public var name: String

}

extension TestMigrationV2 : Decodable {

   public static func decode(_ decoder: Decoder) -> TestMigrationV2? {
      return self.init(decoder: decoder)
   }

    public init?(decoder d: Decoder) {
        var decoder = d
        decoder = TestMigrationV2.performMigrationIfNeeded(decoder)

         guard
            let name: String = decoder.decode("name")
         else { return  nil }

        let age: Int? = decoder.decode("age")

        self.age = age
        self.name = name
        didFinishDecoding(decoder: decoder)
    }
}

extension TestMigrationV2 : Encodable {

    public func encode(_ encoder: Encoder) {
        encoder.encode(age, "age")
        encoder.encode(name, "name")

        TestMigrationV2.encodeVersionIfNeeded(encoder)

        self.willFinishEncoding(encoder: encoder)
    }
}

extension TestMigrationV2 {

    /// These are provided from the data model designer
    /// and can be used to determine if the model is
    /// a different version.
    public static func modelVersionHash() -> String {
        return "<a72776b0 ed41d0ad 357dc213 d628b690 61fa4fa3 a91c4c0e 941122a8 c581023e>"
    }

    public static func modelVersionHashModifier() -> String? {
        return "2.0"
    }
}

//****************************************************************************//
// MARK: UserDefaults support
//****************************************************************************//
extension UserDefaults {

   public func getTestMigrationV2(forKey key: String) -> TestMigrationV2? {
      guard let dictionary = dictionary(forKey: key) else { return nil }
      return TestMigrationV2.decode(dictionary)
   }

   public func getTestMigrationV2(forKey key: String) -> [TestMigrationV2]? {
      guard let array = array(forKey: key) else { return nil }
      return sequence(array.map(TestMigrationV2.decode))
   }

   public func getTestMigrationV2(forKey key: String) -> [String : TestMigrationV2]? {
      guard let dictionary = dictionary(forKey: key) else { return nil }
      return sequence(dictionary.map { TestMigrationV2.decode($0) })
   }

   public func getTestMigrationV2(forKey key: String, defaultValue: TestMigrationV2) -> TestMigrationV2 {
      return getTestMigrationV2(forKey: key) ?? defaultValue
   }

   public func getTestMigrationV2(forKey key: String, defaultValue: [TestMigrationV2]) -> [TestMigrationV2] {
      return getDecodable(key) ?? defaultValue
   }

   public func getTestMigrationV2(forKey key: String,  defaultValue: [String : TestMigrationV2]) -> [String : TestMigrationV2] {
      return getTestMigrationV2(forKey: key) ?? defaultValue
   }

   public func setTestMigrationV2(value: TestMigrationV2, forKey key: String) {
      set(value.encode(), forKey: key)
   }

   public func setTestMigrationV2(value: [TestMigrationV2], forKey key: String) {
      set(value.map { $0.encode() }, forKey: key)
   }

   public func setTestMigrationV2(value: [String : TestMigrationV2], forKey key: String) {
      set(value.map { $0.encode() }, forKey: key)
   }
}

//****************************************************************************//
// MARK: KVStore support
//****************************************************************************//
extension KVStore {

   public func getTestMigrationV2(forKey key: String) -> TestMigrationV2? {
      return getValue(forKey: key)
   }

   public func getTestMigrationV2(forKey key: String, defaultValue: TestMigrationV2) -> TestMigrationV2 {
      return getTestMigrationV2(forKey: key) ?? defaultValue
   }

   public func getTestMigrationV2s(forKey key: String) -> [TestMigrationV2]? {
      return getValue(forKey: key)
   }

   public func getTestMigrationV2s(forKey key: String, defaultValue: [TestMigrationV2]) -> [TestMigrationV2] {
      return getTestMigrationV2s(forKey: key) ?? defaultValue
   }

   public func getTestMigrationV2Dictionary(forKey key: String) -> [String : TestMigrationV2]? {
      return getValue(forKey: key)
   }

   public func getTestMigrationV2Dictionary(forKey key: String, defaultValue: [String : TestMigrationV2]) -> [String : TestMigrationV2] {
      return getTestMigrationV2Dictionary(forKey: key) ?? defaultValue
   }
}

