/************************************************

        HUMAN GENERATED FILE

************************************************/
import State

extension Gender {

    // Extend your model entity here.
}

///MARK: Coding
extension Gender {

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

///MARK: Migration
extension Gender {

    /**
    true if the encoder should include a model version
    when encoding the model.
    */
    static var shouldEncodeVersion: Bool {
        return false
    }

    /**
    true if the decoder should perform a migration if needed
    during decoding of the model
    */
    static var shouldMigrateIfNeeded: Bool {
        return false
    }

    /**
    a key to use for encoding the model version
    */
    static var versionKey: String {
        return "model_version"
    }

    /**
     the current model version
    - parameter modelVersionHash: a unique hash from the model design that generated the model
    - parameter modelVersionHashModifier: a hash modifier if any from the model design that generated the model
    - returns: an object the represents the model version used to denote the model "version"

    :Discussion: This method is called during encoding and decoding when the version is needed.
    The modelVersionHash and modelVersionHashModifier are provided from the model designer to help denote
    a unique version. What type, and how to make that denotation is unspecified
    */
    static func version(modelVersionHash: String, modelVersionHashModifier: String?) -> AnyObject? {
        return modelVersionHash
    }

    /**
    determines if the model data being decoded needs migration
    - parameter dataVersion: the version of the data to be decoded
    - returns: true if a migration is needed

    :Discussion: This method is called during decoding if
        - shouldMigrateIfNeeded returns true
        - a version was found in the data using the versionKey
    given the dataVersion parameter, this method should determine if the data being decoded is a different version
    than the current version, and needs to be migrated.
    */
    static func needsMigration(dataVersion: AnyObject) -> Bool {
        if let dataVersion = dataVersion as? String,
            currentVersion = version( modelVersionHash, modelVersionHashModifier: modelVersionHashModifier) as? String {
            return dataVersion != currentVersion
        } else {
            return false
        }
    }

    /**
    migrate model data before decoding
    - parameter data: model data that needs migration
    - parameter dataVersion: the version of the data to be migrated
    - returns: migrated data

    :Discussion: This method is called during decoding if the following are true:
    - shouldMigrateIfNeeded returns true
    - a version was found in the data using the versionKey
    - needsMigration returns true

    This method should perform the migration needed to prepare the data for decoding.
    Here you can add keys and values, remove keys and values, rename properties, etc.
    migrated data returned will then be used for decoding the model.

    Note: the data version will automatically be updated the next time the model is encoded.
    */
    static func migrateDataForDecoding(data: [String : AnyObject], dataVersion: AnyObject) -> [String : AnyObject] {
        return data
    }
}