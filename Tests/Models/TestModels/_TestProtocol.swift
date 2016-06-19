/************************************************

        WARNING: MACHINE GENERATED FILE

 ************************************************/
import Foundation
import State

public protocol TestProtocol : TestParentProtocol  {

   var age : Int? { get set }
   var name : String { get }
   var children : [TestChild] { get set }
   var grandchild : Grandchild { get }

   func calculateAge() -> Int
   func getFullName() -> String

}

func decodeTestProtocol(_ data: AnyObject?) -> TestProtocol? {

   if let data = data as? [String : AnyObject] {
      let decoder = Decoder(data: data)
      guard let dataTypeKey = data["TestProtocol"] as? String else { return nil }
      if let t = decoder.TestProtocolType(forKey: dataTypeKey) {
         return t.decode(decoder)
      }
      return nil
   }
   return nil
}

// Mark: Decoding

public extension DecoderType {

    public func decodeTestProtocol(_ key: String) -> TestProtocol? {
        let data = self.data
        let d = data[key] as? [String : AnyObject]
        return d.flatMap(_decodeTestProtocol)
    }

    public func decodeTestProtocol(_ key: String) -> [TestProtocol]? {
        let data = self.data
        let d = data[key] as? [[String : AnyObject]]
        return d.flatMap { sequence($0.map(_decodeTestProtocol)) }
    }

    public func decodeTestProtocol(_ key: String) -> [String : TestProtocol]? {
        let data = self.data
        let d = data[key] as? [String : [String : AnyObject]]
        return d.flatMap { sequence($0.map(_decodeTestProtocol)) }
    }

    private func _decodeTestProtocol(data: [String : AnyObject]) -> TestProtocol? {
        guard let dataTypeKey = data["TestParentProtocol"] as? String else { return nil }
        if let t = TestProtocolType(forKey: dataTypeKey) {
            return t.decode(Decoder(data: data))
        }
        return nil
    }

    private func TestProtocolType(forKey key: String) -> TestProtocol.Type? {
        switch key {

        case "TestProtocolConformer":
            return TestProtocolConformer.self

        default:
            return nil
        }
    }
}

// Mark: Encoding

public extension EncoderType {

    public func encode(element: TestProtocol?, _ key: String) {
        guard let element = element else { return }
        self.data[key] = element.encode()
    }

    public func encode(element: [TestProtocol]?, _ key: String) {
       guard let element = element else { return }
       self.data[key] = element.map { $0.encode() }
    }

    public func encode(element: [String : TestProtocol]?, _ key: String) {
        guard let element = element else { return }
        self.data[key] = element.map { $0.encode() }
    }
}

//****************************************************************************//
// MARK: UserDefault Support
//****************************************************************************//

extension UserDefaults {

   public func getTestProtocol(forKey key: String) -> TestProtocol? {
      guard let dictionary = dictionary(forKey: key) else { return nil }
      return decodeTestProtocol(dictionary)
   }

   public func getTestProtocol(forKey key: String) -> [TestProtocol]? {
      guard let array = array(forKey: key) else { return nil }
      return sequence(array.map(decodeTestProtocol))
   }

   public func getTestProtocol(forKey key: String) -> [String : TestProtocol]? {
      guard let dictionary = dictionary(forKey: key) else { return nil }
      return sequence(dictionary.map { decodeTestProtocol($0) })
   }

   public func getTestProtocol(forKey key: String, defaultValue: TestProtocol) -> TestProtocol {
      return getTestProtocol(forKey: key) ?? defaultValue
   }

   public func getTestProtocol(forKey key: String, defaultValue: [TestProtocol]) -> [TestProtocol] {
      return getTestProtocol(forKey: key) ?? defaultValue
   }

   public func getTestProtocol(forKey key: String,  defaultValue: [String : TestProtocol]
   ) -> [String : TestProtocol] {
      return getTestProtocol(forKey: key) ?? defaultValue
   }

   public func setTestProtocol(value: TestProtocol, forKey key: String) {
      set(value.encode(), forKey: key)
   }

   public func setTestProtocol(value: [TestProtocol], forKey key: String) {
      set(value.map { $0.encode() }, forKey: key)
   }

   public func setTestProtocol(value: [String : TestProtocol], forKey key: String) {
      set(value.map { $0.encode() }, forKey: key)
   }
}

//****************************************************************************//
// MARK: KVStore support
//****************************************************************************//
extension KVStore {
   public func getTestProtocol(forKey key: String) -> TestProtocol? {
      let keys = seperateKeypath(key)
      let targetKey = keys.keypath == nil ? self : getKey(keys.keypath!)

      if let targetKey = targetKey {
        return targetKey.decodeTestProtocol(keys.valueName)
      }
      else {
         return nil
      }
   }

   public func getTestProtocol(forKey key: String, defaultValue: TestProtocol) -> TestProtocol {
      return getTestProtocol(forKey: key) ?? defaultValue
   }

   public func getTestProtocols(forKey key: String) -> [TestProtocol]? {
      let keys = seperateKeypath(key)
      let targetKey = keys.keypath == nil ? self : getKey(keys.keypath!)

      if let targetKey = targetKey {
        return targetKey.decodeTestProtocol(keys.valueName)
      }
      else {
         return nil
      }
   }

   public func getTestProtocols(forKey key: String, defaultValue: [TestProtocol]) -> [TestProtocol] {
      return getTestProtocols(forKey: key) ?? defaultValue
   }

   public func getTestProtocolDictionary(forKey key: String) -> [String : TestProtocol]? {
      let keys = seperateKeypath(key)
      let targetKey = keys.keypath == nil ? self : getKey(keys.keypath!)

      if let targetKey = targetKey {
        return targetKey.decodeTestProtocol(keys.valueName)
      }
      else {
         return nil
      }
   }

   public func getTestProtocolDictionary(forKey key: String, defaultValue: [String : TestProtocol]) -> [String : TestProtocol] {
      return getTestProtocolDictionary(forKey: key) ?? defaultValue
   }

   public func setValue(value: TestProtocol, forKey: String) {
      let keys = seperateKeypath(forKey)

      let targetKey = keys.keypath == nil  ? self : addKey(keys.keypath!)
      targetKey.encode(value, keys.valueName)
   }

   public func setValue(value: [TestProtocol], forKey: String) {
      let keys = seperateKeypath(forKey)

      let targetKey = keys.keypath == nil  ? self : addKey(keys.keypath!)
      targetKey.encode(value, keys.valueName)
   }

   public func setValue(value: [String : TestProtocol], forKey: String) {
      let keys = seperateKeypath(forKey)

      let targetKey = keys.keypath == nil  ? self : addKey(keys.keypath!)
      targetKey.encode(value, keys.valueName)
   }

}

