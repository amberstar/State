/************************************************

        WARNING: MACHINE GENERATED FILE

 ************************************************/
import Foundation
import State

public struct Company : Model {
    public var name: String
    public var yearFounded: Double
    public var phoneNumber: String?
    public var employees: [Employee]?

}

extension Company : Decodable {

   public static func decode(_ decoder: Decoder) -> Company? {
      return self.init(decoder: decoder)
   }

    public init?(decoder d: Decoder) {
        var decoder = d
        decoder = Company.performMigrationIfNeeded(decoder)

         guard
            let name: String = decoder.decode("name"),
            let yearFounded: Double = decoder.decode("yearFounded")
         else { return  nil }

        let phoneNumber: String? = decoder.decode("phoneNumber")
        let employees: [Employee]? = decoder.decode("employees")

        self.name = name
        self.yearFounded = yearFounded
        self.phoneNumber = phoneNumber
        self.employees = employees
        didFinishDecoding(decoder: decoder)
    }
}

extension Company : Encodable {

    public func encode(_ encoder: Encoder) {
        encoder.encode(name, "name")
        encoder.encode(yearFounded, "yearFounded")
        encoder.encode(phoneNumber, "phoneNumber")
        encoder.encode(employees, "employees")

        Company.encodeVersionIfNeeded(encoder)

        self.willFinishEncoding(encoder: encoder)
    }
}

extension Company {

    /// These are provided from the data model designer
    /// and can be used to determine if the model is
    /// a different version.
    public static func modelVersionHash() -> String {
        return "<96a6f843 e4004fa9 5be7cca8 25260494 31324f8c 67a0643f 53096004 e1f9e4f0>"
    }

    public static func modelVersionHashModifier() -> String? {
        return nil
    }
}

//****************************************************************************//
// MARK: UserDefaults support
//****************************************************************************//
extension UserDefaults {

   public func getCompany(forKey key: String) -> Company? {
      guard let dictionary = dictionary(forKey: key) else { return nil }
      return Company.decode(dictionary)
   }

   public func getCompany(forKey key: String) -> [Company]? {
      guard let array = array(forKey: key) else { return nil }
      return sequence(array.map(Company.decode))
   }

   public func getCompany(forKey key: String) -> [String : Company]? {
      guard let dictionary = dictionary(forKey: key) else { return nil }
      return sequence(dictionary.map { Company.decode($0) })
   }

   public func getCompany(forKey key: String, defaultValue: Company) -> Company {
      return getCompany(forKey: key) ?? defaultValue
   }

   public func getCompany(forKey key: String, defaultValue: [Company]) -> [Company] {
      return getDecodable(key) ?? defaultValue
   }

   public func getCompany(forKey key: String,  defaultValue: [String : Company]) -> [String : Company] {
      return getCompany(forKey: key) ?? defaultValue
   }

   public func setCompany(value: Company, forKey key: String) {
      set(value.encode(), forKey: key)
   }

   public func setCompany(value: [Company], forKey key: String) {
      set(value.map { $0.encode() }, forKey: key)
   }

   public func setCompany(value: [String : Company], forKey key: String) {
      set(value.map { $0.encode() }, forKey: key)
   }
}

//****************************************************************************//
// MARK: KVStore support
//****************************************************************************//
extension KVStore {

   public func getCompany(forKey key: String) -> Company? {
      return getValue(forKey: key)
   }

   public func getCompany(forKey key: String, defaultValue: Company) -> Company {
      return getCompany(forKey: key) ?? defaultValue
   }

   public func getCompanys(forKey key: String) -> [Company]? {
      return getValue(forKey: key)
   }

   public func getCompanys(forKey key: String, defaultValue: [Company]) -> [Company] {
      return getCompanys(forKey: key) ?? defaultValue
   }

   public func getCompanyDictionary(forKey key: String) -> [String : Company]? {
      return getValue(forKey: key)
   }

   public func getCompanyDictionary(forKey key: String, defaultValue: [String : Company]) -> [String : Company] {
      return getCompanyDictionary(forKey: key) ?? defaultValue
   }
}

