# KeyStore

A KVStore hierarchical key-value store. It is a repository to store a collection of models, and values.
It is divided up into keys and values. A key is like a category, or a
sub-folder, which contains values, and possibly child keys.

- store and retrieve basic types (String, Int, etc.)
- store type safe models (decodable, encodable)
- has keys and values, keys are child stores
- keys can optionally be stored externally to a seperate file
- keys can be volatile



KVStore
   |
   |- KEY
   |   |
   |   |- VALUE
   |   |- VALUE
   |
   |- KEY
   |   |
   |   |- VALUE
   |   |- VALUE