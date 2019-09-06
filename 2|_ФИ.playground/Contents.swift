import UIKit
import Foundation

// 1.

func myValue (value: Int) {
    
    let x1 = value
    let x2 = x1 % 2
    
    x2 == 0 ? print("even") : print("odd")
}

myValue(value: 25)

//2.

func myValue2 (value: Int) {
    
    let y1 = value
    let y2 = y1 % 3
   
    y2 == 0 ? print(true) : print(false)
}

myValue2(value: 3)

//3, 4.

var testNum: [Int] = []
for i in 0..<100 {
    testNum.append(i)
}
testNum

for element in testNum where (element % 2 == 0)  || (element % 3 == 0) {
    testNum.remove(at : (testNum.firstIndex(of: element)!))
}
testNum

//5.

func fibonacci (n: Int) -> (Decimal) {
    if (n < 3) {
        return 1
    } else {
        var f1 : Decimal = 1, f2 : Decimal = 1, f : Decimal
        for _ in 3...n {
            f = f1 + f2
            f1 = f2
            f2 = f
        }
        return f2
    }
}

var fibNum = [Decimal]()
fibNum.append(0)
var n  = 100
for i in 1...n {
    fibNum.append(fibonacci(n: i))
}
print(fibNum)

//6.

func prime (num: Int) -> Bool {
    if num < 2 {
        return false
    }
    for i in 2..<num {
        if num % i == 0 {
            return false
        }
    }
    
    return true
}
func primeArray () -> [Int] {
    var results = [Int]()
    var i = 2
    while results.count < 100 {
        if prime(num: i) {
            results.append(i)
        }
        i += 1
    }
    
    return results
}
print (primeArray())
