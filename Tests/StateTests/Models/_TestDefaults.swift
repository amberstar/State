
//
// AUTO GENERATED FILE
// _TestDefaults.swift
//

import Foundation
import State

public struct TestDefaults : Model  {
    public var defaultManualString = "defaultManualString"
    public var defaultArray = ["zero", "one", "two"]
    public var defaultString = "defaultString"
    public var defaultInt = 10
    public var noDefaultInt: Int?
    public var noDefaultString: String?
    public var defaultEmptyArray = [String]()
    public var defaultChildren = [TestDefaultsChild]()
    public var defaultChild = TestDefaultsChild()
    public var noDefaultChild: TestDefaultsChild?
    public var noDefaultChildren: TestDefaultsChild?

}

extension TestDefaults  {

    public init?(with source: Store) {
        let store = TestDefaults.migrate(source: source)

         guard
            let defaultManualString: String = store.value(forKey: "defaultManualString"),
            let defaultArray: [String] = store.value(forKey: "defaultArray"),
            let defaultString: String = store.value(forKey: "defaultString"),
            let defaultInt: Int = store.value(forKey: "defaultInt"),
            let defaultEmptyArray: [String] = store.value(forKey: "defaultEmptyArray"),
            let defaultChildren: [TestDefaultsChild] = store.value(forKey: "defaultChildren"),
            let defaultChild: TestDefaultsChild = store.value(forKey: "defaultChild")
         else { return  nil }

        let noDefaultInt: Int? = store.value(forKey: "noDefaultInt")
        let noDefaultString: String? = store.value(forKey: "noDefaultString")

        let noDefaultChild: TestDefaultsChild? = store.value(forKey: "noDefaultChild")
        let noDefaultChildren: TestDefaultsChild? = store.value(forKey: "noDefaultChildren")

        self.defaultManualString = defaultManualString
        self.defaultArray = defaultArray
        self.defaultString = defaultString
        self.defaultInt = defaultInt
        self.noDefaultInt = noDefaultInt
        self.noDefaultString = noDefaultString
        self.defaultEmptyArray = defaultEmptyArray
        self.defaultChildren = defaultChildren
        self.defaultChild = defaultChild
        self.noDefaultChild = noDefaultChild
        self.noDefaultChildren = noDefaultChildren
        finishReading(from: store)
    }

// MARK: - Storeable

    public static func restore(from store: Store) -> TestDefaults? {
        return self.init(with: store)
    }

    public func store(to store: inout Store) {
        store.set(defaultManualString, forKey: "defaultManualString")
        store.set(defaultArray, forKey: "defaultArray")
        store.set(defaultString, forKey: "defaultString")
        store.set(defaultInt, forKey: "defaultInt")
        store.set(noDefaultInt, forKey: "noDefaultInt")
        store.set(noDefaultString, forKey: "noDefaultString")
        store.set(defaultEmptyArray, forKey: "defaultEmptyArray")
        store.set(defaultChildren, forKey: "defaultChildren")
        store.set(defaultChild, forKey: "defaultChild")
        store.set(noDefaultChild, forKey: "noDefaultChild")
        store.set(noDefaultChildren, forKey: "noDefaultChildren")

        TestDefaults.writeVersion(to: &store)
        finishWriting(to: &store)
    }
}

