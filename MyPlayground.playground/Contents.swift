//: Playground - noun: a place where people can play

import UIKit
import State



func tempPathFor(file: String) -> String {
   return NSString.pathWithComponents([NSTemporaryDirectory(), file])
}

let filename = tempPathFor("Test.plist")

let color = UIColor(red: 1.0, green: 0.5, blue: 0.3, alpha: 0.8)

let s = Store()
s.set("Color", color)

s.addStore("1.2.3.4.5")

s.getColor("Color")


