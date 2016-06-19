/************************************************

        WARNING: MACHINE GENERATED FILE

 ************************************************/
import Foundation
import State

public protocol TestParentProtocol : Model  {

   var ss_number : String { get set }

}

func decodeTestParentProtocol(_ data: AnyObject?) -> TestParentProtocol? {

   if let data = data as? [String : AnyObject] {
      let decoder = Decoder(data: data)
      guard let dataTypeKey = data["TestParentProtocol"] as? String else { return nil }
      if let t = decoder.TestParentProtocolType(forKey: dataTypeKey) {
         return t.decode(decoder)
      }
      return nil
   }
   return nil
}

// Mark: Decoding

public extension DecoderType {

    public func decodeTestParentProtocol(_ key: String) -> TestParentProtocol? {
        let data = self.data
        let d = data[key] as? [String : AnyObject]
        return d.flatMap(_decodeTestParentProtocol)
    }

    public func decodeTestParentProtocol(_ key: String) -> [TestParentProtocol]? {
        let data = self.data
        let d = data[key] as? [[String : AnyObject]]
        return d.flatMap { sequence($0.map(_decodeTestParentProtocol)) }
    }

    public func decodeTestParentProtocol(_ key: String) -> [String : TestParentProtocol]? {
        let data = self.data
        let d = data[key] as? [String : [String : AnyObject]]
        return d.flatMap { sequence($0.map(_decodeTestParentProtocol)) }
    }

    private func _decodeTestParentProtocol(data: [String : AnyObject]) -> TestParentProtocol? {
        guard let dataTypeKey = data["TestParentProtocol"] as? String else { return nil }
        if let t = TestParentProtocolType(forKey: dataTypeKey) {
            return t.decode(Decoder(data: data))
        }
        return nil
    }

    private func TestParentProtocolType(forKey key: String) -> TestParentProtocol.Type? {
        switch key {

        case "TestProtocolConformer2":
            return TestProtocolConformer2.self

        case "TestProtocolConformer":
            return TestProtocolConformer.self

        default:
            return nil
        }
    }
}

// Mark: Encoding

public extension EncoderType {

    public func encode(element: TestParentProtocol?, _ key: String) {
        guard let element = element else { return }
        self.data[key] = element.encode()
    }

    public func encode(element: [TestParentProtocol]?, _ key: String) {
       guard let element = element else { return }
       self.data[key] = element.map { $0.encode() }
    }

    public func encode(element: [String : TestParentProtocol]?, _ key: String) {
        guard let element = element else { return }
        self.data[key] = element.map { $0.encode() }
    }
}

//****************************************************************************//
// MARK: UserDefault Support
//****************************************************************************//

extension UserDefaults {

   public func getTestParentProtocol(forKey key: String) -> TestParentProtocol? {
      guard let dictionary = dictionary(forKey: key) else { return nil }
      return decodeTestParentProtocol(dictionary)
   }

   public func getTestParentProtocol(forKey key: String) -> [TestParentProtocol]? {
      guard let array = array(forKey: key) else { return nil }
      return sequence(array.map(decodeTestParentProtocol))
   }

   public func getTestParentProtocol(forKey key: String) -> [String : TestParentProtocol]? {
      guard let dictionary = dictionary(forKey: key) else { return nil }
      return sequence(dictionary.map { decodeTestParentProtocol($0) })
   }

   public func getTestParentProtocol(forKey key: String, defaultValue: TestParentProtocol) -> TestParentProtocol {
      return getTestParentProtocol(forKey: key) ?? defaultValue
   }

   public func getTestParentProtocol(forKey key: String, defaultValue: [TestParentProtocol]) -> [TestParentProtocol] {
      return getTestParentProtocol(forKey: key) ?? defaultValue
   }

   public func getTestParentProtocol(forKey key: String,  defaultValue: [String : TestParentProtocol]
   ) -> [String : TestParentProtocol] {
      return getTestParentProtocol(forKey: key) ?? defaultValue
   }

   public func setTestParentProtocol(value: TestParentProtocol, forKey key: String) {
      set(value.encode(), forKey: key)
   }

   public func setTestParentProtocol(value: [TestParentProtocol], forKey key: String) {
      set(value.map { $0.encode() }, forKey: key)
   }

   public func setTestParentProtocol(value: [String : TestParentProtocol], forKey key: String) {
      set(value.map { $0.encode() }, forKey: key)
   }
}

//****************************************************************************//
// MARK: KVStore support
//****************************************************************************//
extension KVStore {
   public func getTestParentProtocol(forKey key: String) -> TestParentProtocol? {
      let keys = seperateKeypath(key)
      let targetKey = keys.keypath == nil ? self : getKey(keys.keypath!)

      if let targetKey = targetKey {
        return targetKey.decodeTestParentProtocol(keys.valueName)
      }
      else {
         return nil
      }
   }

   public func getTestParentProtocol(forKey key: String, defaultValue: TestParentProtocol) -> TestParentProtocol {
      return getTestParentProtocol(forKey: key) ?? defaultValue
   }

   public func getTestParentProtocols(forKey key: String) -> [TestParentProtocol]? {
      let keys = seperateKeypath(key)
      let targetKey = keys.keypath == nil ? self : getKey(keys.keypath!)

      if let targetKey = targetKey {
        return targetKey.decodeTestParentProtocol(keys.valueName)
      }
      else {
         return nil
      }
   }

   public func getTestParentProtocols(forKey key: String, defaultValue: [TestParentProtocol]) -> [TestParentProtocol] {
      return getTestParentProtocols(forKey: key) ?? defaultValue
   }

   public func getTestParentProtocolDictionary(forKey key: String) -> [String : TestParentProtocol]? {
      let keys = seperateKeypath(key)
      let targetKey = keys.keypath == nil ? self : getKey(keys.keypath!)

      if let targetKey = targetKey {
        return targetKey.decodeTestParentProtocol(keys.valueName)
      }
      else {
         return nil
      }
   }

   public func getTestParentProtocolDictionary(forKey key: String, defaultValue: [String : TestParentProtocol]) -> [String : TestParentProtocol] {
      return getTestParentProtocolDictionary(forKey: key) ?? defaultValue
   }

   public func setValue(value: TestParentProtocol, forKey: String) {
      let keys = seperateKeypath(forKey)

      let targetKey = keys.keypath == nil  ? self : addKey(keys.keypath!)
      targetKey.encode(value, keys.valueName)
   }

   public func setValue(value: [TestParentProtocol], forKey: String) {
      let keys = seperateKeypath(forKey)

      let targetKey = keys.keypath == nil  ? self : addKey(keys.keypath!)
      targetKey.encode(value, keys.valueName)
   }

   public func setValue(value: [String : TestParentProtocol], forKey: String) {
      let keys = seperateKeypath(forKey)

      let targetKey = keys.keypath == nil  ? self : addKey(keys.keypath!)
      targetKey.encode(value, keys.valueName)
   }

}

