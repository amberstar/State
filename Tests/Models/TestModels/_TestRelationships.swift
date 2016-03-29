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

   public static func decode(decoder: Decoder) -> TestRelationships? {
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
        didFinishDecodingWithDecoder(decoder)
    }
}

extension TestRelationships : Encodable {

    public func encode(encoder: Encoder) {
        encoder.encode(myChildren, "myChildren")
        encoder.encode(myGrandChildren, "myGrandChildren")
        encoder.encode(myOneChild, "myOneChild")

        TestRelationships.encodeVersionIfNeeded(encoder)

        self.willFinishEncodingWithEncoder(encoder)
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

extension NSUserDefaults {

   //****************************************************************************//
   // MARK: NSUserDefault Getters
   //****************************************************************************//

   public func getTestRelationships(key: String) -> TestRelationships? {
      guard let dictionary = dictionaryForKey(key) else { return nil }
      return TestRelationships.decode(dictionary)
   }

   public func getTestRelationships(key: String) -> [TestRelationships]? {
      guard let array = arrayForKey(key) else { return nil }
      return sequence(array.map(TestRelationships.decode))
   }

   public func getTestRelationships(key: String) -> [String : TestRelationships]? {
      guard let dictionary = dictionaryForKey(key) else { return nil }
      return sequence(dictionary.map { TestRelationships.decode($0) })
   }

   public func getTestRelationships(key: String, defaultValue: TestRelationships) -> TestRelationships {
      return getTestRelationships(key) ?? defaultValue
   }

   public func getTestRelationships(key: String, defaultValue: [TestRelationships]) -> [TestRelationships] {
      return getDecodable(key) ?? defaultValue
   }

   public func getTestRelationships(key: String,  defaultValue: [String : TestRelationships]
   ) -> [String : TestRelationships] {
      return getTestRelationships(key) ?? defaultValue
   }

   //****************************************************************************//
   // MARK: NSUserDefault Setters
   //****************************************************************************//

   public func setTestRelationships(value: TestRelationships, forKey key: String) {
      setObject(value.encode(), forKey: key)
   }

   public func setTestRelationships(value: [TestRelationships], forKey key: String) {
      setObject(value.map { $0.encode() }, forKey: key)
   }

   public func setTestRelationships(value: [String : TestRelationships], forKey key: String) {
      setObject(value.map { $0.encode() }, forKey: key)
   }
}

extension KVStore {

   public func getTestRelationships(key: String) -> TestRelationships? {
      return getValue(key)
   }

   public func getTestRelationships(key: String, defaultValue: TestRelationships) -> TestRelationships {
      return getTestRelationships(key) ?? defaultValue
   }

   public func getTestRelationshipss(key: String) -> [TestRelationships]? {
      return getValue(key)
   }

   public func getTestRelationshipss(key: String, defaultValue: [TestRelationships]) -> [TestRelationships] {
      return getTestRelationshipss(key) ?? defaultValue
   }

   public func getTestRelationshipsDictionary(key: String) -> [String : TestRelationships]? {
      return getValue(key)
   }

   public func getTestRelationshipsDictionary(key: String, defaultValue: [String : TestRelationships]) -> [String : TestRelationships] {
      return getTestRelationshipsDictionary(key) ?? defaultValue
   }
}

