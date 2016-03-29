/************************************************

        WARNING: MACHINE GENERATED FILE

 ************************************************/
import Foundation
import State

public struct TestDictionaryComposition : Model {
    public var employees: [String : Employee]

}

extension TestDictionaryComposition : Decodable {

   public static func decode(decoder: Decoder) -> TestDictionaryComposition? {
      return self.init(decoder: decoder)
   }

    public init?(decoder d: Decoder) {
        var decoder = d
        decoder = TestDictionaryComposition.performMigrationIfNeeded(decoder)

         guard
            let employees: [String : Employee] = decoder.decode("employees")
         else { return  nil }

        self.employees = employees
        didFinishDecodingWithDecoder(decoder)
    }
}

extension TestDictionaryComposition : Encodable {

    public func encode(encoder: Encoder) {
        encoder.encode(employees, "employees")

        TestDictionaryComposition.encodeVersionIfNeeded(encoder)

        self.willFinishEncodingWithEncoder(encoder)
    }
}

extension TestDictionaryComposition {

    /// These are provided from the data model designer
    /// and can be used to determine if the model is
    /// a different version.
    public static func modelVersionHash() -> String {
        return "<80c11a40 d9a760e9 bfcbb271 8b75d132 c3ac7b52 8d23b6f1 222b79ae b0e4c5f9>"
    }

    public static func modelVersionHashModifier() -> String? {
        return nil
    }
}

extension NSUserDefaults {

   //****************************************************************************//
   // MARK: NSUserDefault Getters
   //****************************************************************************//

   public func getTestDictionaryComposition(key: String) -> TestDictionaryComposition? {
      guard let dictionary = dictionaryForKey(key) else { return nil }
      return TestDictionaryComposition.decode(dictionary)
   }

   public func getTestDictionaryComposition(key: String) -> [TestDictionaryComposition]? {
      guard let array = arrayForKey(key) else { return nil }
      return sequence(array.map(TestDictionaryComposition.decode))
   }

   public func getTestDictionaryComposition(key: String) -> [String : TestDictionaryComposition]? {
      guard let dictionary = dictionaryForKey(key) else { return nil }
      return sequence(dictionary.map { TestDictionaryComposition.decode($0) })
   }

   public func getTestDictionaryComposition(key: String, defaultValue: TestDictionaryComposition) -> TestDictionaryComposition {
      return getTestDictionaryComposition(key) ?? defaultValue
   }

   public func getTestDictionaryComposition(key: String, defaultValue: [TestDictionaryComposition]) -> [TestDictionaryComposition] {
      return getDecodable(key) ?? defaultValue
   }

   public func getTestDictionaryComposition(key: String,  defaultValue: [String : TestDictionaryComposition]
   ) -> [String : TestDictionaryComposition] {
      return getTestDictionaryComposition(key) ?? defaultValue
   }

   //****************************************************************************//
   // MARK: NSUserDefault Setters
   //****************************************************************************//

   public func setTestDictionaryComposition(value: TestDictionaryComposition, forKey key: String) {
      setObject(value.encode(), forKey: key)
   }

   public func setTestDictionaryComposition(value: [TestDictionaryComposition], forKey key: String) {
      setObject(value.map { $0.encode() }, forKey: key)
   }

   public func setTestDictionaryComposition(value: [String : TestDictionaryComposition], forKey key: String) {
      setObject(value.map { $0.encode() }, forKey: key)
   }
}

extension KVStore {

   public func getTestDictionaryComposition(key: String) -> TestDictionaryComposition? {
      return getValue(key)
   }

   public func getTestDictionaryComposition(key: String, defaultValue: TestDictionaryComposition) -> TestDictionaryComposition {
      return getTestDictionaryComposition(key) ?? defaultValue
   }

   public func getTestDictionaryCompositions(key: String) -> [TestDictionaryComposition]? {
      return getValue(key)
   }

   public func getTestDictionaryCompositions(key: String, defaultValue: [TestDictionaryComposition]) -> [TestDictionaryComposition] {
      return getTestDictionaryCompositions(key) ?? defaultValue
   }

   public func getTestDictionaryCompositionDictionary(key: String) -> [String : TestDictionaryComposition]? {
      return getValue(key)
   }

   public func getTestDictionaryCompositionDictionary(key: String, defaultValue: [String : TestDictionaryComposition]) -> [String : TestDictionaryComposition] {
      return getTestDictionaryCompositionDictionary(key) ?? defaultValue
   }
}

