import XCTest
import State


class KVStoreTests: Test {
    
    override func setUp() {
        super.setUp()
    }
    
    func createTestStoreContainer() -> KVStoreContainer {
        let store = KVStoreContainer()
        let model = Employee(name: "Test Employee", title: "Manager")
        
        store.set(value: false, forKey: "TestBool")
        store.set(value: 10, forKey: "TestInt")
        store.set(value: 24.5, forKey: "TestFloat")
        store.set(value: [true, false, true], forKey: "TestArrayBool")
        store.set(value: [10, 11, 12], forKey: "TestArrayInt")
        store.set(value: [22.5, 2, 11.4], forKey: "TestArrayFloat")
        store.set(value: ["Key" : false, "Key1" : true], forKey: "TestBoolDictionary")
        store.set(value: model, forKey: "TestModel")
        store.set(value: [model, model, model], forKey: "TestArrayModel")
        store.set(value: ["Key" : model, "Key1" : model], forKey: "TestDictionaryModel")
        
        return store
    }
    
    func saveAndLoadStore() -> KVStoreContainer? {
        let baseStore = createTestStoreContainer()
        
        baseStore.save(.Plist, path: tempPathFor("TestStore.plist"))
        let inStore = KVStoreContainer(.Plist, path: tempPathFor("TestStore.plist"))
        return inStore
    }
    
    
    func testSavingAndLoadingStore() {
        XCTAssertNotNil(saveAndLoadStore())
    }
    
    func testGettingValuesFromStore() {
        guard let store = saveAndLoadStore() else { XCTFail() ; return }
        
        XCTAssertNotNil(store.getValue(forKey: "TestBool"))
        
        let employees : [Employee]? = store.getValue(forKey: "TestArrayModel")
        XCTAssertNotNil(employees)
        XCTAssert(employees?[2].name == "Test Employee")
    }
}
