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
      store.addKey("A.B.C.D")
      XCTAssertNotNil(store.getKey("A.B.C"))
   }
   
   func testCreateKeyOneLevelDeepShouldCreateKey() {
      let store = KVStore()
      store.addKey("Level1")
      let resultKey = store.getKey("Level1")
      XCTAssertNotNil(resultKey)
   }
   
   func testCreateKeyMultiLevelsDeepShouldCreateKeys() {
      let store = KVStore()
      store.addKey("Level1.Level2.Level3")
   
      let resultKey1 = store.getKey("Level1")
      XCTAssertNotNil(resultKey1)
      
      let resultKey2 = store.getKey("Level1.Level2")
      XCTAssertNotNil(resultKey2)
      
      let resultKey3 = store.getKey("Level1.Level2.Level3")
      XCTAssertNotNil(resultKey3)
   }
   
   func testCreatingKeyThatExsistsReturnsExsitingKey() {
      let store = KVStore()
      store.addKey("A.B.C.D")
      let cKey = store.getKey("A.B.C")
      let createdKey = store.addKey("A.B.C")
      XCTAssert(cKey === createdKey)
   }
   
   func testUpdatingKeyWithNewKeyReplacesAndReturnsOldKey() {
      let store = KVStore()
      store.addKey("A.B.C.D")
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
      store.addKey("A.B.C.D")
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
      
      let value = store.data["TestValue"] as! Int
      debugPrint(value)
      
     XCTAssert(value == 10)
   }
   
   func testSettingAValueMultiLevelsYieldsValue() {
      let store = KVStore()
      store.setValue(20, forKey:"A.B.C.TestValue")
      
      if let key = store.getKey("A.B.C") {
         let value = key.data["TestValue"] as! Int
         XCTAssert(value == 20)
      }
      else {
         XCTFail()
      }
   }
   
   func testGettingAValueOneLevelYieldsValue() {
      let store = KVStore()
      store.setValue(10, forKey: "TestValue")
    let result : Int?  = store.getValue(forKey: "TestValue")
      
      XCTAssert(result == 10)
   }
   
   func testGettingAValueMultiLevelYieldsValue() {
      let store = KVStore()
      store.setValue(10, forKey: "A.B.C.TestValue")
      let targetKey = store.getKey("A.B.C")
    let result : Int?  = targetKey?.getValue(forKey: "TestValue")
      
      XCTAssert(result == 10)
   }
   
   func testGettingADefaultValueYieldsCorrectValue() {
      let store = KVStore()
    let result = store.getValue(forKey: "InvalidKey", defaultValue: 44)
      XCTAssert(result == 44)
      
      store.setValue(42, forKey: "ValidKey")
    let result2 = store.getValue(forKey: "ValidKey", defaultValue: 44)
      XCTAssert(result2 == 42)
   }
   
   func testDecodables() {
      let employee = Employee(name: "Fred", title: "President")
      let employee2 = Employee(name: "Alice", title: nil)
      let company = Company(name: "TestCompany", yearFounded: 2014, phoneNumber: "860-222-1234", employees: [employee, employee2])
      
      let employeeArray = [employee, employee2]
      let employeeDict = ["Fred" : employee, "Alice" : employee2]
      
      let store = KVStore()
      
      store.setValue(employee, forKey: "employees.instance")
      store.setValue(employeeArray, forKey: "employees.array")
      store.setValue(employeeDict, forKey: "employees.dict")
      store.setValue(company, forKey: "company")
      
      store.save(tempPathFor("Test.plist"))
      
      let inputStore = KVStore.load(tempPathFor("Test.plist"))
      
      XCTAssertNotNil(inputStore)
      
    let inEmployee : Employee? = inputStore?.getValue(forKey: "employees.instance")
      XCTAssertNotNil(inEmployee)
      XCTAssert(inEmployee?.name == "Fred")
      
    let inEmployeeArray : [Employee]? = inputStore?.getValue(forKey: "employees.array")
      XCTAssertNotNil(inEmployeeArray)
      XCTAssert(inEmployeeArray?.count == 2)
      
    let inEmployeeDict : [String : Employee]? = inputStore?.getValue(forKey: "employees.dict")
      XCTAssertNotNil(inEmployeeDict)
      XCTAssert(inEmployeeDict?.count == 2)
      XCTAssert(inEmployeeDict?["Alice"]?.name == "Alice")
      
    let inCompany : Company? = inputStore?.getValue(forKey: "company")
      XCTAssertNotNil(inCompany)
      XCTAssert(inCompany?.employees?.count == 2)
   }
   
   func testBasicGetters() {
      let testBool: Bool = true
      let testInt : Int = 42
      let testDouble: Double = 3.14
      let testFloat: Float = 0.001
      let testString: String = "Hello"
      
      let store = KVStore()
      
      store.setValue(testBool, forKey: "testBool")
      store.setValue(testInt, forKey: "testInt")
      store.setValue(testDouble, forKey: "testDouble")
      store.setValue(testFloat, forKey: "testFloat")
      store.setValue(testString, forKey: "testString")
      
    let notFound = store.getBool(forKey: "Invalid")
      XCTAssertNil(notFound)
      
    let inValidType = store.getString(forKey: "testInt")
      XCTAssertNil(inValidType)
      
    XCTAssert(store.getBool(forKey: "testBool") == testBool)
    XCTAssert(store.getInt(forKey: "testInt") == testInt)
    XCTAssert(store.getDouble(forKey: "testDouble") == testDouble)
    XCTAssert(store.getFloat(forKey: "testFloat") == testFloat)
    XCTAssert(store.getString(forKey: "testString") == testString)
   }

   func testGettersWithDefaultValues() {
      
      let store = KVStore()
 
    let notFound = store.getBool(forKey: "Invalid")
      XCTAssertNil(notFound)
      
    let inValidType = store.getString(forKey: "testInt")
      XCTAssertNil(inValidType)
      
    XCTAssert(store.getBool(forKey: "testBool", defaultValue: true) == true)
    XCTAssert(store.getInt(forKey: "testInt", defaultValue: 42) == 42)
    XCTAssert(store.getDouble(forKey: "testDouble", defaultValue: 3.14) == 3.14)
    XCTAssert(store.getFloat(forKey: "testFloat", defaultValue: 0.001) == 0.001)
    XCTAssert(store.getString(forKey: "testString", defaultValue: "Hello") == "Hello")
      
      store.setValue(10, forKey: "testInt")
    XCTAssert(store.getInt(forKey: "testInt", defaultValue: 42) == 10)
      
      let employee = Employee(name: "Fred", title: "President")
      
    let resultEmployee : Employee = store.getValue(forKey: "Fred", defaultValue: employee)
      XCTAssert(resultEmployee.name == "Fred")
   }
   
   func testRemovalFromStore() {
      let store = KVStore()
      
      let employee = Employee(name: "Fred", title: "President")
      let employee2 = Employee(name: "Alice", title: nil)
      let company = Company(name: "TestCompany", yearFounded: 2014, phoneNumber: "860-222-1234", employees: [employee, employee2])
      
      let employeeArray = [employee, employee2]
      let employeeDict = ["Fred" : employee, "Alice" : employee2]
      
      store.setValue("HELLO", forKey: "some.string.value")
      store.setValue(employee, forKey: "employees.instance")
      store.setValue(employeeArray, forKey: "employees.array")
      store.setValue(employeeDict, forKey: "employees.dict")
      store.setValue(company, forKey: "company")
      
      let removedString: String? = store.removeValue("some.string.value")
      XCTAssert(removedString == "HELLO")
      
    let getRemovedString: String? = store.getValue(forKey: "some.string.value")
      XCTAssertNil(getRemovedString)
      
      let removedEmployee : Employee? = store.removeValue("employees.instance")
      XCTAssertNotNil(removedEmployee)
      
    let getRemovedEmployee : Employee? = store.getValue(forKey: "employees.instance")
      XCTAssertNil(getRemovedEmployee)
      
      let removedEmployeeArray : [Employee]? = store.removeValue("employees.array")
      XCTAssertNotNil(removedEmployeeArray)
      
      store.setValue(employee, forKey: "employees.instance")
      store.deleteValue("employees.instance")
      
    let getDeletedEmployee : Employee? = store.getValue(forKey: "employees.instance")
      XCTAssertNil(getDeletedEmployee)
   }

   func testMergingStores() {
      let store = KVStore()
      store.setValue("HELLO", forKey: "some.string.value")
      let store2 = KVStore()
      
      store2.setValue(12, forKey: "some.integer.value")
      store2.setValue("SOME STRING", forKey: "some.string.other")
      
      store.merge(store2)
      
    let i: Int? = store.getInt(forKey: "some.integer.value")
      XCTAssertNotNil(i)
      XCTAssert(i == 12)
      
    let s: String? = store.getString(forKey: "some.string.other")
      XCTAssertNotNil(s)
      XCTAssert(s == "SOME STRING")
   }
   
   func testMergingStoreIntoKeypath() {
      let store = KVStore()
      store.setValue("HELLO", forKey: "some.string.value")
      let store2 = KVStore()
      
      store2.setValue(12, forKey: "branch.integer.value")
      store2.setValue("SOME STRING", forKey: "some.string.other")
      store.merge(store2, intoKeypath: "other.key")
      
    let i : Int? = store.getValue(forKey: "other.key.branch.integer.value")
      XCTAssertNotNil(i)
      XCTAssert(i == 12)
      
    let s: String? = store.getString(forKey: "other.key.some.string.other")
      XCTAssertNotNil(s)
      XCTAssert(s == "SOME STRING")
   }
   
}
