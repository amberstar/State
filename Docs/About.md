#About State
[State](https://github.com/STLabs/State) is a swift model framework. It allows you to optionally design models just like you do with Core Data. (with the data modeler inside of Xcode) State  uses `structs`,  `enums`, and `protocols` . Serialization is really simple with API for plists, JSON, and Binary files.

**Q.** What is a model?

**A.** A model is an item  type in your application that represents a distinct part of your applications data. Usually a model item is something you want to persist between launches of the solution.

**Q.** What is a model framework?

**A.** A model framework is a framework focused on providing the API to convert your applications model items to and from a universal data format, and reading and writing that data, typically using files. (but can be NSData, or String)

**Q.** What is a model layer?

**A.** Typically an application has a user interface, a logic, and a model layer. A model layer is the entire set of model items in your application that represent all of the data items of your application. 

**Q.** What is State? 

**A.** State is a light weight model framework written in Swift. It provides the API to save and load models to binary, plist, and JSON files, NSData, or Strings. It allows you define one model, or an entire model layer. You can define your models by hand coding them, or by designing them in the Xcode data model designer, and generate the code automatically. State supports Structs, Enums, and Protocols. Models can be composed together in a one-to-one or one-to-many relationship.

**Q.** What do you mean when you say State supports something.

**A.** When I say State supports something I mean it can be part of the model layer and be persisted using the API.

**Q.** What are the benefits of State

**A.** State is designed for the application that has one, or a hundred model items where you want to use lightweight plist, or JSON formats to store models, and you want to take advantage of Swift's structs, enums, and protocols.

Benefits Include:

* extremely light weight code base
* low dependency surface area
* No subclassing of a base class
* support for struct, enum, and protocol model items
* models can have optional, non-optional, constant and transient properties.
* models can be composed together
* optional migration/version management if you need it

Most frameworks require all optionals, or all vars. I see that as a compromise.

There is one more huge benefit if you want it. Automatic code generation. Separate from the framework itself, State comes with a set of custom Mogenerator templates that allow you to design your model layer in the Xcode Designer. With a little bit of set-up you can get up and running, and be able to define models graphically and have all the code written for you. This allows you to define, and modify, and grow your model layer very quickly.
