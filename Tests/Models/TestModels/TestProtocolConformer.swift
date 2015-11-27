/************************************************

        WARNING: HUMAN GENERATED FILE

************************************************/
import STState

extension TestProtocolConformer {
    public var name : String {
        get {
            return "hello"
        }
        // implement protocol requirement here
    }

   public var grandchild: Grandchild {
        get {
            return Grandchild()
        }
    
    }

   public func getFullName() -> String {
        // implement protocol requirement here
        return "Hello"
    }
   public func calculateAge() -> Int {
        // implement protocol requirement here
        return 10
    }

    // Extend your entity here.
}


// MARK: Migration
extension TestProtocolConformer {

    // implement migration here. See: https://github.com/STLabs/STState/blob/feat/swift2.0/Docs/Migration.md
}
