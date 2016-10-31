import UIKit
import XCTest
@testable import State

class ModelReadingTests: Test {
    
    func testDecodingDecodableFromJSON() {
        let user = User.read(from: Store(properties: jsonData["t"] as! [String : AnyObject]))
        let userNoEmail  = User.read(from: Store(properties: jsonData["u"] as! [String : AnyObject]))
        let users = UserTypes.read(from: Store(properties: jsonData))
        XCTAssert(user != nil)
        XCTAssert(user?.id == 10)
        XCTAssert(user?.name == "John Doe")
        XCTAssert(user?.email == "john@unit-testing.com")
        XCTAssert(userNoEmail != nil)
        XCTAssert(userNoEmail?.id == 10)
        XCTAssert(userNoEmail?.name == "John Doe")
        XCTAssert(userNoEmail?.email == nil)
        XCTAssert(users != nil)
        XCTAssert(users?.tArr.count == 3)
        XCTAssert(users?.tImp.name == "John Doe")
        XCTAssert(users?.tDicOpt?.count == 3)
        XCTAssert(users?.tDicOpt?["item1"]?.email == "john@unit-testing.com")
        XCTAssert(users?.tArrImp.count == 3)
    }
    
    func testDecodingDecodableFromPlist() {
        let user = User.read(from: Store(properties: plistData["User1"] as! [String : AnyObject]))
        let userNoEmail = User.read(from: Store(properties: plistData["User2"] as! [String : AnyObject]))
        let users = UserTypes.read(from: Store(properties: plistData["Users"] as! [String : AnyObject]))
        XCTAssert(user != nil)
        XCTAssert(user?.id == 10)
        XCTAssert(user?.name == "John Doe")
        XCTAssert(user?.email == "john@unit-testing.com")
        XCTAssert(userNoEmail != nil)
        XCTAssert(userNoEmail?.id == 10)
        XCTAssert(userNoEmail?.name == "John Doe")
        XCTAssert(userNoEmail?.email == nil)
        XCTAssert(users != nil)
        XCTAssert(users?.tArr.count == 3)
        XCTAssert(users?.tImp.name == "John Doe")
        XCTAssert(users?.tDicOpt?.count == 3)
        XCTAssert(users?.tDicOpt?["item1"]?.email == "john@unit-testing.com")
        XCTAssert(users?.tArrImp.count == 3)
    }
    
    func testDecodingInvalidDecodableShouldFail() {
        let user = User.read(from: Store(properties: jsonData["x"] as! [String : AnyObject]))
        XCTAssert(user == nil)
    }
}

class DecodingTests: Test {
    
    func testDecodingBools() {
        let bools = BasicTypes<Bool>(with: Store(properties: plistData["Bool"] as! [String : AnyObject]))
        ///  Bools
        XCTAssert(bools != nil)
        XCTAssert(bools?.t == true)
        XCTAssert(bools?.tOpt == nil)
        XCTAssert(bools?.tImp == false)
        
        /// Bool Arrays
        XCTAssert(bools?.tArr.count == 3)
        XCTAssert(bools?.tArr[1] == true)
        XCTAssert(bools?.tArrOpt == nil)
        XCTAssert(bools?.tArrImp != nil)
        XCTAssert(bools?.tArrImp[1] == true)
        
        /// Bool Dictionaries
        XCTAssert(bools?.tDic.count == 2)
        XCTAssert(bools?.tDic["key1"] == true)
        XCTAssert(bools?.tDic["key0"] == false)
        XCTAssert(bools?.tDicOpt != nil)
        XCTAssert(bools?.tDictImp["key0"] == true)
    }
    
    func testDecodingIntTypes() {
        let ints = BasicTypes<Int>.read(from: Store(properties: plistData["Int"] as! [String : AnyObject]))
        
        /// Ints
        XCTAssert(ints != nil)
        XCTAssert(ints?.t == 10)
        XCTAssert(ints?.tOpt == nil)
        XCTAssert(ints?.tImp == 40)
        
        /// Int Arrays
        XCTAssert(ints?.tArr.count == 3)
        XCTAssert(ints?.tArr[1] == 10)
        XCTAssert(ints?.tArrOpt == nil)
        XCTAssert(ints?.tArrImp != nil)
        XCTAssert(ints?.tArrImp[1] == 64)
        
        /// Int Dictionaries
        XCTAssert(ints?.tDic.count == 2)
        XCTAssert(ints?.tDic["key1"] == 123)
        XCTAssert(ints?.tDic["key0"] == 67)
        XCTAssert(ints?.tDicOpt != nil)
        XCTAssert(ints?.tDictImp["key1"] == 79)
    }
    
