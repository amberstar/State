/************************************************

        WARNING: MACHINE GENERATED FILE

 ************************************************/
import Foundation
import State

public struct Grandchild : Model {
    public var age: Int?
    public var name: String?
    public var gender: Gender?

}

extension Grandchild : Decodable {

   public static func decode(_ decoder: Decoder) -> Grandchild? {
      return self.init(decoder: decoder)
   }

    public init?(decoder d: Decoder) {
        var decoder = d
        decoder = Grandchild.performMigrationIfNeeded(decoder)

        let age: Int? = decoder.decode("age")
        let name: String? = decoder.decode("name")
        let gender: Gender? = decoder.decode("gender")

        self.age = age
        self.name = name
        self.gender = gender
        didFinishDecodingWithDecoder(decoder)
    }
}

extension Grandchild : Encodable {

    public func encode(_ encoder: Encoder) {
        encoder.encode(age, "age")
        encoder.encode(name, "name")
        encoder.encode(gender, "gender")

        Grandchild.encodeVersionIfNeeded(encoder)

        self.willFinishEncodingWithEncoder(encoder)
    }
}

extension Grandchild {

    /// These are provided from the data model designer
    /// and can be used to determine if the model is
    /// a different version.
    public static func modelVersionHash() -> String {
        return "<10d8adcc 35a3ab52 8d11fa17 fbbdb083 23527533 29812594 823e8a17 8e1cb50d>"
    }

    public static func modelVersionHashModifier() -> String? {
        return nil
    }
}

//****************************************************************************//
// MARK: UserDefaults support
//****************************************************************************//
extension UserDefaults {

   public func getGrandchild(forKey key: String) -> Grandchild? {
      guard let dictionary = dictionary(forKey: key) else { return nil }
      return Grandchild.decode(dictionary)
   }

   public func getGrandchild(forKey key: String) -> [Grandchild]? {
      guard let array = array(forKey: key) else { return nil }
      return sequence(array.map(Grandchild.decode))
   }

   public func getGrandchild(forKey key: String) -> [String : Grandchild]? {
      guard let dictionary = dictionary(forKey: key) else { return nil }
      return sequence(dictionary.map { Grandchild.decode($0) })
   }

   public func getGrandchild(forKey key: String, defaultValue: Grandchild) -> Grandchild {
      return getGrandchild(forKey: key) ?? defaultValue
   }

   public func getGrandchild(forKey key: String, defaultValue: [Grandchild]) -> [Grandchild] {
      return getDecodable(key) ?? defaultValue
   }

   public func getGrandchild(forKey key: String,  defaultValue: [String : Grandchild]
   ) -> [String : Grandchild] {
      return getGrandchild(forKey: key) ?? defaultValue
   }

   public func setGrandchild(value: Grandchild, forKey key: String) {
      set(value.encode(), forKey: key)
   }

   public func setGrandchild(value: [Grandchild], forKey key: String) {
      set(value.map { $0.encode() }, forKey: key)
   }

   public func setGrandchild(value: [String : Grandchild], forKey key: String) {
      set(value.map { $0.encode() }, forKey: key)
   }
}

//****************************************************************************//
// MARK: KVStore support
//****************************************************************************//
extension KVStore {

   public func getGrandchild(forKey key: String) -> Grandchild? {
      return getValue(forKey: key)
   }

   public func getGrandchild(forKey key: String, defaultValue: Grandchild) -> Grandchild {
      return getGrandchild(forKey: key) ?? defaultValue
   }

   public func getGrandchilds(forKey key: String) -> [Grandchild]? {
      return getValue(forKey: key)
   }

   public func getGrandchilds(forKey key: String, defaultValue: [Grandchild]) -> [Grandchild] {
      return getGrandchilds(forKey: key) ?? defaultValue
   }

   public func getGrandchildDictionary(forKey key: String) -> [String : Grandchild]? {
      return getValue(forKey: key)
   }

   public func getGrandchildDictionary(forKey key: String, defaultValue: [String : Grandchild]) -> [String : Grandchild] {
      return getGrandchildDictionary(forKey: key) ?? defaultValue
   }
}

