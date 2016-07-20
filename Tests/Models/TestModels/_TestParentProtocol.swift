/************************************************

        WARNING: MACHINE GENERATED FILE

 ************************************************/
import Foundation
import State

public protocol TestParentProtocol : Model  {

   var ss_number : String { get set }

}

extension Store {

    public func value(forKey key: String) -> TestParentProtocol? {
        guard let data : [String : AnyObject] = value(forKey: key) else { return nil }
        return _decodeTestParentProtocol(data: data)
    }

    public func value(forKey key: String) -> [TestParentProtocol]? {
        guard let arrayv : [[String : AnyObject]] = value(forKey: key) else { return nil }
        return sequence(arrayv.map { _decodeTestParentProtocol(data:$0) })
    }

    public func value(forKey key: String) -> [String : TestParentProtocol]? {
        guard let data : [String : [String : AnyObject]] = value(forKey: key) else { return nil }
        return sequence(data.map { self._decodeTestParentProtocol(data:$0) })
    }

    public mutating func set(_ value: TestParentProtocol?, forKey key: String) {
        guard let value = value else { return }
        var vstore = Store()
        value.write(to: &vstore)
        set(vstore.data, forKey: key)
    }

    /// Add or update the value at key.
    public mutating func set(_ value: [TestParentProtocol]?, forKey key: String) {
        guard let value = value else { return }

        let data  = value.reduce([[String : AnyObject]](), combine: { (data, value) -> [[String: AnyObject]] in
            var vstore = Store()
            var vdata = data
            value.write(to: &vstore )
            vdata.append(vstore.data)
            return vdata
        })

        set(data , forKey: key)
    }

    /// Add or update the value at key.
    public mutating func set(_ value: [String : TestParentProtocol]?, forKey key: String) {

        guard let value = value else { return }
        let data = value.reduce([String : [String : AnyObject]](), combine: { (data, element) -> [String : [String : AnyObject]] in
            var vstore = Store()
            var vdata = data
            element.value.write(to: &vstore)
            vdata[element.key] = vstore.data
            return vdata
        })

        set(data, forKey: key)
    }

    private func _decodeTestParentProtocol(data: [String : AnyObject]) -> TestParentProtocol? {
        guard let typeKey = data["TestParentProtocol"] as? String else { return nil }
        if let t = TestParentProtocolType(forKey: typeKey) {
            return t.read(from: Store(data: data))
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