    func testDecodingDoubles() {
        let doubles = BasicTypes<Double>.read(from: Store(properties: plistData["Double"] as! [String : AnyObject]))
        
        /// Doubles
        XCTAssert(doubles != nil)
        XCTAssert(doubles?.t == -0.456)
        XCTAssert(doubles?.tOpt == nil)
        XCTAssert(doubles?.tImp == 0.6565)
        
        /// Double Arrays
        XCTAssert(doubles?.tArr.count == 3)
        XCTAssert(doubles?.tArr[1] == 0.45)
        XCTAssert(doubles?.tArrOpt == nil)
        XCTAssert(doubles?.tArrImp != nil)
        XCTAssert(doubles?.tArrImp[1] == 0)
        
        /// Double Dictionaries
        XCTAssert(doubles?.tDic.count == 2)
        XCTAssert(doubles?.tDic["key1"] == -1.0005)
        XCTAssert(doubles?.tDic["key0"] == 67.6756)
        XCTAssert(doubles?.tDicOpt != nil)
        XCTAssert(doubles?.tDictImp["key1"] == -5.78)
    }
    
    func testDecodingFloats() {
        let floats = BasicTypes<Float>.read(from: Store(properties: plistData["Float"] as! [String : AnyObject]))
        
        /// Floats
        XCTAssert(floats != nil)
        XCTAssert(floats?.t == -0.345)
        XCTAssert(floats?.tOpt == nil)
        XCTAssert(floats?.tImp == 0.78796)
        
        /// Float Arrays
        XCTAssert(floats?.tArr.count == 3)
        XCTAssert(floats?.tArr[1] == 0.54)
        XCTAssert(floats?.tArrOpt == nil)
        XCTAssert(floats?.tArrImp != nil)
        XCTAssert(floats?.tArrImp[1] == -0.45)
        
        /// Float Dictionaries
        XCTAssert(floats?.tDic.count == 2)
        XCTAssert(floats?.tDic["key1"] == 0.45)
        XCTAssert(floats?.tDic["key0"] == 65.0909)
        XCTAssert(floats?.tDicOpt != nil)
        XCTAssert(floats?.tDictImp["key1"] == -222.222)
    }
    
    func testDecodingStrings() {
        let strings = StringTypes.read(from: Store(properties: plistData["String"] as! [String : AnyObject]))
        
        /// Strings
        XCTAssert(strings != nil)
        XCTAssert(strings?.t == "Hello")
        XCTAssert(strings?.tOpt == nil)
        XCTAssert(strings?.tImp == "Unwrapped")
        
        /// String Arrays
        XCTAssert(strings?.tArr.count == 3)
        XCTAssert(strings?.tArr[1] == "item1")
        XCTAssert(strings?.tArrOpt == nil)
        XCTAssert(strings?.tArrImp != nil)
        XCTAssert(strings?.tArrImp[1] == "Ray")
        
        /// String Dictionaries
        XCTAssert(strings?.tDic.count == 2)
        XCTAssert(strings?.tDic["key1"] == "Dic_String_1")
        XCTAssert(strings?.tDic["key0"] == "Dic_String_0")
        XCTAssert(strings?.tDicOpt != nil)
        XCTAssert(strings?.tDictImp["key1"] == "")
    }
    
    func testDecodingAnyObjects() {
        let objects = AnyObjectTypes.read(from: Store(properties: plistData["Object"] as! [String : AnyObject]))
        
        /// AnyObjects
        XCTAssert(objects != nil)
        XCTAssert(objects?.t as? Int == 400)
        XCTAssert(objects?.tOpt == nil)
        XCTAssert(objects?.tImp as? Bool == true)
        
        /// AnyObject Arrays
        XCTAssert(objects?.tArr.count == 3)
        XCTAssert(objects?.tArr[1] as? Double == 20.6 )
        XCTAssert(objects?.tArrOpt == nil)
        XCTAssert(objects?.tArrImp != nil)
        XCTAssert(objects?.tArrImp[1] as? String == "Ray")
        
        /// AnyObject Dictionaries
        XCTAssert(objects?.tDic.count == 2)
        XCTAssert(objects?.tDic["key1"] as? Bool == true )
        XCTAssert(objects?.tDic["key0"] as? Int == 0)
        XCTAssert(objects?.tDicOpt != nil)
        XCTAssert(objects?.tDictImp["key1"] as? Date != nil)
    }
}

