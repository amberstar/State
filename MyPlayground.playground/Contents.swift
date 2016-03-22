//: Playground - noun: a place where people can play

import UIKit
import State



func tempPathFor(file: String) -> String {
   return NSString.pathWithComponents([NSTemporaryDirectory(), file])
}

let storeA = KVStore()





storeA.createKey("My.New.Key")

storeA.getKey("My.New.Key")?.path = tempPathFor("External.plist")

storeA.save(tempPathFor("Main.plist"))

print(tempPathFor("Main.plist"))