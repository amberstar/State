import Spot

public enum Item {
    
    case EmployeeType (Employee)
    case StringType(String)
    
    
    init?(type: String, value: AnyObject) {

        switch (type, value) {
        case  ("EmployeeType", let value as Employee) :
            self = item.EmployeeType(value)
        case ("StringType", let value as String) :
            self = item.StringType(value)
        default:
            return nil
        }
    }
}


extension Item : Decodable {
       
    public init?(var decoder: Decoder) {
        
        if Item.shouldMigrateIfNeeded {
            if let dataVersion: AnyObject = decoder.decode(Item.versionKey) {
                if Item.needsMigration(dataVersion) {
                    let migratedData = Item.migrateDataForDecoding(decoder.extractData(), dataVersion: dataVersion)
                    decoder = Decoder(data: migratedData)
                }
            }
        }
        
        if let type: String  = decoder.decode("type") {
            switch type {
                case "EmployeeType":
                    if let value : Employee = decoder.decode("value") {
                        self = Item.EmployeeType(value)
                    } else { return nil }
                
                case "StringType":
                
            default:
                return nil

            }
        }
    
    }
}


extension Item : Encodable {
    
    public func encode(encoder: Encoder) {
        
        switch self {
        case let .EmployeeType(employee) {
            encoder.encode("EmployeeType" forKey: "type")
            encoder.encode(employee forKey: "value")
            }
        }
        
        encoder.encode(self.name, forKey: "name")
        encoder.encode(self.title, forKey: "title")
        
        if Employee.shouldEncodeVersion {
            encoder.encode(Employee.version, forKey:Employee.versionKey)
        }
        self.willFinishEncodingWithEncoder(encoder)
    }
}

