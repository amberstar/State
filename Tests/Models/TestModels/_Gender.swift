/************************************************

        WARNING: MACHINE GENERATED FILE

 ************************************************/
import Foundation
import State

public enum Gender  : String, Model {

    case Female  = "Female"
    case Male  = "Male"

}

extension Gender: Decodable {

   public static func decode(decoder: Decoder) -> Gender? {
      return self.init(decoder: decoder)
   }

    public init?(decoder d: Decoder) {
        var decoder = d
        decoder = Gender.performMigrationIfNeeded(decoder)
        guard let value: String = decoder.decode("value") else { return nil }
        self.init(rawValue: value)
    }
}

extension Gender: Encodable {

    public func encode(encoder: Encoder) {
        encoder.encode(self.rawValue, "value")
        Gender.encodeVersionIfNeeded(encoder)
        self.willFinishEncodingWithEncoder(encoder)
    }
}

extension Gender {

    /// These are provided from the data model designer
    /// and can be used to determine if the model is
    /// a different version.
    public static func modelVersionHash() -> String {
        return "<ffba7348 838d3758 c6b41d57 ad7ea1b5 7c0a7ae4 0a9ead14 a727496b e503f5c2>"
    }

    public static func modelVersionHashModifier() -> String? {
        return nil
    }
}

extension NSUserDefaults {

   //****************************************************************************//
   // MARK: NSUserDefault Getters
   //****************************************************************************//

   public func getGender(key: String) -> Gender? {
      guard let dictionary = dictionaryForKey(key) else { return nil }
      return Gender.decode(dictionary)
   }

   public func getGender(key: String) -> [Gender]? {
      guard let array = arrayForKey(key) else { return nil }
      return sequence(array.map(Gender.decode))
   }

   public func getGender(key: String) -> [String : Gender]? {
      guard let dictionary = dictionaryForKey(key) else { return nil }
      return sequence(dictionary.map { Gender.decode($0) })
   }

   public func getGender(key: String, defaultValue: Gender) -> Gender {
      return getGender(key) ?? defaultValue
   }

   public func getGender(key: String, defaultValue: [Gender]) -> [Gender] {
      return getDecodable(key) ?? defaultValue
   }

   public func getGender(key: String,  defaultValue: [String : Gender]
   ) -> [String : Gender] {
      return getGender(key) ?? defaultValue
   }

   //****************************************************************************//
   // MARK: NSUserDefault Setters
   //****************************************************************************//

   public func setGender(value: Gender, forKey key: String) {
      setObject(value.encode(), forKey: key)
   }

   public func setGender(value: [Gender], forKey key: String) {
      setObject(value.map { $0.encode() }, forKey: key)
   }

   public func setGender(value: [String : Gender], forKey key: String) {
      setObject(value.map { $0.encode() }, forKey: key)
   }
}

extension KVStore {

   public func getGender(key: String) -> Gender? {
      return getValue(key)
   }

   public func getGender(key: String, defaultValue: Gender) -> Gender {
      return getGender(key) ?? defaultValue
   }

   public func getGenders(key: String) -> [Gender]? {
      return getValue(key)
   }

   public func getGenders(key: String, defaultValue: [Gender]) -> [Gender] {
      return getGenders(key) ?? defaultValue
   }

   public func getGenderDictionary(key: String) -> [String : Gender]? {
      return getValue(key)
   }

   public func getGenderDictionary(key: String, defaultValue: [String : Gender]) -> [String : Gender] {
      return getGenderDictionary(key) ?? defaultValue
   }
}