class DefaultTests: Test {
    
    func testDefaults() {
        let test = TestDefaults()
        
        XCTAssert(test.defaultArray.count == 3 )
        XCTAssert(test.defaultString == "defaultString")
        XCTAssertNotNil(test.defaultEmptyArray)
        XCTAssert(test.defaultChild.name == "New Child")
        XCTAssert(test.defaultChildren.count == 0)
    }
    
}

class ModelWritingTests: Test {
    
    func testEcodingToAndFromJSON() {
        let inUsers =  UserTypes(with: Store(properties: jsonData))
        if let inUsers = inUsers {
            _ = inUsers.write(to: tempURLFor("temp.json"), format: .json)
        }
        let users =  UserTypes(jsonFile: tempURLFor("temp.json"))
        XCTAssert(users != nil)
        XCTAssert(users?.tArr.count == 3)
        XCTAssert(users?.tImp.name == "John Doe")
        XCTAssert(users?.tDicOpt?.count == 3)
        XCTAssert(users?.tDicOpt?["item1"]?.email == "john@unit-testing.com")
        XCTAssert(users?.tArrImp.count == 3)
    }
    
    func testEcodingToAndFromPlist() {
        let inUsers = UserTypes.read(from: Store(properties: plistData["Users"] as! [String : AnyObject]))
        if let inUsers = inUsers {
            _ = inUsers.write(to: tempURLFor("temp.plist"), format: .plist)
        }
        let users =  UserTypes(plistFile: tempURLFor("temp.plist"))
        XCTAssert(users != nil)
        XCTAssert(users?.tArr.count == 3)
        XCTAssert(users?.tImp.name == "John Doe")
        XCTAssert(users?.tDicOpt?.count == 3)
        XCTAssert(users?.tDicOpt?["item1"]?.email == "john@unit-testing.com")
        XCTAssert(users?.tArrImp.count == 3)
    }
}

class EncodingTests: Test {
    func testEncodingBools() {
        let bools_in = BasicTypes<Bool>.read(from: Store(properties: plistData["Bool"] as! [String : AnyObject]))
        var store: Store = Store()
        bools_in!.store(to: &store)
        let bools = BasicTypes<Bool>.read(from: store)
        
        /// Bools
        XCTAssert(bools != nil)
        XCTAssert(bools?.t == true)
        XCTAssert(bools?.tOpt == nil)
        XCTAssert(bools?.tImp == false)
        
        /// Bool Arrays
        XCTAssert(bools?.tArr.count == 3)
        XCTAssert(bools?.tArr[1] == true)
        XCTAssert(bools?.tArrOpt == nil)
        XCTAssert(bools?.tArrImp != nil)
        XCTAssert(bools?.tArrImp[1] == true)
        
        /// Bool Dictionaries
        XCTAssert(bools?.tDic.count == 2)
        XCTAssert(bools?.tDic["key1"] == true)
        XCTAssert(bools?.tDic["key0"] == false)
        XCTAssert(bools?.tDicOpt != nil)
        XCTAssert(bools?.tDictImp["key0"] == true)
    }
    
    func testEncodingInts() {
        let ints_in =  BasicTypes<Int>.read(from: Store(properties: plistData["Int"] as! [String : AnyObject]))
        var store : Store = Store()
        ints_in!.store(to: &store)
        let ints =  BasicTypes<Int>(with: store)
        
        /// Ints
        XCTAssert(ints != nil)
        XCTAssert(ints?.t == 10)
        XCTAssert(ints?.tOpt == nil)
        XCTAssert(ints?.tImp == 40)
        
        /// Int Arrays
        XCTAssert(ints?.tArr.count == 3)
        XCTAssert(ints?.tArr[1] == 10)
        XCTAssert(ints?.tArrOpt == nil)
        XCTAssert(ints?.tArrImp != nil)
        XCTAssert(ints?.tArrImp[1] == 64)
        
        /// Int Dictionaries
        XCTAssert(ints?.tDic.count == 2)
        XCTAssert(ints?.tDic["key1"] == 123)
        XCTAssert(ints?.tDic["key0"] == 67)
        XCTAssert(ints?.tDicOpt != nil)
        XCTAssert(ints?.tDictImp["key1"] == 79)
    }
    
