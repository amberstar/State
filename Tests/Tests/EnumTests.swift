import XCTest
import State
import UIKit

class EnumTests: Test {

    func testRawEnum() {
        let test_out = TestRawEnum.ready
        _ = test_out.write(to: tempURLFor("test_raw_enum.plist"), format: .plist)
        let sut = TestRawEnum(file: tempURLFor("test_raw_enum.plist"), format: .plist)
        XCTAssert(sut != nil)
        XCTAssert(sut == TestRawEnum.ready)
    }
    
    func testRegEnum() {
        let test_out = TestRegEnum.cold
        _ = test_out.write(to: tempURLFor("test_reg_enum.plist"), format: .plist)
        let sut = TestRegEnum(file: tempURLFor("test_reg_enum.plist"), format: .plist)
        XCTAssert(sut != nil)
        XCTAssert(sut == TestRegEnum.cold)
    }

    func testAssociatedEnum() {
        
         func createBinary() -> Data? {
            if let path = Bundle(for: Test.self).pathForResource("Data", ofType: "plist") {
                return  (try? Data(contentsOf: URL(fileURLWithPath: path)))
            }
            return nil
        }
        
        func performTestFor(_ testEnum: TestAssociatedEnum, message: String) {
            _ = testEnum.write(to: tempURLFor("test_associated_enum.plist"), format: .binary)
            let sut = TestAssociatedEnum(file: tempURLFor("test_associated_enum.plist"), format: .binary)
            XCTAssert(sut != nil)
            if let sut = sut {
                switch sut {
                case let .stringType(s):
                    XCTAssert(s == "Hello World", message)
                case let .intType(i):
                    XCTAssert(i == 10, message)
                case let .floatType(f):
                    XCTAssert(f == 0.1235, message)
                case let .doubleType(d):
                    XCTAssert(d == -12.34, message)
                case let .booleanType(b):
                    XCTAssert(b == true, message)
                case let .binaryType(b):
                    XCTAssertNotNil(b, message)
                case let .decimalType(d):
                    XCTAssert(d == NSDecimalNumber(value:0.8976), message)
                case let .dateType(d):
                    XCTAssert(d == Date(timeIntervalSince1970: 10000), message)
                case let .transformableColorType(t):
                    XCTAssert(t == UIColor.blue(), message)
                default:
                    XCTFail()
                }
            }

        }
        
        performTestFor(TestAssociatedEnum.stringType("Hello World"), message: "StringType should be Hello World")
        performTestFor(TestAssociatedEnum.intType(10), message: "IntType should be 10")
        performTestFor(TestAssociatedEnum.floatType(0.1235), message: "FloatType should be .1235")
        performTestFor(TestAssociatedEnum.doubleType(-12.34), message: "DoubleType should be -12.34")
        performTestFor(TestAssociatedEnum.booleanType(true), message: "BooleanType should be true")
        performTestFor(TestAssociatedEnum.binaryType(createBinary()!), message: "Binary should not be nil")
        performTestFor(TestAssociatedEnum.decimalType(NSDecimalNumber(value: 0.8976)), message: "DecimalType should equal 0.8976")
        performTestFor(TestAssociatedEnum.dateType(Date(timeIntervalSince1970: 10000)), message: "DateType should equal 10000 since 1970")
        performTestFor(TestAssociatedEnum.transformableColorType(UIColor.blue()), message: "Color should be blue")
    }
    
    
    func testAssociatedDecodeableToManyEnum() {
        let employee = Employee(name: "Joe", title: "Manager")
        let employees = [employee, employee, employee]
        let test_out = TestAssociatedEnum.decodableToManyType(employees)
        _ = test_out.write(to: tempURLFor("test_associated_tomany_enum.plist"), format: .plist)
        let sut = TestAssociatedEnum(file: tempURLFor("test_associated_tomany_enum.plist"), format: .plist)
        XCTAssert(sut != nil)
        
        switch sut! {
        case let .decodableToManyType(e):
            XCTAssert(e.count == 3)
            XCTAssert(e[1].name == "Joe")
        default:
            XCTFail()
        }
    }
    
