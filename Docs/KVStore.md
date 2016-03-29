# KVStore [WIP]

A KVStore is a hierarchical in-memory key-value store. It is a repository to store a collection of models, and values.
It is divided up into keys and values. A key is like a category, or a
sub-folder, which contains values, and possibly more child keys.

A KVStore can:
- store and retrieve basic types (String, Int, etc.)
- store type safe models (decodable, encodable)



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


