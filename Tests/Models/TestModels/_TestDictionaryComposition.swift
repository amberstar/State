/************************************************

        WARNING: MACHINE GENERATED FILE

 ************************************************/
import Foundation
import State

public struct TestDictionaryComposition : Model {
    public var employees: [String : Employee]

}

extension TestDictionaryComposition : Decodable {

   public static func decode(_ decoder: Decoder) -> TestDictionaryComposition? {
      return self.init(decoder: decoder)
   }

    public init?(decoder d: Decoder) {
        var decoder = d
        decoder = TestDictionaryComposition.performMigrationIfNeeded(decoder)

         guard
            let employees: [String : Employee] = decoder.decode("employees")
         else { return  nil }

        self.employees = employees
        didFinishDecoding(decoder: decoder)
    }
}

extension TestDictionaryComposition : Encodable {

    public func encode(_ encoder: Encoder) {
        encoder.encode(employees, "employees")

        TestDictionaryComposition.encodeVersionIfNeeded(encoder)

        self.willFinishEncoding(encoder: encoder)
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

//****************************************************************************//
// MARK: UserDefaults support
//****************************************************************************//
extension UserDefaults {

   public func getTestDictionaryComposition(forKey key: String) -> TestDictionaryComposition? {
      guard let dictionary = dictionary(forKey: key) else { return nil }
      return TestDictionaryComposition.decode(dictionary)
   }

   public func getTestDictionaryComposition(forKey key: String) -> [TestDictionaryComposition]? {
      guard let array = array(forKey: key) else { return nil }
      return sequence(array.map(TestDictionaryComposition.decode))
   }

   public func getTestDictionaryComposition(forKey key: String) -> [String : TestDictionaryComposition]? {
      guard let dictionary = dictionary(forKey: key) else { return nil }
      return sequence(dictionary.map { TestDictionaryComposition.decode($0) })
   }

   public func getTestDictionaryComposition(forKey key: String, defaultValue: TestDictionaryComposition) -> TestDictionaryComposition {
      return getTestDictionaryComposition(forKey: key) ?? defaultValue
   }

   public func getTestDictionaryComposition(forKey key: String, defaultValue: [TestDictionaryComposition]) -> [TestDictionaryComposition] {
      return getDecodable(key) ?? defaultValue
   }

   public func getTestDictionaryComposition(forKey key: String,  defaultValue: [String : TestDictionaryComposition]) -> [String : TestDictionaryComposition] {
      return getTestDictionaryComposition(forKey: key) ?? defaultValue
   }

   public func setTestDictionaryComposition(value: TestDictionaryComposition, forKey key: String) {
      set(value.encode(), forKey: key)
   }

   public func setTestDictionaryComposition(value: [TestDictionaryComposition], forKey key: String) {
      set(value.map { $0.encode() }, forKey: key)
   }

   public func setTestDictionaryComposition(value: [String : TestDictionaryComposition], forKey key: String) {
      set(value.map { $0.encode() }, forKey: key)
   }
}

//****************************************************************************//
// MARK: KVStore support
//****************************************************************************//
extension KVStore {

   public func getTestDictionaryComposition(forKey key: String) -> TestDictionaryComposition? {
      return getValue(forKey: key)
   }

   public func getTestDictionaryComposition(forKey key: String, defaultValue: TestDictionaryComposition) -> TestDictionaryComposition {
      return getTestDictionaryComposition(forKey: key) ?? defaultValue
   }

   public func getTestDictionaryCompositions(forKey key: String) -> [TestDictionaryComposition]? {
      return getValue(forKey: key)
   }

   public func getTestDictionaryCompositions(forKey key: String, defaultValue: [TestDictionaryComposition]) -> [TestDictionaryComposition] {
      return getTestDictionaryCompositions(forKey: key) ?? defaultValue
   }

   public func getTestDictionaryCompositionDictionary(forKey key: String) -> [String : TestDictionaryComposition]? {
      return getValue(forKey: key)
   }

   public func getTestDictionaryCompositionDictionary(forKey key: String, defaultValue: [String : TestDictionaryComposition]) -> [String : TestDictionaryComposition] {
      return getTestDictionaryCompositionDictionary(forKey: key) ?? defaultValue
   }
}