    func testEncodingDoubles() {
        let doubles_in = BasicTypes<Double>.read(from: Store(properties: plistData["Double"] as! [String : AnyObject]))
        var store: Store = Store()
        doubles_in!.store(to: &store)
        let doubles =  BasicTypes<Double>(with: store)
        
        /// Doubles
        XCTAssert(doubles != nil)
        XCTAssert(doubles?.t == -0.456)
        XCTAssert(doubles?.tOpt == nil)
        XCTAssert(doubles?.tImp == 0.6565)
        
        /// Double Arrays
        XCTAssert(doubles?.tArr.count == 3)
        XCTAssert(doubles?.tArr[1] == 0.45)
        XCTAssert(doubles?.tArrOpt == nil)
        XCTAssert(doubles?.tArrImp != nil)
        XCTAssert(doubles?.tArrImp[1] == 0)
        
        /// Double Dictionaries
        XCTAssert(doubles?.tDic.count == 2)
        XCTAssert(doubles?.tDic["key1"] == -1.0005)
        XCTAssert(doubles?.tDic["key0"] == 67.6756)
        XCTAssert(doubles?.tDicOpt != nil)
        XCTAssert(doubles?.tDictImp["key1"] == -5.78)
    }
    
    func testEncodingFloats() {
        let floats_in =  BasicTypes<Float>.read(from: Store(properties: plistData["Float"] as! [String : AnyObject]))
        var store: Store = Store()
        floats_in!.store(to: &store)
        let floats = BasicTypes<Float>(with: store)
        
        /// Floats
        XCTAssert(floats != nil)
        XCTAssert(floats?.t == -0.345)
        XCTAssert(floats?.tOpt == nil)
        XCTAssert(floats?.tImp == 0.78796)
        
        /// Float Arrays
        XCTAssert(floats?.tArr.count == 3)
        XCTAssert(floats?.tArr[1] == 0.54)
        XCTAssert(floats?.tArrOpt == nil)
        XCTAssert(floats?.tArrImp != nil)
        XCTAssert(floats?.tArrImp[1] == -0.45)
        
        /// Float Dictionaries
        XCTAssert(floats?.tDic.count == 2)
        XCTAssert(floats?.tDic["key1"] == 0.45)
        XCTAssert(floats?.tDic["key0"] == 65.0909)
        XCTAssert(floats?.tDicOpt != nil)
        XCTAssert(floats?.tDictImp["key1"] == -222.222)
    }
    
    func testEncodingStringTypes() {
        let strings_in = StringTypes.read(from: Store(properties: plistData["String"] as! [String : AnyObject]))
        var store: Store = Store()
        strings_in!.store(to: &store)
        let strings = StringTypes(with: store)
        
        /// Strings
        XCTAssert(strings != nil)
        XCTAssert(strings?.t == "Hello")
        XCTAssert(strings?.tOpt == nil)
        XCTAssert(strings?.tImp == "Unwrapped")
        
        /// String Arrays
        XCTAssert(strings?.tArr.count == 3)
        XCTAssert(strings?.tArr[1] == "item1")
        XCTAssert(strings?.tArrOpt == nil)
        XCTAssert(strings?.tArrImp != nil)
        XCTAssert(strings?.tArrImp[1] == "Ray")
        
        /// String Dictionaries
        XCTAssert(strings?.tDic.count == 2)
        XCTAssert(strings?.tDic["key1"] == "Dic_String_1")
        XCTAssert(strings?.tDic["key0"] == "Dic_String_0")
        XCTAssert(strings?.tDicOpt != nil)
        XCTAssert(strings?.tDictImp["key1"] == "")
    }
    
