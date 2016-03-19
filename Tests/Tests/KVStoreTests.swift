import XCTest
import State


class KVStoreTests: Test {
    
    override func setUp() {
        super.setUp()
    }
   
   func testGetKeyThatDoesNotExsistShouldReturnNil() {
      let store = KVStore()
      let result = store.getKey("InvalidKey")
      XCTAssert(result == nil)
   }
   
   func testGetKeyReturnsKey() {
      let store = KVStore()
      store.createKey("A.B.C.D")
      XCTAssertNotNil(store.getKey("A.B.C"))
   }
   
   func testCreateKeyOneLevelDeepShouldCreateKey() {
      let store = KVStore()
      store.createKey("Level1")
      let resultKey = store.getKey("Level1")
      XCTAssertNotNil(resultKey)
   }
   
   func testCreateKeyMultiLevelsDeepShouldCreateKeys() {
      let store = KVStore()
      store.createKey("Level1.Level2.Level3")
   
      let resultKey1 = store.getKey("Level1")
      XCTAssertNotNil(resultKey1)
      
      let resultKey2 = store.getKey("Level1.Level2")
      XCTAssertNotNil(resultKey2)
      
      let resultKey3 = store.getKey("Level1.Level2.Level3")
      XCTAssertNotNil(resultKey3)
   }
   
   func testCreatingKeyThatExsistsReturnsExsitingKey() {
      let store = KVStore()
      store.createKey("A.B.C.D")
      let cKey = store.getKey("A.B.C")
      let createdKey = store.createKey("A.B.C")
      XCTAssert(cKey === createdKey)
   }
   
   func testUpdatingKeyWithNewKeyReplacesAndReturnsOldKey() {
      let store = KVStore()
      store.createKey("A.B.C.D")
      let oldKey = store.getKey("A.B.C")
      let newKey = KVStore()
      let returnedKey = store.updateKey("A.B.C", newKey: newKey)
      XCTAssert(store.getKey("A.B.C") === newKey)
      XCTAssert(returnedKey === oldKey)
   }
   
   
   func testRemovingKeyThatDoesNotExsistReturnsNil() {
      let store = KVStore()
      XCTAssertNil(store.removeKey("A.B.C"))
   }
   
   func testRemovingKeyReturnsRemovedKeyAndIsRemoved() {
      let store = KVStore()
      store.createKey("A.B.C.D")
      let lastKey = store.getKey("A.B.C.D")
      let removedKey = store.removeKey("A.B.C.D")
      XCTAssert(lastKey === removedKey)
      let firstKey = store.getKey("A")
      store.removeKey("C")
      store.removeKey("B")
      let removedFirstKey = store.removeKey("A")
      XCTAssert(removedFirstKey === firstKey)
   }

   func testSettingAValueOneLevelYieldsValue() {
      let store = KVStore()
      store.setValue(10, forKey: "TestValue")
      
      let value = store.values["TestValue"] as! Int
      debugPrint(value)
      
     XCTAssert(value == 10)
   }
   
   func testSettingAValueMultiLevelsYieldsValue() {
      let store = KVStore()
      store.setValue(20, forKey:"A.B.C.TestValue")
      
      if let key = store.getKey("A.B.C") {
         let value = key.values["TestValue"] as! Int
         XCTAssert(value == 20)
      }
      else {
         XCTFail()
      }
   }
   
   func testGettingAValueOneLevelYieldsValue() {
      let store = KVStore()
      store.setValue(10, forKey: "TestValue")
      let result : Int?  = store.getValue("TestValue")
      
      XCTAssert(result == 10)
   }
   
   func testGettingAValueMultiLevelYieldsValue() {
      let store = KVStore()
      store.setValue(10, forKey: "A.B.C.TestValue")
      let targetKey = store.getKey("A.B.C")
      let result : Int?  = targetKey?.getValue("TestValue")
      
      XCTAssert(result == 10)
   }
   
   func testGettingADefaultValueYieldsCorrectValue() {
      let store = KVStore()
      let result = store.getValue("InvalidKey", defaultValue: 44)
      XCTAssert(result == 44)
      
      store.setValue(42, forKey: "ValidKey")
      let result2 = store.getValue("ValidKey", defaultValue: 44)
      XCTAssert(result2 == 42)
   }
   
   
//    func createTestStoreContainer() -> KVStoreContainer {
//        let store = KVStoreContainer()
//        let model = Employee(name: "Test Employee", title: "Manager")
//        
//        store.set(value: false, forKey: "TestBool")
//        store.set(value: 10, forKey: "TestInt")
//        store.set(value: 24.5, forKey: "TestFloat")
//        store.set(value: [true, false, true], forKey: "TestArrayBool")
//        store.set(value: [10, 11, 12], forKey: "TestArrayInt")
//        store.set(value: [22.5, 2, 11.4], forKey: "TestArrayFloat")
//        store.set(value: ["Key" : false, "Key1" : true], forKey: "TestBoolDictionary")
//        store.set(value: model, forKey: "TestModel")
//        store.set(value: [model, model, model], forKey: "TestArrayModel")
//        store.set(value: ["Key" : model, "Key1" : model], forKey: "TestDictionaryModel")
//        
//        return store
//    }
//    
//    func saveAndLoadStore() -> KVStoreContainer? {
//        let baseStore = createTestStoreContainer()
//        
//        baseStore.save(.Plist, path: tempPathFor("TestStore.plist"))
//        let inStore = KVStoreContainer(.Plist, path: tempPathFor("TestStore.plist"))
//        return inStore
//    }
//    
//    
//    func testSavingAndLoadingStore() {
//        XCTAssertNotNil(saveAndLoadStore())
//    }
//    
//    func testGettingValuesFromStore() {
//        guard let store = saveAndLoadStore() else { XCTFail() ; return }
//        
//        XCTAssertNotNil(store.getValue(forKey: "TestBool"))
//        
//        let employees : [Employee]? = store.getValue(forKey: "TestArrayModel")
//        XCTAssertNotNil(employees)
//        XCTAssert(employees?[2].name == "Test Employee")
//    }
}