    func testAssociatedDecodeableToOneEnum() {
        let employee = Employee(name: "Joe", title: "Manager")
        let test_out = TestAssociatedEnum.decodableToOneType(employee)
        _ = test_out.write(to: tempURLFor("test_associated_toone_enum.plist"), format: .plist)
        let sut = TestAssociatedEnum(file: tempURLFor("test_associated_toone_enum.plist"), format: .plist)
        XCTAssert(sut != nil)
        
        switch sut! {
        case let .decodableToOneType(e):
            XCTAssert(e.name == "Joe")
        default:
            XCTFail()
        }
    }
    
    func testAssociatedOptionalEnum() {
        
        func createBinary() -> Data? {
            if let path = Bundle(for: Test.self).pathForResource("Data", ofType: "plist") {
                return  (try? Data(contentsOf: URL(fileURLWithPath: path)))
            }
            return nil
        }
        
        func performTestFor(_ testEnum: TestAssociatedOptionalEnum, message: String) {
            _ = testEnum.write(to: tempURLFor("test_associated_optional_enum.plist"), format: .binary)
            let sut = TestAssociatedOptionalEnum(file: tempURLFor("test_associated_optional_enum.plist"), format: .binary)
            XCTAssert(sut != nil, "system under test is nil")
            if let sut = sut {
                switch sut {
                case let .stringType(s):
                    XCTAssert(s == "Hello World", message)
                case let .intType(i):
                    XCTAssert(i == 10, message)
                case let .floatType(f):
                    XCTAssert(f == 0.1235, message)
                case let .doubleType(d):
                    XCTAssert(d == -12.34, message)
                case let .booleanType(b):
                    XCTAssert(b == true, message)
                case let .binaryType(b):
                    XCTAssertNotNil(b, message)
                case let .decimalType(d):
                    XCTAssert(d == NSDecimalNumber(value:0.8976), message)
                case let .dateType(d):
                    XCTAssert(d == Date(timeIntervalSince1970: 10000), message)
                case let .transformableColorType(t):
                    XCTAssert(t == UIColor.blue(), message)
                default:
                    XCTFail("no case found")
                }
            }
        }
        
        performTestFor(TestAssociatedOptionalEnum.stringType("Hello World"), message: "StringType should be Hello World")
        performTestFor(TestAssociatedOptionalEnum.intType(10), message: "IntType should be 10")
        performTestFor(TestAssociatedOptionalEnum.floatType(0.1235), message: "FloatType should be .1235")
        performTestFor(TestAssociatedOptionalEnum.doubleType(-12.34), message: "DoubleType should be -12.34")
        performTestFor(TestAssociatedOptionalEnum.booleanType(true), message: "BooleanType should be true")
        performTestFor(TestAssociatedOptionalEnum.binaryType(createBinary()!), message: "Binary should not be nil")
        performTestFor(TestAssociatedOptionalEnum.decimalType(NSDecimalNumber(value: 0.8976)), message: "DecimalType should equal 0.8976")
        performTestFor(TestAssociatedOptionalEnum.dateType(Date(timeIntervalSince1970: 10000)), message: "DateType should equal 10000 since 1970")
        performTestFor(TestAssociatedOptionalEnum.transformableColorType(UIColor.blue()), message: "Color should be blue")
    }

    func testAssociatedDecodeableOptionalToManyEnum() {
        let employee = Employee(name: "Joe", title: "Manager")
        let employees = [employee, employee, employee]
        let test_out = TestAssociatedOptionalEnum.decodableToManyType(employees)
        _ = test_out.write(to: tempURLFor("test_associated_optional_tomany_enum.plist"), format: .plist)
        let sut = TestAssociatedOptionalEnum(file: tempURLFor("test_associated_optional_tomany_enum.plist"), format: .plist)
        XCTAssert(sut != nil)
        
        switch sut! {
        case let .decodableToManyType(e):
            XCTAssert(e?.count == 3)
            XCTAssert(e?[1].name == "Joe")
        default:
            XCTFail()
        }
    }
    
    func testAssociatedDecodeableOptionalToOneEnum() {
        let employee = Employee(name: "Joe", title: "Manager")
        let test_out = TestAssociatedOptionalEnum.decodableToOneType(employee)
        _ = test_out.write(to: tempURLFor("test_associated_optional_toone_enum.plist"), format: .plist)
        let sut = TestAssociatedOptionalEnum(file: tempURLFor("test_associated_optional_toone_enum.plist"), format: .plist)
        XCTAssert(sut != nil)
        
        switch sut! {
        case let .decodableToOneType(e):
            XCTAssert(e?.name == "Joe")
        default:
            XCTFail()
        }
    }
}
