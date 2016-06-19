/************************************************

        WARNING: MACHINE GENERATED FILE

 ************************************************/
import Foundation
import State

public struct TestTransformable : Model {
    public var myTransformable: NSURL
    public let myTransformableImmutable: NSURL
    public let myTransformableImmutableOptional: NSURL?
    public var myTransformableOptional: NSURL?

}

extension TestTransformable : Decodable {

   public static func decode(_ decoder: Decoder) -> TestTransformable? {
      return self.init(decoder: decoder)
   }

    public init?(decoder d: Decoder) {
        var decoder = d
        decoder = TestTransformable.performMigrationIfNeeded(decoder)

         guard
            let myTransformable: NSURL = decoder.decode("myTransformable"),
            let myTransformableImmutable: NSURL = decoder.decode("myTransformableImmutable")
         else { return  nil }

        let myTransformableImmutableOptional: NSURL? = decoder.decode("myTransformableImmutableOptional")
        let myTransformableOptional: NSURL? = decoder.decode("myTransformableOptional")

        self.myTransformable = myTransformable
        self.myTransformableImmutable = myTransformableImmutable
        self.myTransformableImmutableOptional = myTransformableImmutableOptional
        self.myTransformableOptional = myTransformableOptional
        didFinishDecodingWithDecoder(decoder)
    }
}

extension TestTransformable : Encodable {

    public func encode(_ encoder: Encoder) {
        encoder.encode(myTransformable, "myTransformable")
        encoder.encode(myTransformableImmutable, "myTransformableImmutable")
        encoder.encode(myTransformableImmutableOptional, "myTransformableImmutableOptional")
        encoder.encode(myTransformableOptional, "myTransformableOptional")

        TestTransformable.encodeVersionIfNeeded(encoder)

        self.willFinishEncodingWithEncoder(encoder)
    }
}

extension TestTransformable {

    /// These are provided from the data model designer
    /// and can be used to determine if the model is
    /// a different version.
    public static func modelVersionHash() -> String {
        return "<ab73b735 b1201428 cbab765c 5357fbe9 b413a176 90618f51 b3efae27 d31a5116>"
    }

    public static func modelVersionHashModifier() -> String? {
        return nil
    }
}

//****************************************************************************//
// MARK: UserDefaults support
//****************************************************************************//
extension UserDefaults {

   public func getTestTransformable(forKey key: String) -> TestTransformable? {
      guard let dictionary = dictionary(forKey: key) else { return nil }
      return TestTransformable.decode(dictionary)
   }

   public func getTestTransformable(forKey key: String) -> [TestTransformable]? {
      guard let array = array(forKey: key) else { return nil }
      return sequence(array.map(TestTransformable.decode))
   }

   public func getTestTransformable(forKey key: String) -> [String : TestTransformable]? {
      guard let dictionary = dictionary(forKey: key) else { return nil }
      return sequence(dictionary.map { TestTransformable.decode($0) })
   }

   public func getTestTransformable(forKey key: String, defaultValue: TestTransformable) -> TestTransformable {
      return getTestTransformable(forKey: key) ?? defaultValue
   }

   public func getTestTransformable(forKey key: String, defaultValue: [TestTransformable]) -> [TestTransformable] {
      return getDecodable(key) ?? defaultValue
   }

   public func getTestTransformable(forKey key: String,  defaultValue: [String : TestTransformable]
   ) -> [String : TestTransformable] {
      return getTestTransformable(forKey: key) ?? defaultValue
   }

   public func setTestTransformable(value: TestTransformable, forKey key: String) {
      set(value.encode(), forKey: key)
   }

   public func setTestTransformable(value: [TestTransformable], forKey key: String) {
      set(value.map { $0.encode() }, forKey: key)
   }

   public func setTestTransformable(value: [String : TestTransformable], forKey key: String) {
      set(value.map { $0.encode() }, forKey: key)
   }
}

//****************************************************************************//
// MARK: KVStore support
//****************************************************************************//
extension KVStore {

   public func getTestTransformable(forKey key: String) -> TestTransformable? {
      return getValue(forKey: key)
   }

   public func getTestTransformable(forKey key: String, defaultValue: TestTransformable) -> TestTransformable {
      return getTestTransformable(forKey: key) ?? defaultValue
   }

   public func getTestTransformables(forKey key: String) -> [TestTransformable]? {
      return getValue(forKey: key)
   }

   public func getTestTransformables(forKey key: String, defaultValue: [TestTransformable]) -> [TestTransformable] {
      return getTestTransformables(forKey: key) ?? defaultValue
   }

   public func getTestTransformableDictionary(forKey key: String) -> [String : TestTransformable]? {
      return getValue(forKey: key)
   }

   public func getTestTransformableDictionary(forKey key: String, defaultValue: [String : TestTransformable]) -> [String : TestTransformable] {
      return getTestTransformableDictionary(forKey: key) ?? defaultValue
   }
}

