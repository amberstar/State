#Protocols

### Creating protocols
You can design protocols in the data model designer.
You  create protocols by specifying the `State.Protocol` key or checking the abstract checkbox in the inspector for the entity to be a protocol. 


###Conforming to protocol
To specify a model item has conformance to a protocol, set the protocol as the parent entity of your model item. 

**Note:** You do not need to re-specify the protocols requirements in your conforming entity, they will be inherited and implemented automatically.

### Using protocols


Protocols like structs and enums, are extended to contain versioning information and a protocol extension is created for you to extend your protocols in the manual file.


Protocols ***can not** be composed directly in model items because there is no way to determine what the concrete type is when decoding the model item. For that reason you should always compose concrete model types.

If you wish to have a composition to a protocol, one way to achieve this is by using an enum, where each case contains a concrete associated type. Then you can unbox the type from the enum case. This allows you to have any conforming type composed, but will require an unboxing step to unwrap the concrete type.


Notes:
* Protocols can inherit from other protocols
* Protocol requirements can include other model items
* Model items cannot have relationships to protocols unless the item is transient
