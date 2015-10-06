/************************************************

        HUMAN GENERATED FILE

************************************************/
import STState
import Foundation

extension TestImmutableTypes {

    init() {
        self.myBinary = TestImmutableTypes.createBinary()!
        self.myBoolean = true
        self.myDate = NSDate()
        self.myDecimal = NSDecimalNumber(double: 3.14)
        self.myFloat = 4.567
        self.myDouble = -0.02
        self.myInt = 5
        self.myString = "Hello World"
    }
    
    private static func createBinary() -> NSData? {
        if let path = NSBundle(forClass: Test.self).pathForResource("Data", ofType: "plist") {
            return  NSData(contentsOfFile:path)
        }
        return nil
    }
}

///MARK: Coding
extension TestImmutableTypes {

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

