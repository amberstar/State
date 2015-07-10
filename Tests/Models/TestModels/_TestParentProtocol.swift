/************************************************

        WARNING: MACHINE GENERATED FILE

 ************************************************/
import Foundation
import State

public protocol TestParentProtocol : ModelProtocol {

   var ss_number : String { get set }

}

/// Mark: Decoding

public extension Decoder {

    public func decodeTestParentProtocol(key: String) -> TestParentProtocol? {
        let data = self.extractData()
        let d = data[key] as? [String : AnyObject]
        return d.flatMap(_decodeTestParentProtocol)
    }

    public func decodeTestParentProtocolArray(key: String) -> [TestParentProtocol]? {
        let data = self.extractData()
        let d = data[key] as? [[String : AnyObject]]
        return d.flatMap { sequence($0.map(_decodeTestParentProtocol)) }
    }

    public func decodeTestParentProtocolDictionary(key: String) -> [String : TestParentProtocol]? {
        let data = self.extractData()
        let d = data[key] as? [String : [String : AnyObject]]
        return d.flatMap { sequence($0.map(_decodeTestParentProtocol)) }
    }

    private func _decodeTestParentProtocol(data: [String : AnyObject]) -> TestParentProtocol? {
        if let t = TestParentProtocolTypeForKey(model_type_key) {
            return t.init(decoder: Decoder(data: data))
        }
        return nil
    }

    private func TestParentProtocolTypeForKey(key: String) -> TestParentProtocol.Type? {
        switch key {

        case "TestProtocolConformer":
            return TestProtocolConformer.self

        default:
            return nil
        }
    }
}

