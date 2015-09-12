/************************************************

        WARNING: HUMAN GENERATED FILE

************************************************/
import State

extension TestProtocolConformer {

    // Extend your entity here.
}



extension TestProtocolContainter  {
    
}

// MARK: Coding
extension TestProtocolConformer {

    /// decoding is finished on the receiver
    /// - Parameter decoder: the decoder used for decoding
    ///
    /// - Note: This method is called after decoding takes place.
    /// It provides a way to decode any further data with the decoder
    /// or to do any initialization needed after decoding.
    ///
    func didFinishDecodingWithDecoder(decoder: Decoder) {

    }

    /// encoding will finish on the receiver
    /// - parameter encoder: the encoder used for encoding
    ///
    /// - Discussion: This method is called right before encoding finishes.
    /// It provides a chance to encode any further data with the encoder.
    ///
    func willFinishEncodingWithEncoder(encoder: Encoder) {
      
    }
}

// MARK: Migration
extension TestProtocolConformer {

    // implement migration here. See: https://github.com/STLabs/State/blob/feat/swift2.0/Docs/Migration.md
}
