# KVStore

A KVStore is a hierarchical key-value store. It is a repository to store a collection of models, and values.
It is divided up into keys and values. A key is like a category, or a
sub-folder, which contains values, and possibly more child keys.

- store and retrieve basic types (String, Int, etc.)
- store type safe models (decodable, encodable)
- any key can optionally be stored externally to a seperate file
- any key can optionally be volatile (not persistent)


```
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
```