import XCTest
import Spot

class EnumTests: Test {

    func testRawEnum() {
        var test_out = TestRawEnum.Ready
        Plist.write(Encoder.encodeModel(test_out), path: tempPathFor("test_raw_enum.plist"))
        var sut: TestRawEnum? = Decoder.decodeModel(Plist.read(tempPathFor("test_raw_enum.plist")))
        XCTAssert(sut != nil)
        XCTAssert(sut == TestRawEnum.Ready)
    }
    
    func testRegEnum() {
        var test_out = TestRegEnum.Cold
        Plist.write(Encoder.encodeModel(test_out), path: tempPathFor("test_reg_enum.plist"))
        var sut: TestRegEnum? = Decoder.decodeModel(Plist.read(tempPathFor("test_reg_enum.plist")))
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
            Data.write(Encoder.encodeModel(testEnum), path: tempPathFor("test_associated_enum.plist"))
            var sut: TestAssociatedEnum? = Decoder.decodeModel(Data.read(tempPathFor("test_associated_enum.plist")))
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
        
        performTestFor(TestAssociatedEnum.StringType("Hello World"), "StringType should be Hello World")
        performTestFor(TestAssociatedEnum.IntType(10), "IntType should be 10")
        performTestFor(TestAssociatedEnum.FloatType(0.1235), "FloatType should be .1235")
        performTestFor(TestAssociatedEnum.DoubleType(-12.34), "DoubleType should be -12.34")
        performTestFor(TestAssociatedEnum.BooleanType(true), "BooleanType should be true")
        performTestFor(TestAssociatedEnum.BinaryType(createBinary()!), "Binary should not be nil")
        performTestFor(TestAssociatedEnum.DecimalType(NSDecimalNumber(double: 0.8976)), "DecimalType should equal 0.8976")
        performTestFor(TestAssociatedEnum.DateType(NSDate(timeIntervalSince1970: 10000)), "DateType should equal 10000 since 1970")
        performTestFor(TestAssociatedEnum.TransformableColorType(UIColor.blueColor()), "Color should be blue")
    }
    
    
    func testAssociatedDecodeableToManyEnum() {
        var employee = Employee(name: "Joe", title: "Manager")
        var employees = [employee, employee, employee]
        var test_out = TestAssociatedEnum.DecodableToManyType(employees)
        Plist.write(Encoder.encodeModel(test_out), path: tempPathFor("test_associated_tomany_enum.plist"))
        var sut: TestAssociatedEnum? = Decoder.decodeModel(Plist.read(tempPathFor("test_associated_tomany_enum.plist")))
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
        var employee = Employee(name: "Joe", title: "Manager")
        var test_out = TestAssociatedEnum.DecodableToOneType(employee)
        Plist.write(Encoder.encodeModel(test_out), path: tempPathFor("test_associated_toone_enum.plist"))
        var sut: TestAssociatedEnum? = Decoder.decodeModel(Plist.read(tempPathFor("test_associated_toone_enum.plist")))
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
            Data.write(Encoder.encodeModel(testEnum), path: tempPathFor("test_associated_optional_enum.plist"))
            var sut: TestAssociatedOptionalEnum? = Decoder.decodeModel(Data.read(tempPathFor("test_associated_optional_enum.plist")))
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
        
        performTestFor(TestAssociatedOptionalEnum.StringType("Hello World"), "StringType should be Hello World")
        performTestFor(TestAssociatedOptionalEnum.IntType(10), "IntType should be 10")
        performTestFor(TestAssociatedOptionalEnum.FloatType(0.1235), "FloatType should be .1235")
        performTestFor(TestAssociatedOptionalEnum.DoubleType(-12.34), "DoubleType should be -12.34")
        performTestFor(TestAssociatedOptionalEnum.BooleanType(true), "BooleanType should be true")
        performTestFor(TestAssociatedOptionalEnum.BinaryType(createBinary()!), "Binary should not be nil")
        performTestFor(TestAssociatedOptionalEnum.DecimalType(NSDecimalNumber(double: 0.8976)), "DecimalType should equal 0.8976")
        performTestFor(TestAssociatedOptionalEnum.DateType(NSDate(timeIntervalSince1970: 10000)), "DateType should equal 10000 since 1970")
        performTestFor(TestAssociatedOptionalEnum.TransformableColorType(UIColor.blueColor()), "Color should be blue")
    }

    func testAssociatedDecodeableOptionalToManyEnum() {
        var employee = Employee(name: "Joe", title: "Manager")
        var employees = [employee, employee, employee]
        var test_out = TestAssociatedOptionalEnum.DecodableToManyType(employees)
        Plist.write(Encoder.encodeModel(test_out), path: tempPathFor("test_associated_optional_tomany_enum.plist"))
        var sut: TestAssociatedOptionalEnum? = Decoder.decodeModel(Plist.read(tempPathFor("test_associated_optional_tomany_enum.plist")))
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
        var employee = Employee(name: "Joe", title: "Manager")
        var test_out = TestAssociatedOptionalEnum.DecodableToOneType(employee)
        Plist.write(Encoder.encodeModel(test_out), path: tempPathFor("test_associated_optional_toone_enum.plist"))
        var sut: TestAssociatedOptionalEnum? = Decoder.decodeModel(Plist.read(tempPathFor("test_associated_optional_toone_enum.plist")))
        XCTAssert(sut != nil)
        
        switch sut! {
        case let .DecodableToOneType(e):
            XCTAssert(e?.name == "Joe")
        default:
            XCTFail()
        }
    }




}