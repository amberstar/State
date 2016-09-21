
//
// AUTO GENERATED FILE
// _TestProtocol.swift
//

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

extension Store {

    public func value(forKey key: String) -> TestProtocol? {
        guard let data : [String : Any] = value(forKey: key) else { return nil }
        return _decodeTestProtocol(data: data)
    }

    public func value(forKey key: String) -> [TestProtocol]? {
        guard let arrayv : [[String : Any]] = value(forKey: key) else { return nil }
        return sequence(arrayv.map { _decodeTestProtocol(data:$0) })
    }

    public func value(forKey key: String) -> [String : TestProtocol]? {
        guard let data : [String : [String : Any]] = value(forKey: key) else { return nil }
        return sequence(data.map { self._decodeTestProtocol(data:$0) })
    }

    public mutating func set(_ value: TestProtocol?, forKey key: String) {
        guard let value = value else { return }
        var vstore = Store()
        value.write(to: &vstore)
        set(vstore.data, forKey: key)
    }

    /// Add or update the value at key.
    public mutating func set(_ value: [TestProtocol]?, forKey key: String) {
        guard let value = value else { return }

        let data  = value.reduce([[String : Any]](), { (data, value) -> [[String: Any]] in
            var vstore = Store()
            var vdata = data
            value.write(to: &vstore )
            vdata.append(vstore.data)
            return vdata
        })

        set(data , forKey: key)
    }

    /// Add or update the value at key.
    public mutating func set(_ value: [String : TestProtocol]?, forKey key: String) {

        guard let value = value else { return }
        let data = value.reduce([String : [String : Any]](), { (data, element) -> [String : [String : Any]] in
            var vstore = Store()
            var vdata = data
            element.value.write(to: &vstore)
            vdata[element.key] = vstore.data
            return vdata
        })

        set(data, forKey: key)
    }

    private func _decodeTestProtocol(data: [String : Any]) -> TestProtocol? {
        guard let typeKey = data["TestParentProtocol"] as? String else { return nil }
        if let t = TestProtocolType(forKey: typeKey) {
            return t.read(from: Store(data: data))
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
