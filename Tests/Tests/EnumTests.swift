import XCTest
import State
import UIKit

class EnumTests: Test {

    func testRawEnum() {
        let test_out = TestRawEnum.Ready
        test_out.save(.Plist, path: tempPathFor("test_raw_enum.plist"))
        let sut = TestRawEnum(.Plist, path: tempPathFor("test_raw_enum.plist"))
        XCTAssert(sut != nil)
        XCTAssert(sut == TestRawEnum.Ready)
    }
    
    func testRegEnum() {
        let test_out = TestRegEnum.Cold
        test_out.save(.Plist, path: tempPathFor("test_reg_enum.plist"))
        let sut = TestRegEnum(.Plist, path: tempPathFor("test_reg_enum.plist"))
        XCTAssert(sut != nil)
        XCTAssert(sut == TestRegEnum.Cold)
    }

    func testAssociatedEnum() {
        
         func createBinary() -> NSData? {
            if let path = NSBundle(forClass: Test.self).pathForResource("Data", ofType: "plist") {
                return  NSData(contentsOfFile:path)
            }
            return nil
        }
        
        func performTestFor(testEnum: TestAssociatedEnum, message: String) {
            testEnum.save(.Binary, path: tempPathFor("test_associated_enum.plist"))
            let sut = TestAssociatedEnum(.Binary, path: tempPathFor("test_associated_enum.plist"))
            XCTAssert(sut != nil)
            if let sut = sut {
                switch sut {
                case let .StringType(s):
                    XCTAssert(s == "Hello World", message)
                case let .IntType(i):
                    XCTAssert(i == 10, message)
                case let .FloatType(f):
                    XCTAssert(f == 0.1235, message)
                case let .DoubleType(d):
                    XCTAssert(d == -12.34, message)
                case let .BooleanType(b):
                    XCTAssert(b == true, message)
                case let .BinaryType(b):
                    XCTAssertNotNil(b, message)
                case let .DecimalType(d):
                    XCTAssert(d == NSDecimalNumber(double:0.8976), message)
                case let .DateType(d):
                    XCTAssert(d == NSDate(timeIntervalSince1970: 10000), message)
                case let .TransformableColorType(t):
                    XCTAssert(t == UIColor.blueColor(), message)
                default:
                    XCTFail()
                }
            }

        }
        
        performTestFor(TestAssociatedEnum.StringType("Hello World"), message: "StringType should be Hello World")
        performTestFor(TestAssociatedEnum.IntType(10), message: "IntType should be 10")
        performTestFor(TestAssociatedEnum.FloatType(0.1235), message: "FloatType should be .1235")
        performTestFor(TestAssociatedEnum.DoubleType(-12.34), message: "DoubleType should be -12.34")
        performTestFor(TestAssociatedEnum.BooleanType(true), message: "BooleanType should be true")
        performTestFor(TestAssociatedEnum.BinaryType(createBinary()!), message: "Binary should not be nil")
        performTestFor(TestAssociatedEnum.DecimalType(NSDecimalNumber(double: 0.8976)), message: "DecimalType should equal 0.8976")
        performTestFor(TestAssociatedEnum.DateType(NSDate(timeIntervalSince1970: 10000)), message: "DateType should equal 10000 since 1970")
        performTestFor(TestAssociatedEnum.TransformableColorType(UIColor.blueColor()), message: "Color should be blue")
    }
    
    
    func testAssociatedDecodeableToManyEnum() {
        let employee = Employee(name: "Joe", title: "Manager")
        let employees = [employee, employee, employee]
        let test_out = TestAssociatedEnum.DecodableToManyType(employees)
        test_out.save(.Plist, path: tempPathFor("test_associated_tomany_enum.plist"))
        let sut = TestAssociatedEnum(.Plist, path: tempPathFor("test_associated_tomany_enum.plist"))
        XCTAssert(sut != nil)
        
        switch sut! {
        case let .DecodableToManyType(e):
            XCTAssert(e.count == 3)
            XCTAssert(e[1].name == "Joe")
        default:
            XCTFail()
        }
    }
    
