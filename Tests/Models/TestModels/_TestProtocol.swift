/************************************************

        WARNING: MACHINE GENERATED FILE

 ************************************************/
import Foundation
import State

public protocol TestProtocol : TestParentProtocol {

   var age : Int? { get set }
   var name : String { get }

   var children : [TestChild] { get set }
   var grandchild : Grandchild { get }

}

/// Mark: Decoding

public extension Decoder {

    public func decodeTestProtocol(key: String) -> TestProtocol? {
        let data = self.extractData()
        let d = data[key] as? [String : AnyObject]
        return d.flatMap(_decodeTestProtocol)
    }

    public func decodeTestProtocolArray(key: String) -> [TestProtocol]? {
        let data = self.extractData()
        let d = data[key] as? [[String : AnyObject]]
        return d.flatMap { sequence($0.map(_decodeTestProtocol)) }
    }

    public func decodeTestProtocolDictionary(key: String) -> [String : TestProtocol]? {
        let data = self.extractData()
        let d = data[key] as? [String : [String : AnyObject]]
        return d.flatMap { sequence($0.map(_decodeTestProtocol)) }
    }

    private func _decodeTestProtocol(data: [String : AnyObject]) -> TestProtocol? {
        if let t = TestProtocolTypeForKey(model_type_key) {
            return t.init(decoder: Decoder(data: data))
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

