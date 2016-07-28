/************************************************

        WARNING: MACHINE GENERATED FILE

 ************************************************/
import Foundation
import State

public enum TestRegEnum  : Model {

    case cold 
    case hot

}

extension TestRegEnum {

    public static func read(from store: Store) -> TestRegEnum? {
      return self.init(with: store)
   }

    public init?(with inStore: Store) {
        let store = TestRegEnum.migrate(source: inStore)

        guard let type: String = store.value(forKey: "TestRegEnum") else { return nil }
        switch type {
                case "cold":
                   self = TestRegEnum.cold
                case "hot":
                   self = TestRegEnum.hot

                default:
                    return nil
        }

    }

    public func write(to store: inout Store) {

        switch self {
            case .cold:
                store.set("cold", forKey: "TestRegEnum")
            case .hot:
                store.set("hot", forKey: "TestRegEnum")

        }

            TestRegEnum.writeVersion(to: &store)
            finishWriting(to: &store)
    }
}