    func testEncodingAnyObjectTypes() {
        let objects_in = AnyObjectTypes.read(from: Store(properties: plistData["Object"] as! [String : AnyObject]))
        var store: Store = Store()
        objects_in?.store(to: &store)
        let objects = AnyObjectTypes(with: store)
        
        /// AnyObjects
        XCTAssert(objects != nil)
        XCTAssert(objects?.t as? Int == 400)
        XCTAssert(objects?.tOpt == nil)
        XCTAssert(objects?.tImp as? Bool == true)
        
        /// AnyObject Arrays
        XCTAssert(objects?.tArr.count == 3)
        XCTAssert(objects?.tArr[1] as? Double == 20.6 )
        XCTAssert(objects?.tArrOpt == nil)
        XCTAssert(objects?.tArrImp != nil)
        XCTAssert(objects?.tArrImp[1] as? String == "Ray")
        
        /// AnyObject Dictionaries
        XCTAssert(objects?.tDic.count == 2)
        XCTAssert(objects?.tDic["key1"] as? Bool == true )
        XCTAssert(objects?.tDic["key0"] as? Int == 0)
        XCTAssert(objects?.tDicOpt != nil)
        XCTAssert(objects?.tDictImp["key1"] as? Date != nil)
    }
}

class EnumTests: Test {
    
    func testRawEnum() {
        let test_out = TestRawEnum.ready
        _ = test_out.write(to: tempURLFor("test_raw_enum.plist"), format: .plist)
        let sut = TestRawEnum(plistFile: tempURLFor("test_raw_enum.plist"))
        XCTAssert(sut != nil)
        XCTAssert(sut == TestRawEnum.ready)
    }
    
    func testRegEnum() {
        let test_out = TestRegEnum.cold
        _ = test_out.write(to: tempURLFor("test_reg_enum.plist"), format: .plist)
        let sut = TestRegEnum(plistFile: tempURLFor("test_reg_enum.plist"))
        XCTAssert(sut != nil)
        XCTAssert(sut == TestRegEnum.cold)
    }
    
    func testAssociatedEnum() {
        
        func createBinary() -> Data? {
            if let path = Bundle(for: Test.self).path(forResource: "Data", ofType: "plist") {
                return  (try? Data(contentsOf: URL(fileURLWithPath: path)))
            }
            return nil
        }
        
        func performTestFor(_ testEnum: TestAssociatedEnum, message: String) {
            _ = testEnum.write(to: tempURLFor("test_associated_enum.plist"), format: .binary)
            let sut = TestAssociatedEnum(binaryFile: tempURLFor("test_associated_enum.plist"))
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
                    XCTAssert(t == UIColor.blue, message)
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
        performTestFor(TestAssociatedEnum.transformableColorType(UIColor.blue), message: "Color should be blue")
    }
    
    func testAssociatedDecodeableToManyEnum() {
        let employee = Employee(name: "Joe", title: "Manager")
        let employees = [employee, employee, employee]
        let test_out = TestAssociatedEnum.decodableToManyType(employees)
        _ = test_out.write(to: tempURLFor("test_associated_tomany_enum.plist"), format: .plist)
        let sut = TestAssociatedEnum(plistFile: tempURLFor("test_associated_tomany_enum.plist"))
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
        let sut = TestAssociatedEnum(plistFile: tempURLFor("test_associated_toone_enum.plist"))
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
            if let path = Bundle(for: Test.self).path(forResource: "Data", ofType: "plist") {
                return  (try? Data(contentsOf: URL(fileURLWithPath: path)))
            }
            return nil
        }
        
        func performTestFor(_ testEnum: TestAssociatedOptionalEnum, message: String) {
            _ = testEnum.write(to: tempURLFor("test_associated_optional_enum.plist"), format: .binary)
            let sut = TestAssociatedOptionalEnum(binaryFile: tempURLFor("test_associated_optional_enum.plist"))
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
                    XCTAssert(t == UIColor.blue, message)
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
        performTestFor(TestAssociatedOptionalEnum.transformableColorType(UIColor.blue), message: "Color should be blue")
    }
    
    func testAssociatedDecodeableOptionalToManyEnum() {
        let employee = Employee(name: "Joe", title: "Manager")
        let employees = [employee, employee, employee]
        let test_out = TestAssociatedOptionalEnum.decodableToManyType(employees)
        _ = test_out.write(to: tempURLFor("test_associated_optional_tomany_enum.plist"), format: .plist)
        let sut = TestAssociatedOptionalEnum(plistFile: tempURLFor("test_associated_optional_tomany_enum.plist"))
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
        let sut = TestAssociatedOptionalEnum(plistFile: tempURLFor("test_associated_optional_toone_enum.plist"))
        XCTAssert(sut != nil)
        
        switch sut! {
        case let .decodableToOneType(e):
            XCTAssert(e?.name == "Joe")
        default:
            XCTFail()
        }
    }
}

class RecursiveTests: Test {
    
