#About State
[State](https://github.com/STLabs/State) is a Swift model framework. State  is for using `structs`,  `enums`, and `protocols` as models  and has serialization with API for plists, JSON, and Binary formats.

**Q.** What is a model?

**A.** A model is an item  type in your application that represents a distinct part of your applications data. Usually a model item is something you want to persist between launches of the application.

**Q.** What is a model framework?

**A.** A model framework is a framework focused on providing the API to convert your applications model items to and from a universal data formats, and reading and writing that data, typically using a database or files. 

**Q.** What is a model layer?

**A.** Typically an application has a user interface, a logic or controller, and a model layer. A model layer is the entire set of model items in your application that represent all of the data items of your application. 

**Q.** What is State? 

**A.** State is a light weight model framework written in Swift. It provides the API to save and load struct, enum, and protocol models to binary, plist, and JSON files. It allows you define one model, or an entire model layer. Models can be composed together in a one-to-one or one-to-many relationship.

State is **not** a database. Any add/delete/update functionality you need for your models themselves is up to you. State is focused on model composition and persistence. 

**Q.** What are the benefits of State vs. say a JSON parsing library?

**A.** JSON parsing libraries are more general in nature therefore the API is not as tightly focused on models themselves. State is focused on models specifically.  To that end it provides easy API for reading and writing JSON, Plists, and Binary files. State also has versioning and migration API built in to every model. In general State is designed for any application that has one, or hundreds of model items where you want to use lightweight plist, or JSON formats to store models, and you want to take advantage of Swift's structs, enums, and protocols.


Other Benefits Include:

* extremely light weight code base
* low dependency surface area
* support for struct, enum, and protocol model items
* models can have optional, non-optional, constant and transient properties.
* models can be composed together
* optional migration/version management if and when you need it


There is one more huge benefit if you want it. Automatic code generation. State comes with a set of custom Mogenerator templates that allow you to design your model layer in the Xcode Designer. With a little bit of set-up you can get up and running, and be able to define models graphically and have all the code generated for you. This allows you to define, and modify, and grow your model layer very quickly.
