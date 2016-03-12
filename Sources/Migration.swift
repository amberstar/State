let default_version_key = "model_version"
let blank_version_hash = ""

// All implemented as func because: http://openradar.appspot.com/21550415
/// Provides migration and version managment for models
public protocol Migratable {
    static func version(modelVersionHash: String, modelVersionHashModifier: String?) -> AnyObject?
    static func needsMigration(dataVersion: AnyObject) -> Bool
    static func shouldEncodeVersion() -> Bool
    static func shouldMigrateIfNeeded() ->  Bool
    static func versionKey() -> String
    static func modelVersionHash() ->  String 
    static func modelVersionHashModifier() -> String?
    static func migrateDataForDecoding(data: [String : AnyObject], dataVersion: AnyObject) -> [String : AnyObject]
}

/// Default Migration Implementations. 
/// To support migration for your models override these methods in your model.
public extension Migratable {
    
    /// true if the encoder should include a model version
    /// when encoding the model. Set to false if you do not want a version
    ///  encoded with your model.
    /// -note: this value must be yes to support migration
    static func shouldEncodeVersion() -> Bool {
        return false
    }
    
    /// the key to use for encoding/decoding the model version
    /// only used if shouldEncodeVersion is set to true
    static func versionKey() -> String {
        return default_version_key
    }

    /// true if the decoder should perform a migration attempt
    /// during decoding of the model
    /// If set to false no migration attempt will be made
    static func shouldMigrateIfNeeded() -> Bool {
        return false
    }

    /// calculate the current model version based on modelVersionHash information
    /// - parameter modelVersionHash: a unique hash from the model design that generated the model
    /// - parameter modelVersionHashModifier: a hash modifier if any from the model design that generated the model
    /// - returns: an object the represents the model version used to denote the model "version"
    /// - note: This method is called during encoding and decoding when the version is needed.
    /// The modelVersionHash and modelVersionHashModifier are provided from the model designer to help denote
    /// a unique version. What type, and how to make that denotation is unspecified, and ultimatly up to the impementation
    /// of this method.
    static func version(modelVersionHash: String, modelVersionHashModifier: String?) -> AnyObject? {
        return modelVersionHash
    }

    /// determines if the model data being decoded needs migration
    /// - parameter dataVersion: the version of the data to be decoded
    /// - returns: true if a migration is needed
    /// - note: This method is called during decoding if
    /// * shouldMigrateIfNeeded returns true
    /// * a version was found in the data using the versionKey
    
    /// given the dataVersion parameter, this method should determine if the data being decoded is a different version
    /// than the current version, and needs to be migrated.
    static func needsMigration(dataVersion: AnyObject) -> Bool {
        if let dataVersion = dataVersion as? String,
            currentVersion = version( modelVersionHash(), modelVersionHashModifier: modelVersionHashModifier()) as? String {
                return dataVersion != currentVersion
        } else {
            return false
        }
    }
    
    /// migrate model data before decoding
    /// - parameter data: model data that needs migration
    /// - parameter dataVersion: the version of the data to be migrated
    /// - returns: migrated data
    /// - note: This method is called during decoding if the following are true:
    /// * shouldMigrateIfNeeded returns true
    /// * a version was found in the data using the versionKey
    /// * needsMigration returns true
    
    /// This method should perform the migration needed to prepare the data for decoding.
    /// Here you can add keys and values, remove keys and values, rename properties, etc.
    /// migrated data returned will then be used for decoding the model.
    static func migrateDataForDecoding(data: [String : AnyObject], dataVersion: AnyObject) -> [String : AnyObject] {
        return data
    }

    /// These are provided from the data model designer
    /// and can be used to determine if the model is
    /// a different version.
    static func modelVersionHash() -> String {
        return blank_version_hash
    }

    static func modelVersionHashModifier()-> String? {
        return nil
    }
}

public extension Migratable where Self: Decodable {
    static func performMigrationIfNeeded(decoder: Decoder) -> Decoder {
        guard Self.shouldMigrateIfNeeded() else { return decoder }
        
        if let dataVersion: AnyObject = decoder.decode(Self.versionKey()) where Self.needsMigration(dataVersion) {
            let migratedData = Self.migrateDataForDecoding(decoder.extractData(), dataVersion: dataVersion)
            return Decoder(data: migratedData)
        }
        return decoder
    }
}

public extension Migratable where Self: Encodable {
    static func encodeVersionIfNeeded(e: Encoder) {
        var encoder = e
        guard Self.shouldEncodeVersion() else { return  }
        encoder.encode(Self.version(Self.modelVersionHash(), modelVersionHashModifier: Self.modelVersionHashModifier()), Self.versionKey())
    }
}