
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
        guard let data : PropertyList = value(forKey: key) else { return nil }
        return _decodeTestProtocol(data: data)
    }

    public func value(forKey key: String) -> [TestProtocol]? {
        guard let arrayv : [PropertyList] = value(forKey: key) else { return nil }
        return sequence(arrayv.map { _decodeTestProtocol(data:$0) })
    }

    public func value(forKey key: String) -> [String : TestProtocol]? {
        guard let data : [String : PropertyList] = value(forKey: key) else { return nil }
        return sequence(data.map { self._decodeTestProtocol(data:$0) })
    }

    public mutating func set(_ value: TestProtocol?, forKey key: String) {
        guard let value = value else { return }
        set(value.properties, forKey: key)
    }

    /// Add or update the value at key.
    public mutating func set(_ value: [TestProtocol]?, forKey key: String) {
        guard let value = value else { return }

        let data  = value.reduce([[String : Any]](), { (data, value) -> [[String: Any]] in
            var d = data
            d.append(value.properties)
            return d
        })

        set(data , forKey: key)
    }

    /// Add or update the value at key.
    public mutating func set(_ value: [String : TestProtocol]?, forKey key: String) {

        guard let value = value else { return }
        let data = value.reduce([String : [String : Any]](), { (data, element) -> [String : [String : Any]] in
            var d = data
            d[element.key] = element.value.properties
            return d
        })

        set(data, forKey: key)
    }

    private func _decodeTestProtocol(data: PropertyList) -> TestProtocol? {
        guard let typeKey = data["TestParentProtocol"] as? String else { return nil }
        if let t = TestProtocolType(forKey: typeKey) {
            return t.init(with: Store(properties: data))
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
