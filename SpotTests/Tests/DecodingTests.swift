import XCTest
import Spot

class DecodingTests: Test {
       
    func testDecodingBools() {
        let bools: BasicTypes<Bool>? = Decoder.decode(plistData["Bool"])
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
        let ints: BasicTypes<Int>? = Decoder.decode(plistData["Int"])
        
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
        let doubles: BasicTypes<Double>? = Decoder.decode(plistData["Double"])
        
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
        let floats: BasicTypes<Float>? = Decoder.decode(plistData["Float"])
        
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
        let strings: StringTypes? = Decoder.decode(plistData["String"])
        
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
        let objects: AnyObjectTypes? = Decoder.decode(plistData["Object"])
        
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
        XCTAssert(objects?.tDictImp["key1"] as? NSDate != nil)
    }
}