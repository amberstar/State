import XCTest
import State


class KVStoreTests: Test {
    
    override func setUp() {
        super.setUp()
    }
    
    func createTestStore() -> KVStore {
        var store = KVStore()
        let model = Employee(name: "Test Employee", title: "Manager")
        
        store.setValue("TestBool", false )
        store.setValue("TestInt", 10 )
        store.setValue("TestFloat", 24.5)
        store.setValue("TestArrayBool", [true, false, true])
        store.setValue("TestArrayInt", [10, 11, 12])
        store.setValue("TestArrayFloat", [22.5, 2, 11.4])
        store.setValue("TestBoolDictionary", ["Key" : false, "Key1" : true])
        store.setValue("TestModel", model)
        store.setValue("TestArrayModel", [model, model, model])
        store.setValue("TestDictionaryModel", ["Key" : model, "Key1" : model])
        
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
        
        XCTAssertNotNil(store.value("TestBool"))
        
        let employees : [Employee]? = store.value("TestArrayModel")
        XCTAssertNotNil(employees)
        XCTAssert(employees?[2].name == "Test Employee")
    }
}
