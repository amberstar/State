/************************************************

        WARNING: MACHINE GENERATED FILE

 ************************************************/
import Foundation
import State

public protocol TestParentProtocol : Model  {

   var ss_number : String { get set }

}

public extension TestParentProtocol {

    public static func read(from store: Store) -> TestParentProtocol? {
        guard let typeKey: String = store.value(forKey: "TestParentProtocol") else { return nil }
        if let t = type(forKey: typeKey) {
            return t.read(from: store)
        }
        return nil
    }

    private static func type(forKey key: String) -> TestParentProtocol.Type? {
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

