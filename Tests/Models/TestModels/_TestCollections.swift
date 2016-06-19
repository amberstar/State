/************************************************

        WARNING: MACHINE GENERATED FILE

 ************************************************/
import Foundation
import State

public struct TestCollections : Model {
    public var arrayOfStrings: [String]
    public var dicOfInts: [String : Int]
    public var setOfStrings: Set<String>

}

extension TestCollections : Decodable {

   public static func decode(_ decoder: Decoder) -> TestCollections? {
      return self.init(decoder: decoder)
   }

    public init?(decoder d: Decoder) {
        var decoder = d
        decoder = TestCollections.performMigrationIfNeeded(decoder)

         guard
            let arrayOfStrings: [String] = decoder.decode("arrayOfStrings"),
            let dicOfInts: [String : Int] = decoder.decode("dicOfInts"),
            let setOfStrings: Set<String> = decoder.decode("setOfStrings")
         else { return  nil }

        self.arrayOfStrings = arrayOfStrings
        self.dicOfInts = dicOfInts
        self.setOfStrings = setOfStrings
        didFinishDecodingWithDecoder(decoder)
    }
}

extension TestCollections : Encodable {

    public func encode(_ encoder: Encoder) {
        encoder.encode(arrayOfStrings, "arrayOfStrings")
        encoder.encode(dicOfInts, "dicOfInts")
        encoder.encode(setOfStrings, "setOfStrings")

        TestCollections.encodeVersionIfNeeded(encoder)

        self.willFinishEncodingWithEncoder(encoder)
    }
}

extension TestCollections {

    /// These are provided from the data model designer
    /// and can be used to determine if the model is
    /// a different version.
    public static func modelVersionHash() -> String {
        return "<313ca880 7b444092 cef097e8 0b29feb7 e70ab4b5 3b7298dc 4debc39c 90801887>"
    }

    public static func modelVersionHashModifier() -> String? {
        return nil
    }
}

//****************************************************************************//
// MARK: UserDefaults support
//****************************************************************************//
extension UserDefaults {

   public func getTestCollections(forKey key: String) -> TestCollections? {
      guard let dictionary = dictionary(forKey: key) else { return nil }
      return TestCollections.decode(dictionary)
   }

   public func getTestCollections(forKey key: String) -> [TestCollections]? {
      guard let array = array(forKey: key) else { return nil }
      return sequence(array.map(TestCollections.decode))
   }

   public func getTestCollections(forKey key: String) -> [String : TestCollections]? {
      guard let dictionary = dictionary(forKey: key) else { return nil }
      return sequence(dictionary.map { TestCollections.decode($0) })
   }

   public func getTestCollections(forKey key: String, defaultValue: TestCollections) -> TestCollections {
      return getTestCollections(forKey: key) ?? defaultValue
   }

   public func getTestCollections(forKey key: String, defaultValue: [TestCollections]) -> [TestCollections] {
      return getDecodable(key) ?? defaultValue
   }

   public func getTestCollections(forKey key: String,  defaultValue: [String : TestCollections]
   ) -> [String : TestCollections] {
      return getTestCollections(forKey: key) ?? defaultValue
   }

   public func setTestCollections(value: TestCollections, forKey key: String) {
      set(value.encode(), forKey: key)
   }

   public func setTestCollections(value: [TestCollections], forKey key: String) {
      set(value.map { $0.encode() }, forKey: key)
   }

   public func setTestCollections(value: [String : TestCollections], forKey key: String) {
      set(value.map { $0.encode() }, forKey: key)
   }
}

//****************************************************************************//
// MARK: KVStore support
//****************************************************************************//
extension KVStore {

   public func getTestCollections(forKey key: String) -> TestCollections? {
      return getValue(forKey: key)
   }

   public func getTestCollections(forKey key: String, defaultValue: TestCollections) -> TestCollections {
      return getTestCollections(forKey: key) ?? defaultValue
   }

   public func getTestCollectionss(forKey key: String) -> [TestCollections]? {
      return getValue(forKey: key)
   }

   public func getTestCollectionss(forKey key: String, defaultValue: [TestCollections]) -> [TestCollections] {
      return getTestCollectionss(forKey: key) ?? defaultValue
   }

   public func getTestCollectionsDictionary(forKey key: String) -> [String : TestCollections]? {
      return getValue(forKey: key)
   }

   public func getTestCollectionsDictionary(forKey key: String, defaultValue: [String : TestCollections]) -> [String : TestCollections] {
      return getTestCollectionsDictionary(forKey: key) ?? defaultValue
   }
}