    func testAssociatedDecodeableToOneEnum() {
        let employee = Employee(name: "Joe", title: "Manager")
        let test_out = TestAssociatedEnum.DecodableToOneType(employee)
        test_out.save(.Plist, path: tempPathFor("test_associated_toone_enum.plist"))
        let sut = TestAssociatedEnum(.Plist, path: tempPathFor("test_associated_toone_enum.plist"))
        XCTAssert(sut != nil)
        
        switch sut! {
        case let .DecodableToOneType(e):
            XCTAssert(e.name == "Joe")
        default:
            XCTFail()
        }
    }
    
    func testAssociatedOptionalEnum() {
        
        func createBinary() -> NSData? {
            if let path = NSBundle(forClass: Test.self).pathForResource("Data", ofType: "plist") {
                return  NSData(contentsOfFile:path)
            }
            return nil
        }
        
        func performTestFor(testEnum: TestAssociatedOptionalEnum, message: String) {
            testEnum.save(.Binary, path: tempPathFor("test_associated_optional_enum.plist"))
            let sut = TestAssociatedOptionalEnum(.Binary, path: tempPathFor("test_associated_optional_enum.plist"))
            XCTAssert(sut != nil, "system under test is nil")
            if let sut = sut {
                switch sut {
                case let .StringType(s):
                    XCTAssert(s == "Hello World", message)
                case let .IntType(i):
                    XCTAssert(i == 10, message)
                case let .FloatType(f):
                    XCTAssert(f == 0.1235, message)
                case let .DoubleType(d):
                    XCTAssert(d == -12.34, message)
                case let .BooleanType(b):
                    XCTAssert(b == true, message)
                case let .BinaryType(b):
                    XCTAssertNotNil(b, message)
                case let .DecimalType(d):
                    XCTAssert(d == NSDecimalNumber(double:0.8976), message)
                case let .DateType(d):
                    XCTAssert(d == NSDate(timeIntervalSince1970: 10000), message)
                case let .TransformableColorType(t):
                    XCTAssert(t == UIColor.blueColor(), message)
                default:
                    XCTFail("no case found")
                }
            }
        }
        
        performTestFor(TestAssociatedOptionalEnum.StringType("Hello World"), message: "StringType should be Hello World")
        performTestFor(TestAssociatedOptionalEnum.IntType(10), message: "IntType should be 10")
        performTestFor(TestAssociatedOptionalEnum.FloatType(0.1235), message: "FloatType should be .1235")
        performTestFor(TestAssociatedOptionalEnum.DoubleType(-12.34), message: "DoubleType should be -12.34")
        performTestFor(TestAssociatedOptionalEnum.BooleanType(true), message: "BooleanType should be true")
        performTestFor(TestAssociatedOptionalEnum.BinaryType(createBinary()!), message: "Binary should not be nil")
        performTestFor(TestAssociatedOptionalEnum.DecimalType(NSDecimalNumber(double: 0.8976)), message: "DecimalType should equal 0.8976")
        performTestFor(TestAssociatedOptionalEnum.DateType(NSDate(timeIntervalSince1970: 10000)), message: "DateType should equal 10000 since 1970")
        performTestFor(TestAssociatedOptionalEnum.TransformableColorType(UIColor.blueColor()), message: "Color should be blue")
    }

    func testAssociatedDecodeableOptionalToManyEnum() {
        let employee = Employee(name: "Joe", title: "Manager")
        let employees = [employee, employee, employee]
        let test_out = TestAssociatedOptionalEnum.DecodableToManyType(employees)
        test_out.save(.Plist, path: tempPathFor("test_associated_optional_tomany_enum.plist"))
        let sut = TestAssociatedOptionalEnum(.Plist, path: tempPathFor("test_associated_optional_tomany_enum.plist"))
        XCTAssert(sut != nil)
        
        switch sut! {
        case let .DecodableToManyType(e):
            XCTAssert(e?.count == 3)
            XCTAssert(e?[1].name == "Joe")
        default:
            XCTFail()
        }
    }
    
    func testAssociatedDecodeableOptionalToOneEnum() {
        let employee = Employee(name: "Joe", title: "Manager")
        let test_out = TestAssociatedOptionalEnum.DecodableToOneType(employee)
        test_out.save(.Plist, path: tempPathFor("test_associated_optional_toone_enum.plist"))
        let sut = TestAssociatedOptionalEnum(.Plist, path: tempPathFor("test_associated_optional_toone_enum.plist"))
        XCTAssert(sut != nil)
        
        switch sut! {
        case let .DecodableToOneType(e):
            XCTAssert(e?.name == "Joe")
        default:
            XCTFail()
        }
    }
}