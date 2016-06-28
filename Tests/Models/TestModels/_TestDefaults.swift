/************************************************

        WARNING: MACHINE GENERATED FILE

 ************************************************/
import Foundation
import State

public struct TestDefaults : Model {
    public var defaultManualString = "defaultManualString"
    public var defaultArray = ["zero", "one", "two"]
    public var defaultString = "defaultString"
    public var noDefaultInt: Int?
    public var defaultInt = 10
    public var noDefaultString: String?
    public var defaultEmptyArray = [String]()
    public var defaultChildren = [TestDefaultsChild]()
    public var defaultChild = TestDefaultsChild()
    public var noDefaultChild: TestDefaultsChild?
    public var noDefaultChildren: TestDefaultsChild?

}

extension TestDefaults : Decodable {

   public static func decode(_ decoder: Decoder) -> TestDefaults? {
      return self.init(decoder: decoder)
   }

    public init?(decoder d: Decoder) {
        var decoder = d
        decoder = TestDefaults.performMigrationIfNeeded(decoder)

         guard
            let defaultManualString: String = decoder.decode("defaultManualString"),
            let defaultArray: [String] = decoder.decode("defaultArray"),
            let defaultString: String = decoder.decode("defaultString"),
            let defaultInt: Int = decoder.decode("defaultInt"),
            let defaultEmptyArray: [String] = decoder.decode("defaultEmptyArray"),
            let defaultChildren: [TestDefaultsChild] = decoder.decode("defaultChildren"),
            let defaultChild: TestDefaultsChild = decoder.decode("defaultChild")
         else { return  nil }

        let noDefaultInt: Int? = decoder.decode("noDefaultInt")

        let noDefaultString: String? = decoder.decode("noDefaultString")

        let noDefaultChild: TestDefaultsChild? = decoder.decode("noDefaultChild")
        let noDefaultChildren: TestDefaultsChild? = decoder.decode("noDefaultChildren")

        self.defaultManualString = defaultManualString
        self.defaultArray = defaultArray
        self.defaultString = defaultString
        self.noDefaultInt = noDefaultInt
        self.defaultInt = defaultInt
        self.noDefaultString = noDefaultString
        self.defaultEmptyArray = defaultEmptyArray
        self.defaultChildren = defaultChildren
        self.defaultChild = defaultChild
        self.noDefaultChild = noDefaultChild
        self.noDefaultChildren = noDefaultChildren
        didFinishDecoding(decoder: decoder)
    }
}

extension TestDefaults : Encodable {

    public func encode(_ encoder: Encoder) {
        encoder.encode(defaultManualString, "defaultManualString")
        encoder.encode(defaultArray, "defaultArray")
        encoder.encode(defaultString, "defaultString")
        encoder.encode(noDefaultInt, "noDefaultInt")
        encoder.encode(defaultInt, "defaultInt")
        encoder.encode(noDefaultString, "noDefaultString")
        encoder.encode(defaultEmptyArray, "defaultEmptyArray")
        encoder.encode(defaultChildren, "defaultChildren")
        encoder.encode(defaultChild, "defaultChild")
        encoder.encode(noDefaultChild, "noDefaultChild")
        encoder.encode(noDefaultChildren, "noDefaultChildren")

        TestDefaults.encodeVersionIfNeeded(encoder)

        self.willFinishEncoding(encoder: encoder)
    }
}

extension TestDefaults {

    /// These are provided from the data model designer
    /// and can be used to determine if the model is
    /// a different version.
    public static func modelVersionHash() -> String {
        return "<0e8e50ed 18d24253 6a725634 c5478e08 df6549ca 70f50d04 adec849b 3e79bdfc>"
    }

    public static func modelVersionHashModifier() -> String? {
        return nil
    }
}

//****************************************************************************//
// MARK: UserDefaults support
//****************************************************************************//
extension UserDefaults {

   public func getTestDefaults(forKey key: String) -> TestDefaults? {
      guard let dictionary = dictionary(forKey: key) else { return nil }
      return TestDefaults.decode(dictionary)
   }

   public func getTestDefaults(forKey key: String) -> [TestDefaults]? {
      guard let array = array(forKey: key) else { return nil }
      return sequence(array.map(TestDefaults.decode))
   }

   public func getTestDefaults(forKey key: String) -> [String : TestDefaults]? {
      guard let dictionary = dictionary(forKey: key) else { return nil }
      return sequence(dictionary.map { TestDefaults.decode($0) })
   }

   public func getTestDefaults(forKey key: String, defaultValue: TestDefaults) -> TestDefaults {
      return getTestDefaults(forKey: key) ?? defaultValue
   }

   public func getTestDefaults(forKey key: String, defaultValue: [TestDefaults]) -> [TestDefaults] {
      return getDecodable(key) ?? defaultValue
   }

   public func getTestDefaults(forKey key: String,  defaultValue: [String : TestDefaults]) -> [String : TestDefaults] {
      return getTestDefaults(forKey: key) ?? defaultValue
   }

   public func setTestDefaults(value: TestDefaults, forKey key: String) {
      set(value.encode(), forKey: key)
   }

   public func setTestDefaults(value: [TestDefaults], forKey key: String) {
      set(value.map { $0.encode() }, forKey: key)
   }

   public func setTestDefaults(value: [String : TestDefaults], forKey key: String) {
      set(value.map { $0.encode() }, forKey: key)
   }
}

//****************************************************************************//
// MARK: KVStore support
//****************************************************************************//
extension KVStore {

   public func getTestDefaults(forKey key: String) -> TestDefaults? {
      return getValue(forKey: key)
   }

   public func getTestDefaults(forKey key: String, defaultValue: TestDefaults) -> TestDefaults {
      return getTestDefaults(forKey: key) ?? defaultValue
   }

   public func getTestDefaultss(forKey key: String) -> [TestDefaults]? {
      return getValue(forKey: key)
   }

   public func getTestDefaultss(forKey key: String, defaultValue: [TestDefaults]) -> [TestDefaults] {
      return getTestDefaultss(forKey: key) ?? defaultValue
   }

   public func getTestDefaultsDictionary(forKey key: String) -> [String : TestDefaults]? {
      return getValue(forKey: key)
   }

   public func getTestDefaultsDictionary(forKey key: String, defaultValue: [String : TestDefaults]) -> [String : TestDefaults] {
      return getTestDefaultsDictionary(forKey: key) ?? defaultValue
   }
}

