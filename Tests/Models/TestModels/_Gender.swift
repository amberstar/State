/************************************************

        WARNING: MACHINE GENERATED FILE

 ************************************************/
import Foundation
import State

public enum Gender  : String, Model {

    case female  = "female"
    case male  = "male"

}

extension Gender: Decodable {

   public static func decode(_ decoder: Decoder) -> Gender? {
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

    public func encode(_ encoder: Encoder) {
        encoder.encode(self.rawValue, "value")
        Gender.encodeVersionIfNeeded(encoder)
        self.willFinishEncoding(encoder: encoder)
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

//****************************************************************************//
// MARK: UserDefaults support
//****************************************************************************//
extension UserDefaults {

   public func getGender(forKey key: String) -> Gender? {
      guard let dictionary = dictionary(forKey: key) else { return nil }
      return Gender.decode(dictionary)
   }

   public func getGender(forKey key: String) -> [Gender]? {
      guard let array = array(forKey: key) else { return nil }
      return sequence(array.map(Gender.decode))
   }

   public func getGender(forKey key: String) -> [String : Gender]? {
      guard let dictionary = dictionary(forKey: key) else { return nil }
      return sequence(dictionary.map { Gender.decode($0) })
   }

   public func getGender(forKey key: String, defaultValue: Gender) -> Gender {
      return getGender(forKey: key) ?? defaultValue
   }

   public func getGender(forKey key: String, defaultValue: [Gender]) -> [Gender] {
      return getDecodable(key) ?? defaultValue
   }

   public func getGender(forKey key: String,  defaultValue: [String : Gender]) -> [String : Gender] {
      return getGender(forKey: key) ?? defaultValue
   }

   public func setGender(value: Gender, forKey key: String) {
      set(value.encode(), forKey: key)
   }

   public func setGender(value: [Gender], forKey key: String) {
      set(value.map { $0.encode() }, forKey: key)
   }

   public func setGender(value: [String : Gender], forKey key: String) {
      set(value.map { $0.encode() }, forKey: key)
   }
}

//****************************************************************************//
// MARK: KVStore support
//****************************************************************************//
extension KVStore {

   public func getGender(forKey key: String) -> Gender? {
      return getValue(forKey: key)
   }

   public func getGender(forKey key: String, defaultValue: Gender) -> Gender {
      return getGender(forKey: key) ?? defaultValue
   }

   public func getGenders(forKey key: String) -> [Gender]? {
      return getValue(forKey: key)
   }

   public func getGenders(forKey key: String, defaultValue: [Gender]) -> [Gender] {
      return getGenders(forKey: key) ?? defaultValue
   }

   public func getGenderDictionary(forKey key: String) -> [String : Gender]? {
      return getValue(forKey: key)
   }

   public func getGenderDictionary(forKey key: String, defaultValue: [String : Gender]) -> [String : Gender] {
      return getGenderDictionary(forKey: key) ?? defaultValue
   }
}

