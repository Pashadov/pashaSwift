//: Playground - noun: a place where people can play

import UIKit

// 1.

var a = 8
var b = 13
var c = 15

if (a != 0) {
    if (b != 0) && (c != 0) {
        let d = (b * b - 4 * a * c)
        if (d < 0) {
            print ("No roots")
        } else if (d == 0) {
            let x = (-b) / 2 * a
            print ("root: \(x)")
        } else if (d > 0) {
            let x1: Double = ((Double(-b)) + (Double(d)))/2 * Double(a)
            let x2: Double = ((Double(-b)) - (Double(d)))/2 * Double(a)
            print("first root: \(x1), second root: \(x2)")
        } else if (c == 0) {
    let x1 = 0
    let x2 = (-b)/a
    print(x1, x2)
} else if (b == 0) && ((a > 0) && (c < 0)) || ((a < 0) && (c > 0)) {
    let x = (Double(Double(-c)/Double(a)))
    print ("first root: +\(x), second root: -\(x)")
} else {
            print ("input error. It's not a quadratic equation if a = 0") }
    }}

// 2.

var leg1: Double = 11
var leg2: Double = 20

let hypotenuse: Double = leg1 * leg2 + leg2 * leg2
let squre : Double = (leg1 * leg2)/2
let perimetr : Double = leg1 + leg2 + hypotenuse

print ("Hypotenuse: \(hypotenuse)")
print ("Squre: \(squre)")
print ("Perimetr: \(perimetr)")

// 3.

var count: Double = 12345678
var percent: Double = 11.8
var i = 1

while i < 6 {
    i += 1
    count = count + (count * percent)/100
}
print ("The result, after five years is: \(count))")
