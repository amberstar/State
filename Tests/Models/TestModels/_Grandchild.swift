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

   public static func decode(decoder: Decoder) -> Grandchild? {
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

    public func encode(encoder: Encoder) {
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

extension NSUserDefaults {

   //****************************************************************************//
   // MARK: NSUserDefault Getters
   //****************************************************************************//

   public func getGrandchild(key: String) -> Grandchild? {
      guard let dictionary = dictionaryForKey(key) else { return nil }
      return Grandchild.decode(dictionary)
   }

   public func getGrandchild(key: String) -> [Grandchild]? {
      guard let array = arrayForKey(key) else { return nil }
      return sequence(array.map(Grandchild.decode))
   }

   public func getGrandchild(key: String) -> [String : Grandchild]? {
      guard let dictionary = dictionaryForKey(key) else { return nil }
      return sequence(dictionary.map { Grandchild.decode($0) })
   }

   public func getGrandchild(key: String, defaultValue: Grandchild) -> Grandchild {
      return getGrandchild(key) ?? defaultValue
   }

   public func getGrandchild(key: String, defaultValue: [Grandchild]) -> [Grandchild] {
      return getDecodable(key) ?? defaultValue
   }

   public func getGrandchild(key: String,  defaultValue: [String : Grandchild]
   ) -> [String : Grandchild] {
      return getGrandchild(key) ?? defaultValue
   }

   //****************************************************************************//
   // MARK: NSUserDefault Setters
   //****************************************************************************//

   public func setGrandchild(value: Grandchild, forKey key: String) {
      setObject(value.encode(), forKey: key)
   }

   public func setGrandchild(value: [Grandchild], forKey key: String) {
      setObject(value.map { $0.encode() }, forKey: key)
   }

   public func setGrandchild(value: [String : Grandchild], forKey key: String) {
      setObject(value.map { $0.encode() }, forKey: key)
   }
}

extension KVStore {

   public func getGrandchild(key: String) -> Grandchild? {
      return getValue(key)
   }

   public func getGrandchild(key: String, defaultValue: Grandchild) -> Grandchild {
      return getGrandchild(key) ?? defaultValue
   }

   public func getGrandchilds(key: String) -> [Grandchild]? {
      return getValue(key)
   }

   public func getGrandchilds(key: String, defaultValue: [Grandchild]) -> [Grandchild] {
      return getGrandchilds(key) ?? defaultValue
   }

   public func getGrandchildDictionary(key: String) -> [String : Grandchild]? {
      return getValue(key)
   }

   public func getGrandchildDictionary(key: String, defaultValue: [String : Grandchild]) -> [String : Grandchild] {
      return getGrandchildDictionary(key) ?? defaultValue
   }
}

