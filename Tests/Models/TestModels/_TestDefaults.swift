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

   public static func decode(decoder: Decoder) -> TestDefaults? {
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
        didFinishDecodingWithDecoder(decoder)
    }
}

extension TestDefaults : Encodable {

    public func encode(encoder: Encoder) {
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

        self.willFinishEncodingWithEncoder(encoder)
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

extension NSUserDefaults {

   //****************************************************************************//
   // MARK: NSUserDefault Getters
   //****************************************************************************//

   public func getTestDefaults(key: String) -> TestDefaults? {
      guard let dictionary = dictionaryForKey(key) else { return nil }
      return TestDefaults.decode(dictionary)
   }

   public func getTestDefaults(key: String) -> [TestDefaults]? {
      guard let array = arrayForKey(key) else { return nil }
      return sequence(array.map(TestDefaults.decode))
   }

   public func getTestDefaults(key: String) -> [String : TestDefaults]? {
      guard let dictionary = dictionaryForKey(key) else { return nil }
      return sequence(dictionary.map { TestDefaults.decode($0) })
   }

   public func getTestDefaults(key: String, defaultValue: TestDefaults) -> TestDefaults {
      return getTestDefaults(key) ?? defaultValue
   }

   public func getTestDefaults(key: String, defaultValue: [TestDefaults]) -> [TestDefaults] {
      return getDecodable(key) ?? defaultValue
   }

   public func getTestDefaults(key: String,  defaultValue: [String : TestDefaults]
   ) -> [String : TestDefaults] {
      return getTestDefaults(key) ?? defaultValue
   }

   //****************************************************************************//
   // MARK: NSUserDefault Setters
   //****************************************************************************//

   public func setTestDefaults(value: TestDefaults, forKey key: String) {
      setObject(value.encode(), forKey: key)
   }

   public func setTestDefaults(value: [TestDefaults], forKey key: String) {
      setObject(value.map { $0.encode() }, forKey: key)
   }

   public func setTestDefaults(value: [String : TestDefaults], forKey key: String) {
      setObject(value.map { $0.encode() }, forKey: key)
   }
}

extension KVStore {

   public func getTestDefaults(key: String) -> TestDefaults? {
      return getValue(key)
   }

   public func getTestDefaults(key: String, defaultValue: TestDefaults) -> TestDefaults {
      return getTestDefaults(key) ?? defaultValue
   }

   public func getTestDefaultss(key: String) -> [TestDefaults]? {
      return getValue(key)
   }

   public func getTestDefaultss(key: String, defaultValue: [TestDefaults]) -> [TestDefaults] {
      return getTestDefaultss(key) ?? defaultValue
   }

   public func getTestDefaultsDictionary(key: String) -> [String : TestDefaults]? {
      return getValue(key)
   }

   public func getTestDefaultsDictionary(key: String, defaultValue: [String : TestDefaults]) -> [String : TestDefaults] {
      return getTestDefaultsDictionary(key) ?? defaultValue
   }
}

