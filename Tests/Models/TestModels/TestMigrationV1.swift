/************************************************

        WARNING: HUMAN GENERATED FILE

************************************************/
import STState

extension TestMigrationV1 {

    // Extend your model entity here.
}

///MARK: Coding
extension TestMigrationV1 {

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
        encoder.encode("Hello World", "migration_test")
    }
}

///MARK: Migration
extension TestMigrationV1 {

    /**
    true if the encoder should include a model version
    when encoding the model.
    */
    public static func shouldEncodeVersion() -> Bool {
        return true
    }

    /**
    true if the decoder should perform a migration if needed
    during decoding of the model
    */
    public static func shouldMigrateIfNeeded() -> Bool {
        return true
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
    public static func needsMigration(dataVersion: AnyObject) -> Bool {
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
   public static func migrateDataForDecoding(data: [String : AnyObject], dataVersion: AnyObject) -> [String : AnyObject] {
        return data
    }
}
