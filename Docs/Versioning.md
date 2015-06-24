## Versioning and Migration Managment
Versioning and migration management is opt in. It allows you to fully control the version and migration of the models. The automatic layer of the model code passes delegation to the manual layer.  It's in the manual layer that you  specify and control all of the following:
- if models should be versioned when encoded
- a versionKey to use for the version encoding
- the current version of the model
- if version checking and migration is done at all
- does a model need migration
- directly migrate raw key-value data to the current version before attempting to read a model

When designing the models in the model designer, you can specify a version hash modifier signifying a new model version. This version modifier get's carried over to the model code so you can determine if a model version about to be decoded is a different version than the current version of the model code.