#Protocols

## Creating protocols
You can create protocols in the data model designer.
You  create protocols by specifying the `State.Protocol` key or checking the abstract checkbox in the inspector for the entity to be a protocol. 

##Conforming to protocol
To specify a model item has conformance to a protocol, set the protocol as the parent entity of a model item. 

**Note:** You do not need to re-specify the protocols requirements in your conforming entity, they will be inherited and implemented automatically.

## Using protocols

You can use protocols as types just like struct and enum types. A protocol extension is started for you in the manual file so you can extend your protocol if needed.

You can compose with protocols. For example, one model item can have a one to many composition to a protocol type. This allows you to add any conforming type into the composition collection of the containing model type. 

Notes:
* Protocols can inherit from other protocols
* Protocol requirements can include other model items
* Model items can have relationships to protocol types.
