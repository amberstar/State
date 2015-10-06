/************************************************

        HUMAN GENERATED FILE

************************************************/
import STState
import Foundation

extension TestOptionalTypes {
    
    static func CreateTestInstance () -> TestOptionalTypes {
        var instance = TestOptionalTypes()
        instance.myBinary = TestOptionalTypes.createBinary()
        instance.myBoolean = true
        instance.myDate = NSDate()
        instance.myDecimal = NSDecimalNumber(double: 3.14)
        instance.myFloat = 4.567
        instance.myDouble = -0.02
        instance.myInt = 5
        instance.myString = "Hello World"
        return instance
    }

    private static func createBinary() -> NSData? {
        if let path = NSBundle(forClass: Test.self).pathForResource("Data", ofType: "plist") {
            return  NSData(contentsOfFile:path)
        }
        return nil
    }
}

///MARK: Coding
extension TestOptionalTypes {

    /**
    decoding is finished on the receiver
    - parameter decoder: the decoder used for decoding

    :Discussion: This method is called after decoding takes place.
    It provides a way to decode any further data with the decoder
    or to do any initialization needed after decoding.
    */
    func didFinishDecodingWithDecoder(decoder: Decoder) {

    }

    /**
    encoding will finish on the receiver
    - parameter encoder: the encoder used for encoding

    :Discussion: This method is called right before encoding finishes.
    It provides a chance to encode any further data with the encoder.
    */

    func willFinishEncodingWithEncoder(encoder: Encoder) {

    }
}
