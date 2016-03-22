/************************************************

        WARNING: MACHINE GENERATED FILE

 ************************************************/
import Foundation
import State

public protocol TestParentProtocol : Model  {

   var ss_number : String { get set }

}

// Mark: Decoding

public extension DecoderType {

    public func decodeTestParentProtocol(key: String) -> TestParentProtocol? {
        let data = self.data
        let d = data[key] as? [String : AnyObject]
        return d.flatMap(_decodeTestParentProtocol)
    }

    public func decodeTestParentProtocol(key: String) -> [TestParentProtocol]? {
        let data = self.data
        let d = data[key] as? [[String : AnyObject]]
        return d.flatMap { sequence($0.map(_decodeTestParentProtocol)) }
    }

    public func decodeTestParentProtocol(key: String) -> [String : TestParentProtocol]? {
        let data = self.data
        let d = data[key] as? [String : [String : AnyObject]]
        return d.flatMap { sequence($0.map(_decodeTestParentProtocol)) }
    }

    private func _decodeTestParentProtocol(data: [String : AnyObject]) -> TestParentProtocol? {
        guard let dataTypeKey = data["TestParentProtocol"] as? String else { return nil }
        if let t = TestParentProtocolTypeForKey(dataTypeKey) {
            return t.decode(Decoder(data: data))
        }
        return nil
    }

    private func TestParentProtocolTypeForKey(key: String) -> TestParentProtocol.Type? {
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

extension KVStore {
   public func getTestParentProtocol(key: String) -> TestParentProtocol? {
      let keys = seperateKeypath(key)
      let targetKey = keys.keypath == nil ? self : getKey(keys.keypath!)

      if let targetKey = targetKey {
         return targetKey.container.decodeTestParentProtocol(keys.valueName)
      }
      else {
         return nil
      }
   }

   public func getTestParentProtocol(key: String, defaultValue: TestParentProtocol) -> TestParentProtocol {
      return getTestParentProtocol(key) ?? defaultValue
   }

   public func getTestParentProtocols(key: String) -> [TestParentProtocol]? {
      let keys = seperateKeypath(key)
      let targetKey = keys.keypath == nil ? self : getKey(keys.keypath!)

      if let targetKey = targetKey {
         return targetKey.container.decodeTestParentProtocol(keys.valueName)
      }
      else {
         return nil
      }
   }

   public func getTestParentProtocols(key: String, defaultValue: [TestParentProtocol]) -> [TestParentProtocol] {
      return getTestParentProtocols(key) ?? defaultValue
   }

   public func getTestParentProtocolDictionary(key: String) -> [String : TestParentProtocol]? {
      let keys = seperateKeypath(key)
      let targetKey = keys.keypath == nil ? self : getKey(keys.keypath!)

      if let targetKey = targetKey {
         return targetKey.container.decodeTestParentProtocol(keys.valueName)
      }
      else {
         return nil
      }
   }

   public func getTestParentProtocolDictionary(key: String, defaultValue: [String : TestParentProtocol]) -> [String : TestParentProtocol] {
      return getTestParentProtocolDictionary(key) ?? defaultValue
   }

   public func setValue(value: TestParentProtocol, forKey: String) {
      let keys = seperateKeypath(forKey)

      let targetKey = keys.keypath == nil  ? self : createKey(keys.keypath!)
      targetKey.container.encode(value, keys.valueName)
   }

   public func setValue(value: [TestParentProtocol], forKey: String) {
      let keys = seperateKeypath(forKey)

      let targetKey = keys.keypath == nil  ? self : createKey(keys.keypath!)
      targetKey.container.encode(value, keys.valueName)
   }

   public func setValue(value: [String : TestParentProtocol], forKey: String) {
      let keys = seperateKeypath(forKey)

      let targetKey = keys.keypath == nil  ? self : createKey(keys.keypath!)
      targetKey.container.encode(value, keys.valueName)
   }

}

