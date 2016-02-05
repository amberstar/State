/************************************************

        WARNING: HUMAN GENERATED FILE

************************************************/
import State

extension TestMigrationV2 {

    // Extend your model entity here.
}


///MARK: Migration
extension TestMigrationV2 {

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
        var newData = data
        newData.updateValue(10, forKey: "age")
        return newData
    }
}
