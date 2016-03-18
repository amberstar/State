/************************************************

        WARNING: MACHINE GENERATED FILE

 ************************************************/
import Foundation
import State

public protocol TestParentProtocol : Model  {

   var ss_number : String { get set }

}

// Mark: Decoding

public extension Decoder {

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

public extension Encoder {

    public func encode(element: TestParentProtocol?, _ key: String) {
        element.apply { self.data[key] = $0.encode() }
    }

    public func encode(element: [TestParentProtocol]?, _ key: String) {
        element.apply { self.data[key] = $0.map { $0.encode() } }
    }

    public func encode(element: [String : TestParentProtocol]?, _ key: String) {
        element.apply { self.data[key] = $0.map { $0.encode() } }
    }
}