    func testEncodingAndDecodingRecursiveModel() {
        var player = Player(id: 100, name: "player", age: 23)
        var players = [Player]()
        var innerPlayers = [Player]()
        for index in 1...10 {
            players.append(Player(id:index, name: "player\(index)", age:23 ))
        }
        for index in 1...5 {
            innerPlayers.append(Player(id:index, name: "player\(index)", age:23 ))
        }
        
        player.teamates = players
        player.teamates[3].fillins = innerPlayers
        
        _ = player.write(to: tempURLFor("player.plist"), format: .plist)
        let resultPlayer = Player(plistFile: tempURLFor("player.plist"))
        
        XCTAssert(resultPlayer != nil)
        XCTAssert(resultPlayer?.teamates.count == 10)
        XCTAssert(resultPlayer?.teamates[1].name != nil)
        XCTAssert(resultPlayer?.teamates[3].fillins?.count == 5)
    }
}

class RelationshipTests: Test {
    
    func makeChildren() -> [TestChild] {
        var children = [TestChild]()
        for index in 0...9 {
            var grandChildren = [Grandchild]()
            
            for index in 0...4 {
                let grandChild = Grandchild(age: index, name: "GrandChild\(index)", gender: Gender.female)
                grandChildren.append(grandChild)
            }
            let child = TestChild(age: index, name: "Child\(index)",   myChildren: grandChildren, gender: Gender.male)
            children.append(child)
        }
        return children
    }
    
    func makeGrandChildren(_ children: [TestChild]) -> [Grandchild] {
        var grandChildren = [Grandchild]()
        
        for child in children {
            if let grandkids = child.myChildren {
                grandChildren.append(contentsOf: grandkids)
            }
        }
        return grandChildren
    }
    
    func testCodingModelWithOneToMany() {
        let children = makeChildren()
        let grandChildren = makeGrandChildren(children)
        let sampleData = TestRelationships(myChildren: children, myGrandChildren: grandChildren, myOneChild: TestChild(age: 22, name: "Mark", myChildren: nil, gender: Gender.male ))
        _ = sampleData.write(to: tempURLFor("relationship.json"), format: .json)
        
        let testData = TestRelationships(jsonFile: tempURLFor("relationship.json"))
        
        XCTAssert(testData != nil)
        XCTAssert(testData?.myChildren?.count == sampleData.myChildren?.count)
        XCTAssert(testData?.myGrandChildren?.count == sampleData.myGrandChildren?.count)
        XCTAssert(testData?.myGrandChildren?[0].name == sampleData.myGrandChildren?[0].name)
        XCTAssert(testData?.myOneChild?.name == sampleData.myOneChild?.name)
        XCTAssert(testData?.myGrandChildren?[0].gender == sampleData.myGrandChildren?[0].gender)
        XCTAssert(testData?.myChildren?[3].age == sampleData.myGrandChildren?[3].age)
    }
    
    
    func testCodingModelWithDictionaryComposition() {
        var testComposition = TestDictionaryComposition(employees: [String : Employee]())
        let employee1 = Employee(name: "Jane", title: "Manager")
        let employee2 = Employee(name: "John", title: nil)
        testComposition.employees["Jane"] = employee1
        testComposition.employees["John"] = employee2
        _ = testComposition.write(to: tempURLFor("test_composition.plist"), format: .plist)
        
        let inTestComposition = TestDictionaryComposition(plistFile: tempURLFor("test_composition.plist"))
        XCTAssert(inTestComposition != nil)
        XCTAssert(inTestComposition?.employees["Jane"]?.title == "Manager")
    }
}

class TemplateTests: Test {
    
