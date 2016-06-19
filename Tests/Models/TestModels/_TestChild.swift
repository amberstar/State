/************************************************

        WARNING: MACHINE GENERATED FILE

 ************************************************/
import Foundation
import State

public struct TestChild : Model {
    public var age: Int?
    public var name: String?
    public var myChildren: [Grandchild]?
    public var gender: Gender?

}

extension TestChild : Decodable {

   public static func decode(_ decoder: Decoder) -> TestChild? {
      return self.init(decoder: decoder)
   }

    public init?(decoder d: Decoder) {
        var decoder = d
        decoder = TestChild.performMigrationIfNeeded(decoder)

        let age: Int? = decoder.decode("age")
        let name: String? = decoder.decode("name")
        let myChildren: [Grandchild]? = decoder.decode("myChildren")
        let gender: Gender? = decoder.decode("gender")

        self.age = age
        self.name = name
        self.myChildren = myChildren
        self.gender = gender
        didFinishDecodingWithDecoder(decoder)
    }
}

extension TestChild : Encodable {

    public func encode(_ encoder: Encoder) {
        encoder.encode(age, "age")
        encoder.encode(name, "name")
        encoder.encode(myChildren, "myChildren")
        encoder.encode(gender, "gender")

        TestChild.encodeVersionIfNeeded(encoder)

        self.willFinishEncodingWithEncoder(encoder)
    }
}

extension TestChild {

    /// These are provided from the data model designer
    /// and can be used to determine if the model is
    /// a different version.
    public static func modelVersionHash() -> String {
        return "<4b2e27e5 53e329ff 69cfb4ba 1573537c 35d26944 7199acfc 729b6b5c c6e0ac88>"
    }

    public static func modelVersionHashModifier() -> String? {
        return nil
    }
}

//****************************************************************************//
// MARK: UserDefaults support
//****************************************************************************//
extension UserDefaults {

   public func getTestChild(forKey key: String) -> TestChild? {
      guard let dictionary = dictionary(forKey: key) else { return nil }
      return TestChild.decode(dictionary)
   }

   public func getTestChild(forKey key: String) -> [TestChild]? {
      guard let array = array(forKey: key) else { return nil }
      return sequence(array.map(TestChild.decode))
   }

   public func getTestChild(forKey key: String) -> [String : TestChild]? {
      guard let dictionary = dictionary(forKey: key) else { return nil }
      return sequence(dictionary.map { TestChild.decode($0) })
   }

   public func getTestChild(forKey key: String, defaultValue: TestChild) -> TestChild {
      return getTestChild(forKey: key) ?? defaultValue
   }

   public func getTestChild(forKey key: String, defaultValue: [TestChild]) -> [TestChild] {
      return getDecodable(key) ?? defaultValue
   }

   public func getTestChild(forKey key: String,  defaultValue: [String : TestChild]
   ) -> [String : TestChild] {
      return getTestChild(forKey: key) ?? defaultValue
   }

   public func setTestChild(value: TestChild, forKey key: String) {
      set(value.encode(), forKey: key)
   }

   public func setTestChild(value: [TestChild], forKey key: String) {
      set(value.map { $0.encode() }, forKey: key)
   }

   public func setTestChild(value: [String : TestChild], forKey key: String) {
      set(value.map { $0.encode() }, forKey: key)
   }
}

//****************************************************************************//
// MARK: KVStore support
//****************************************************************************//
extension KVStore {

   public func getTestChild(forKey key: String) -> TestChild? {
      return getValue(forKey: key)
   }

   public func getTestChild(forKey key: String, defaultValue: TestChild) -> TestChild {
      return getTestChild(forKey: key) ?? defaultValue
   }

   public func getTestChilds(forKey key: String) -> [TestChild]? {
      return getValue(forKey: key)
   }

   public func getTestChilds(forKey key: String, defaultValue: [TestChild]) -> [TestChild] {
      return getTestChilds(forKey: key) ?? defaultValue
   }

   public func getTestChildDictionary(forKey key: String) -> [String : TestChild]? {
      return getValue(forKey: key)
   }

   public func getTestChildDictionary(forKey key: String, defaultValue: [String : TestChild]) -> [String : TestChild] {
      return getTestChildDictionary(forKey: key) ?? defaultValue
   }
}

