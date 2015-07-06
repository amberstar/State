/************************************************

        WARNING: MACHINE GENERATED FILE

 ************************************************/
import Foundation
import State

public protocol TestProtocol : TestParentProtocol {

   var age : Int? { get set }
   var name : String { get }

   var children : [TestChild] { get set }
   var grandchild : Grandchild { get }

}

extension TestProtocol {

    /// These are provided from the data model designer
    /// and can be used to determine if the model is
    /// a different version.
    public static func modelVersionHash() -> String {
        return "<db58f1fd 6d599ec8 9d037779 e8348f86 2b66e21d ad7b2763 e9b20a65 da3cf127>"
    }

    public static func modelVersionHashModifier() -> String? {
        return nil
    }
}

