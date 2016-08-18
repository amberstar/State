
//
// AUTO GENERATED FILE
// _TestOverrideType.swift
//

import Foundation
import State

public struct TestOverrideType : Model {
    public var myURL: URL?
    public var myArrayOfString: [String]?

}

extension TestOverrideType  {

    public static func read(from store: Store) -> TestOverrideType? {
      return self.init(with: store)
   }

    public init?(with inStore: Store) {
        let store = TestOverrideType.migrate(source: inStore)

        let myURL: URL? = store.value(forKey: "myURL")
        let myArrayOfString: [String]? = store.value(forKey: "myArrayOfString")

        self.myURL = myURL
        self.myArrayOfString = myArrayOfString
        finishReading(from: store)
    }

    public func write(to store: inout Store) {
        store.set(myURL, forKey: "myURL")
        store.set(myArrayOfString, forKey: "myArrayOfString")

        TestOverrideType.writeVersion(to: &store)
        finishWriting(to: &store)
    }
}

