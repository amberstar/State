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

public extension TestProtocol {

    public static func read(from store: Store) -> TestProtocol? {
        guard let typeKey: String = store.value(forKey: "TestProtocol") else { return nil }
        if let t = type(forKey: typeKey) {
            return t.read(from: store)
        }
        return nil
    }

    private static func type(forKey key: String) -> TestProtocol.Type? {
        switch key {

        case "TestProtocolConformer":
            return TestProtocolConformer.self

        default:
            return nil
        }
    }

}

