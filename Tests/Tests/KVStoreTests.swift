import XCTest
import State


class KVStoreTests: Test {
    
    override func setUp() {
        super.setUp()
    }
    
    func createTestStore() -> KVStore {
        let store = KVStore()
        let model = Employee(name: "Test Employee", title: "Manager")
        
        store.set(false, "TestBool")
        store.set(10, "TestInt")
        store.set(24.5, "TestFloat")
        store.set([true, false, true], "TestArrayBool")
        store.set([10, 11, 12], "TestArrayInt")
        store.set([22.5, 2, 11.4], "TestArrayFloat")
        store.set(["Key" : false, "Key1" : true], "TestBoolDictionary")
        store.set(model, "TestModel")
        store.set([model, model, model], "TestArrayModel")
        store.set(["Key" : model, "Key1" : model], "TestDictionaryModel")
        
        return store
    }
    
    func saveAndLoadStore() -> KVStore? {
        let baseStore = createTestStore()
        
        baseStore.save(.Plist, path: tempPathFor("TestStore.plist"))
        let inStore = KVStore(.Plist, path: tempPathFor("TestStore.plist"))
        return inStore
    }
    
    
    func testSavingAndLoadingStore() {
        XCTAssertNotNil(saveAndLoadStore())
    }
    
    func testGettingValuesFromStore() {
        guard let store = saveAndLoadStore() else { XCTFail() ; return }
        
        XCTAssertNotNil(store.get("TestBool"))
        
        let employees : [Employee]? = store.get("TestArrayModel")
        XCTAssertNotNil(employees)
        XCTAssert(employees?[2].name == "Test Employee")
    }
}
