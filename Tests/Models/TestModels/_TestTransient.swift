/************************************************

        WARNING: MACHINE GENERATED FILE

 ************************************************/
import Foundation
import State

public struct TestTransient : Model {
    public var myNonTransient: String
    public var myTransientOptional: Double?
    public var myTransientRelationship = Gender.female

}

extension TestTransient : Decodable {

   public static func decode(_ decoder: Decoder) -> TestTransient? {
      return self.init(decoder: decoder)
   }

    public init?(decoder d: Decoder) {
        var decoder = d
        decoder = TestTransient.performMigrationIfNeeded(decoder)

         guard
            let myNonTransient: String = decoder.decode("myNonTransient")
         else { return  nil }

        self.myNonTransient = myNonTransient
        didFinishDecodingWithDecoder(decoder)
    }
}

extension TestTransient : Encodable {

    public func encode(_ encoder: Encoder) {
        encoder.encode(myNonTransient, "myNonTransient")

        TestTransient.encodeVersionIfNeeded(encoder)

        self.willFinishEncodingWithEncoder(encoder)
    }
}

extension TestTransient {

    /// These are provided from the data model designer
    /// and can be used to determine if the model is
    /// a different version.
    public static func modelVersionHash() -> String {
        return "<fb68fb70 311dfea6 b694df51 4fd77810 97ab74b7 37a7d6fb 6cad86c8 f6d15ca2>"
    }

    public static func modelVersionHashModifier() -> String? {
        return nil
    }
}

//****************************************************************************//
// MARK: UserDefaults support
//****************************************************************************//
extension UserDefaults {

   public func getTestTransient(forKey key: String) -> TestTransient? {
      guard let dictionary = dictionary(forKey: key) else { return nil }
      return TestTransient.decode(dictionary)
   }

   public func getTestTransient(forKey key: String) -> [TestTransient]? {
      guard let array = array(forKey: key) else { return nil }
      return sequence(array.map(TestTransient.decode))
   }

   public func getTestTransient(forKey key: String) -> [String : TestTransient]? {
      guard let dictionary = dictionary(forKey: key) else { return nil }
      return sequence(dictionary.map { TestTransient.decode($0) })
   }

   public func getTestTransient(forKey key: String, defaultValue: TestTransient) -> TestTransient {
      return getTestTransient(forKey: key) ?? defaultValue
   }

   public func getTestTransient(forKey key: String, defaultValue: [TestTransient]) -> [TestTransient] {
      return getDecodable(key) ?? defaultValue
   }

   public func getTestTransient(forKey key: String,  defaultValue: [String : TestTransient]
   ) -> [String : TestTransient] {
      return getTestTransient(forKey: key) ?? defaultValue
   }

   public func setTestTransient(value: TestTransient, forKey key: String) {
      set(value.encode(), forKey: key)
   }

   public func setTestTransient(value: [TestTransient], forKey key: String) {
      set(value.map { $0.encode() }, forKey: key)
   }

   public func setTestTransient(value: [String : TestTransient], forKey key: String) {
      set(value.map { $0.encode() }, forKey: key)
   }
}

//****************************************************************************//
// MARK: KVStore support
//****************************************************************************//
extension KVStore {

   public func getTestTransient(forKey key: String) -> TestTransient? {
      return getValue(forKey: key)
   }

   public func getTestTransient(forKey key: String, defaultValue: TestTransient) -> TestTransient {
      return getTestTransient(forKey: key) ?? defaultValue
   }

   public func getTestTransients(forKey key: String) -> [TestTransient]? {
      return getValue(forKey: key)
   }

   public func getTestTransients(forKey key: String, defaultValue: [TestTransient]) -> [TestTransient] {
      return getTestTransients(forKey: key) ?? defaultValue
   }

   public func getTestTransientDictionary(forKey key: String) -> [String : TestTransient]? {
      return getValue(forKey: key)
   }

   public func getTestTransientDictionary(forKey key: String, defaultValue: [String : TestTransient]) -> [String : TestTransient] {
      return getTestTransientDictionary(forKey: key) ?? defaultValue
   }
}