    func testEncodingAndDecodingAutoGeneratedModel() {
        var company = Company(name: "State llc",yearFounded: 2015, phoneNumber: "888-888-8888",  employees: [Employee]())
        let employee = Employee(name:"Joe", title: "CEO")
        company.employees?.append(employee)
        _ = company.write(to: tempURLFor("company.plist"), format: .plist)
        let testCompany = Company(plistFile: tempURLFor("company.plist"))
        
        XCTAssert(testCompany != nil)
        XCTAssert(testCompany?.name == "State llc")
        XCTAssert(testCompany?.phoneNumber == "888-888-8888")
        XCTAssert(testCompany?.yearFounded == 2015)
        XCTAssert(testCompany?.employees?.count == 1)
        XCTAssert(testCompany?.employees?[0].name == "Joe")
    }
    
    func testTypes() {
        let test_out = TestTypes()
        _ = test_out.write(to: tempURLFor("test_types.plist"), format: .binary)
        let sut = TestTypes(binaryFile: tempURLFor("test_types.plist"))
        XCTAssert(sut != nil)
        XCTAssert(sut?.myBinary != nil)
        XCTAssert(sut?.myDate != nil)
        XCTAssert(sut?.myFloat == 4.567)
        XCTAssert(sut?.myDouble == -0.02)
        XCTAssert(sut?.myInt == 5)
        XCTAssert(sut?.myString == "Hello World")
        XCTAssert(sut?.myDecimal == 3.14)
    }
    
    func testImmutableTypes() {
        let test_out = TestImmutableTypes()
        _ = test_out.write(to: tempURLFor("test_immutable_types.plist"), format: .binary)
        let sut = TestImmutableTypes(binaryFile: tempURLFor("test_immutable_types.plist"))
        XCTAssert(sut != nil)
        XCTAssert(sut?.myBinary != nil)
        XCTAssert(sut?.myDate != nil)
        XCTAssert(sut?.myFloat == 4.567)
        XCTAssert(sut?.myDouble == -0.02)
        XCTAssert(sut?.myInt == 5)
        XCTAssert(sut?.myString == "Hello World")
        XCTAssert(sut?.myDecimal == 3.14)
    }
    
    func testOptionalTypes() {
        let test_out = TestOptionalTypes.CreateTestInstance()
        _ = test_out.write(to: tempURLFor("test_optional_types.plist"), format: .binary)
        let sut =  TestOptionalTypes(binaryFile: tempURLFor("test_optional_types.plist"))
        XCTAssert(sut != nil)
        XCTAssert(sut?.myBinary != nil)
        XCTAssert(sut?.myDate != nil)
        XCTAssert(sut?.myFloat == 4.567)
        XCTAssert(sut?.myDouble == -0.02)
        XCTAssert(sut?.myInt == 5)
        XCTAssert(sut?.myString == "Hello World")
        XCTAssert(sut?.myDecimal == 3.14)
    }
    
    func testImmutableOptionalTypes() {
        let test_out = TestImmutableOptionalTypes()
        _ = test_out.write(to: tempURLFor("test_immutable_optional_types.plist"), format: .binary)
        let sut = TestImmutableOptionalTypes(binaryFile: tempURLFor("test_immutable_optional_types.plist"))
        XCTAssert(sut != nil)
        XCTAssert(sut?.myBinary != nil)
        XCTAssert(sut?.myDate != nil)
        XCTAssert(sut?.myFloat == 4.567)
        XCTAssert(sut?.myDouble == -0.02)
        XCTAssert(sut?.myInt == 5)
        XCTAssert(sut?.myString == "Hello World")
        XCTAssert(sut?.myDecimal == 3.14)
    }
    
    func testCollections() {
        var test_out = TestCollections()
        test_out.arrayOfStrings = ["string1", "string2", "string3"]
        test_out.dicOfInts["int1"] = 1
        test_out.dicOfInts["int2"] = 2
        test_out.dicOfInts["int3"] = 3
        test_out.setOfStrings = ["do", "ray", "me"]
        _ = test_out.write(to: tempURLFor("test_collections.plist"), format: .binary)
        let sut =  TestCollections(binaryFile: tempURLFor("test_collections.plist"))
        
        XCTAssert(sut != nil)
        XCTAssert(sut?.arrayOfStrings.count == 3)
        XCTAssert(sut?.dicOfInts.count == 3)
        XCTAssert(sut?.setOfStrings.count == 3)
    }
    
