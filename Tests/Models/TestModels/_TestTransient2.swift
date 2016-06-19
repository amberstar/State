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

   public static func decode(_ decoder: Decoder) -> TestTransient2? {
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

    public func encode(_ encoder: Encoder) {
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

//****************************************************************************//
// MARK: UserDefaults support
//****************************************************************************//
extension UserDefaults {

   public func getTestTransient2(forKey key: String) -> TestTransient2? {
      guard let dictionary = dictionary(forKey: key) else { return nil }
      return TestTransient2.decode(dictionary)
   }

   public func getTestTransient2(forKey key: String) -> [TestTransient2]? {
      guard let array = array(forKey: key) else { return nil }
      return sequence(array.map(TestTransient2.decode))
   }

   public func getTestTransient2(forKey key: String) -> [String : TestTransient2]? {
      guard let dictionary = dictionary(forKey: key) else { return nil }
      return sequence(dictionary.map { TestTransient2.decode($0) })
   }

   public func getTestTransient2(forKey key: String, defaultValue: TestTransient2) -> TestTransient2 {
      return getTestTransient2(forKey: key) ?? defaultValue
   }

   public func getTestTransient2(forKey key: String, defaultValue: [TestTransient2]) -> [TestTransient2] {
      return getDecodable(key) ?? defaultValue
   }

   public func getTestTransient2(forKey key: String,  defaultValue: [String : TestTransient2]
   ) -> [String : TestTransient2] {
      return getTestTransient2(forKey: key) ?? defaultValue
   }

   public func setTestTransient2(value: TestTransient2, forKey key: String) {
      set(value.encode(), forKey: key)
   }

   public func setTestTransient2(value: [TestTransient2], forKey key: String) {
      set(value.map { $0.encode() }, forKey: key)
   }

   public func setTestTransient2(value: [String : TestTransient2], forKey key: String) {
      set(value.map { $0.encode() }, forKey: key)
   }
}

//****************************************************************************//
// MARK: KVStore support
//****************************************************************************//
extension KVStore {

   public func getTestTransient2(forKey key: String) -> TestTransient2? {
      return getValue(forKey: key)
   }

   public func getTestTransient2(forKey key: String, defaultValue: TestTransient2) -> TestTransient2 {
      return getTestTransient2(forKey: key) ?? defaultValue
   }

   public func getTestTransient2s(forKey key: String) -> [TestTransient2]? {
      return getValue(forKey: key)
   }

   public func getTestTransient2s(forKey key: String, defaultValue: [TestTransient2]) -> [TestTransient2] {
      return getTestTransient2s(forKey: key) ?? defaultValue
   }

   public func getTestTransient2Dictionary(forKey key: String) -> [String : TestTransient2]? {
      return getValue(forKey: key)
   }

   public func getTestTransient2Dictionary(forKey key: String, defaultValue: [String : TestTransient2]) -> [String : TestTransient2] {
      return getTestTransient2Dictionary(forKey: key) ?? defaultValue
   }
}

