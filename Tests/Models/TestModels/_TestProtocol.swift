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
        guard let dataTypeKey = data["TestParentProtocol"] as? String else { return nil }
        if let t = TestProtocolTypeForKey(dataTypeKey) {
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

// Mark: Encoding

public extension Encoder {

    public func encode(element: TestProtocol?, _ key: String) {
        element.apply { self.data[key] = $0.encode() }
    }

    public func encode(element: [TestProtocol]?, _ key: String) {
        element.apply { self.data[key] = $0.map { $0.encode() } }
    }

    public func encode(element: [String : TestProtocol]?, _ key: String) {
        element.apply { self.data[key] = $0.map { $0.encode() } }
    }
}