    func testRawEnum() {
        let test_out = TestRawEnum.ready
        _ = test_out.write(to: tempURLFor("test_enum.plist"), format: .plist)
        let sut = TestRawEnum(plistFile: tempURLFor("test_enum.plist"))
        XCTAssert(sut != nil)
        XCTAssert(sut == TestRawEnum.ready)
    }
    
    func testTransformable() {
        let test_out = TestTransformable( myTransformable: URL(string: "http://facebook.com")!, myTransformableImmutable: URL(string: "http://yahoo.com")!, myTransformableImmutableOptional: nil, myTransformableOptional:URL(string: "http://twitter.com")!)
        _ = test_out.write(to: tempURLFor("test_transformable.plist"), format: .binary)
        let sut =  TestTransformable(binaryFile: tempURLFor("test_transformable.plist"))
        XCTAssert(sut != nil)
        XCTAssert(sut?.myTransformable == test_out.myTransformable)
        XCTAssert(sut?.myTransformableImmutable == test_out.myTransformableImmutable)
        XCTAssert(sut?.myTransformableImmutableOptional == test_out.myTransformableImmutableOptional)
        XCTAssert(sut?.myTransformableOptional == test_out.myTransformableOptional)
    }
    
    func testOverrideType() {
        let test_out: TestOverrideType? = TestOverrideType(myURL: URL(string: "http://simpletouchsoftware.com"), myArrayOfString: ["string1", "string2"])
        XCTAssert(test_out != nil)
    }
}

class ProtocolTests : Test {
    
    func testCodingProtocols() {
        let testEmployee = Employee(name: "Test Employee", title: "Manager")
        let testGrandChild = Grandchild(age: 10, name: "Test Grandchild", gender: .male)
        let testChild = TestChild(age: 10, name: "Test Child", myChildren: [testGrandChild, testGrandChild], gender: .male)
        let testConformer1 = TestProtocolConformer(age: 19, ss_number: "12345", isReady: true, employee: testEmployee, children: [testChild, testChild])
        let testConformer2 = TestProtocolConformer2(name: "Test Conformer", ss_number: "1111111")
        let testProtocolContainer = TestProtocolContainter(testProtocol: testConformer1, testProtocols: [testConformer1, testConformer2], testProtocolsDict: ["Conformer 1" : testConformer1, "Conformer 2" : testConformer2])
        
        _ = testProtocolContainer.write(to: tempURLFor("testProtocol.plist"), format: .plist)
        print(tempPathFor("testProtocol.plist"))
        let inTestProtocolContainer = TestProtocolContainter(plistFile: tempURLFor("testProtocol.plist"))
        
        XCTAssertNotNil(inTestProtocolContainer)
    }
}

class ModelTests : Test {
    
    func testMakeDataInitWithData() {
        let testedSource = Store(properties: plistData["Users"] as! [String : AnyObject])
        let testedStore = testedSource.store(forKey: "t")
        let testedUser = User.read(from: testedStore!)
        let testData = testedUser?.makeData()
        XCTAssertNotNil(testData)
        let testUserIn = User(data: testData!)
        XCTAssert(testUserIn?.name == testedUser?.name)
    }
    
    func testWriteToFileInitModelArray() {
        let arraySource : [String : AnyObject] = plistData["Users"] as! [String : AnyObject]
        let testedStore = Store(properties: arraySource)
        let users : [User]? = testedStore.value(forKey: "t_arr")
        XCTAssertNotNil(users)
        _ = users?.write(to: tempURLFor("testModelArray.json"), format: .json)
        let usersIn : [User]? = Array<User>(jsonFile: tempURLFor("testModelArray.json"))
        XCTAssertNotNil(usersIn)
        XCTAssert(usersIn?.count == users?.count)
    }
    
    func testMakeFromAndInitWithDataArray() {
        let arraySource : [String : AnyObject] = plistData["Users"] as! [String : AnyObject]
        let testedStore = Store(properties: arraySource)
        let users : [User]? = testedStore.value(forKey: "t_arr")
        let stringUserArray = users?.makeData()
        let usersIn : [User]? = Array<User>(data: stringUserArray!)
        XCTAssertNotNil(usersIn)
        XCTAssert(usersIn?.count == users?.count)
    }
}
