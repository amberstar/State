/************************************************

        WARNING: MACHINE GENERATED FILE

 ************************************************/
import Foundation
import State

public struct TestRelationships : Model {
    public var myChildren: [TestChild]?
    public var myGrandChildren: [Grandchild]?
    public var myOneChild: TestChild?

}

extension TestRelationships : Decodable {

   public static func decode(_ decoder: Decoder) -> TestRelationships? {
      return self.init(decoder: decoder)
   }

    public init?(decoder d: Decoder) {
        var decoder = d
        decoder = TestRelationships.performMigrationIfNeeded(decoder)

        let myChildren: [TestChild]? = decoder.decode("myChildren")
        let myGrandChildren: [Grandchild]? = decoder.decode("myGrandChildren")
        let myOneChild: TestChild? = decoder.decode("myOneChild")

        self.myChildren = myChildren
        self.myGrandChildren = myGrandChildren
        self.myOneChild = myOneChild
        didFinishDecoding(decoder: decoder)
    }
}

extension TestRelationships : Encodable {

    public func encode(_ encoder: Encoder) {
        encoder.encode(myChildren, "myChildren")
        encoder.encode(myGrandChildren, "myGrandChildren")
        encoder.encode(myOneChild, "myOneChild")

        TestRelationships.encodeVersionIfNeeded(encoder)

        self.willFinishEncoding(encoder: encoder)
    }
}

extension TestRelationships {

    /// These are provided from the data model designer
    /// and can be used to determine if the model is
    /// a different version.
    public static func modelVersionHash() -> String {
        return "<4086c709 08537ea3 c28164b3 9e9cbdbf e9d83f02 72d9cd8f cd10f5c7 101fbcbb>"
    }

    public static func modelVersionHashModifier() -> String? {
        return nil
    }
}

//****************************************************************************//
// MARK: UserDefaults support
//****************************************************************************//
extension UserDefaults {

   public func getTestRelationships(forKey key: String) -> TestRelationships? {
      guard let dictionary = dictionary(forKey: key) else { return nil }
      return TestRelationships.decode(dictionary)
   }

   public func getTestRelationships(forKey key: String) -> [TestRelationships]? {
      guard let array = array(forKey: key) else { return nil }
      return sequence(array.map(TestRelationships.decode))
   }

   public func getTestRelationships(forKey key: String) -> [String : TestRelationships]? {
      guard let dictionary = dictionary(forKey: key) else { return nil }
      return sequence(dictionary.map { TestRelationships.decode($0) })
   }

   public func getTestRelationships(forKey key: String, defaultValue: TestRelationships) -> TestRelationships {
      return getTestRelationships(forKey: key) ?? defaultValue
   }

   public func getTestRelationships(forKey key: String, defaultValue: [TestRelationships]) -> [TestRelationships] {
      return getDecodable(key) ?? defaultValue
   }

   public func getTestRelationships(forKey key: String,  defaultValue: [String : TestRelationships]) -> [String : TestRelationships] {
      return getTestRelationships(forKey: key) ?? defaultValue
   }

   public func setTestRelationships(value: TestRelationships, forKey key: String) {
      set(value.encode(), forKey: key)
   }

   public func setTestRelationships(value: [TestRelationships], forKey key: String) {
      set(value.map { $0.encode() }, forKey: key)
   }

   public func setTestRelationships(value: [String : TestRelationships], forKey key: String) {
      set(value.map { $0.encode() }, forKey: key)
   }
}

//****************************************************************************//
// MARK: KVStore support
//****************************************************************************//
extension KVStore {

   public func getTestRelationships(forKey key: String) -> TestRelationships? {
      return getValue(forKey: key)
   }

   public func getTestRelationships(forKey key: String, defaultValue: TestRelationships) -> TestRelationships {
      return getTestRelationships(forKey: key) ?? defaultValue
   }

   public func getTestRelationshipss(forKey key: String) -> [TestRelationships]? {
      return getValue(forKey: key)
   }

   public func getTestRelationshipss(forKey key: String, defaultValue: [TestRelationships]) -> [TestRelationships] {
      return getTestRelationshipss(forKey: key) ?? defaultValue
   }

   public func getTestRelationshipsDictionary(forKey key: String) -> [String : TestRelationships]? {
      return getValue(forKey: key)
   }

   public func getTestRelationshipsDictionary(forKey key: String, defaultValue: [String : TestRelationships]) -> [String : TestRelationships] {
      return getTestRelationshipsDictionary(forKey: key) ?? defaultValue
   }
}

