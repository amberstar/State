
/******************************************************************************
Encodable:

encode models to key value data

******************************************************************************/

public protocol Encodable {
    func encode(encoder: Encoder)
}