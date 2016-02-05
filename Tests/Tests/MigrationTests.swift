import XCTest
import State
import UIKit

class MigrationTests: Test {
    
    func testEmployeeEncodesVersion() {
        let testItem = Employee(name: "John", title: "Manager")
        let versionString = Employee.modelVersionHash()

         testItem.save(.JSON, path: tempPathFor("employee.json"))
         let data = JSON.read(tempPathFor("employee.json"))
        
        if let data = data, testVersionString = data[Employee.versionKey()]  as? String {
            XCTAssert(testVersionString == versionString)
        } else { XCTFail() }
    }
    
    func testMigration() {
        // create version 1, and write out to file
        let testVersion1 = TestMigrationV1(name: "John")
        testVersion1.save(.JSON, path: tempPathFor("version1.json"))
        
        // read in version 1, and migrate to version 2
        let testVersion2 = TestMigrationV2(.JSON, path: tempPathFor("version1.json"))
        
        // should now have a version 2 type (should have an age property that defaults to 10)
        
        XCTAssert(testVersion2?.age == 10)
    
    }
    
    func testWillFinishEncodingWithEncoderIsCalled() {
        let testVersion1 = TestMigrationV1(name: "John")
        testVersion1.save(.JSON, path: tempPathFor("migration.json"))
        let data = JSON.read(tempPathFor("migration.json"))
        if let data = data, extraKey = data["migration_test"] as? String {
            XCTAssert(extraKey == "Hello World")
        } else  { XCTFail() }
    }
}
