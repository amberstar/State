#DissolverTransform

The `DissolverTransform` is usefull when you do not want to make a property optional, but you do not want to persist empty collections.
The dissolver will convert any empty collection to nil when encoding so that it will be ignored. During Decoding, the dissolver will convert a nil value back to an empty collection.

You use the `DissolverTransform` just like any other transform, but in particular, if you are using it with a model type relationship, you must use the STState.Transformable key on the relationship. ( this is because there is no transformable option in the inspector window as there is with Attributes.)

- Add the key STState.Transformable to the relationship, and specify `DissolverTransform` as the value.



### The following ValueTransforms are included with STState
* UIColorTransform
* UInt64Transform
* URLTransform
* DessolverTransform
