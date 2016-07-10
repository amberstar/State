/************************************************

        WARNING: MACHINE GENERATED FILE

 ************************************************/
import Foundation
import State

public enum Gender  : String, Model {

    case female  = "female"
    case male  = "male"

}

extension Gender {

   public static func read(from store: Store) -> Gender? {
      return self.init(with: store)
   }

    public init?(with inStore: Store) {
        let store = Gender.migrateIfNeeded(with: inStore)

        guard let value: String = store.value(forKey: "value") else { return nil }
        self.init(rawValue: value)
    }

    public func write(to store: inout Store) {
        store.set(self.rawValue, forKey: "value")
            Gender.writeVersion(with: store)
            finishWriting(to: &store)
    }
}

