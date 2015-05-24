import XCTest
import State
import UIKit

class MigrationTests: Test {
    
    func testEmployeeEncodesVersion() {
        var testItem = Employee(name: "John", title: "Manager")
        var versionString = Employee.modelVersionHash
        
        JSON.write(Encoder.encodeModel(testItem), path: tempPathFor("employee.json"))
        var data = JSON.read(tempPathFor("employee.json"))
        
        if let data = data, testVersionString = data[Employee.versionKey]  as? String {
            XCTAssert(testVersionString == versionString)
        } else { XCTFail() }
        
    }
    
    func testMigration() {
        // create version 1, and write out to file
        var testVersion1 = TestMigrationV1(name: "John")
        JSON.write(Encoder.encodeModel(testVersion1), path: tempPathFor("version1.json"))
        
        // read in version 1, and migrate to version 2
        var testVersion2 : TestMigrationV2! = Decoder.decodeModel(JSON.read(tempPathFor("version1.json")))
        
        // should now have a version 2 type (should have an age property that defaults to 10)
        
        XCTAssert(testVersion2.age == 10)
    
    }
    
    func testWillFinishEncodingWithEncoderIsCalled() {
        var testVersion1 = TestMigrationV1(name: "John")
        JSON.write(Encoder.encodeModel(testVersion1), path: tempPathFor("migration.json"))
        var data = JSON.read(tempPathFor("migration.json"))
        if let data = data, extraKey = data["migration_test"] as? String {
            XCTAssert(extraKey == "Hello World")
        } else  { XCTFail() }
    }

}

