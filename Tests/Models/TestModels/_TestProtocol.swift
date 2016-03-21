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

// Mark: Decoding

public extension DecoderType {

    public func decodeTestProtocol(key: String) -> TestProtocol? {
        let data = self.data
        let d = data[key] as? [String : AnyObject]
        return d.flatMap(_decodeTestProtocol)
    }

    public func decodeTestProtocol(key: String) -> [TestProtocol]? {
        let data = self.data
        let d = data[key] as? [[String : AnyObject]]
        return d.flatMap { sequence($0.map(_decodeTestProtocol)) }
    }

    public func decodeTestProtocol(key: String) -> [String : TestProtocol]? {
        let data = self.data
        let d = data[key] as? [String : [String : AnyObject]]
        return d.flatMap { sequence($0.map(_decodeTestProtocol)) }
    }

    private func _decodeTestProtocol(data: [String : AnyObject]) -> TestProtocol? {
        guard let dataTypeKey = data["TestParentProtocol"] as? String else { return nil }
        if let t = TestProtocolTypeForKey(dataTypeKey) {
            return t.decode(Decoder(data: data))
        }
        return nil
    }

    private func TestProtocolTypeForKey(key: String) -> TestProtocol.Type? {
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

extension KVStore {
   public func getTestProtocol(key: String) -> TestProtocol? {
      let keys = seperateKeypath(key)
      let targetKey = keys.keypath == nil ? self : getKey(keys.keypath!)

      if let targetKey = targetKey {
         return targetKey.container.decodeTestProtocol(keys.valueName)
      }
      else {
         return nil
      }
   }

   public func getTestProtocols(key: String) -> [TestProtocol]? {
      let keys = seperateKeypath(key)
      let targetKey = keys.keypath == nil ? self : getKey(keys.keypath!)

      if let targetKey = targetKey {
         return targetKey.container.decodeTestProtocol(keys.valueName)
      }
      else {
         return nil
      }
   }
}

