/************************************************

        WARNING: MACHINE GENERATED FILE

 ************************************************/
import Foundation
import State

public struct TestTransient : Model {
    public var myNonTransient: String
    public var myTransientOptional: Double?
    public var myTransientRelationship = Gender.Female

}

extension TestTransient : Decodable {

   public static func decode(decoder: Decoder) -> TestTransient? {
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

    public func encode(encoder: Encoder) {
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

extension NSUserDefaults {

   //****************************************************************************//
   // MARK: NSUserDefault Getters
   //****************************************************************************//

   public func getTestTransient(key: String) -> TestTransient? {
      guard let dictionary = dictionaryForKey(key) else { return nil }
      return TestTransient.decode(dictionary)
   }

   public func getTestTransient(key: String) -> [TestTransient]? {
      guard let array = arrayForKey(key) else { return nil }
      return sequence(array.map(TestTransient.decode))
   }

   public func getTestTransient(key: String) -> [String : TestTransient]? {
      guard let dictionary = dictionaryForKey(key) else { return nil }
      return sequence(dictionary.map { TestTransient.decode($0) })
   }

   public func getTestTransient(key: String, defaultValue: TestTransient) -> TestTransient {
      return getTestTransient(key) ?? defaultValue
   }

   public func getTestTransient(key: String, defaultValue: [TestTransient]) -> [TestTransient] {
      return getDecodable(key) ?? defaultValue
   }

   public func getTestTransient(key: String,  defaultValue: [String : TestTransient]
   ) -> [String : TestTransient] {
      return getTestTransient(key) ?? defaultValue
   }

   //****************************************************************************//
   // MARK: NSUserDefault Setters
   //****************************************************************************//

   public func setTestTransient(value: TestTransient, forKey key: String) {
      setObject(value.encode(), forKey: key)
   }

   public func setTestTransient(value: [TestTransient], forKey key: String) {
      setObject(value.map { $0.encode() }, forKey: key)
   }

   public func setTestTransient(value: [String : TestTransient], forKey key: String) {
      setObject(value.map { $0.encode() }, forKey: key)
   }
}

extension KVStore {

   public func getTestTransient(key: String) -> TestTransient? {
      return getValue(key)
   }

   public func getTestTransient(key: String, defaultValue: TestTransient) -> TestTransient {
      return getTestTransient(key) ?? defaultValue
   }

   public func getTestTransients(key: String) -> [TestTransient]? {
      return getValue(key)
   }

   public func getTestTransients(key: String, defaultValue: [TestTransient]) -> [TestTransient] {
      return getTestTransients(key) ?? defaultValue
   }

   public func getTestTransientDictionary(key: String) -> [String : TestTransient]? {
      return getValue(key)
   }

   public func getTestTransientDictionary(key: String, defaultValue: [String : TestTransient]) -> [String : TestTransient] {
      return getTestTransientDictionary(key) ?? defaultValue
   }
}

