import UIKit

struct Queue<T>: CustomStringConvertible {
    
    var array = [T]()
   
    var isEmpty: Bool {
        return array.isEmpty
    }
    var count: Int {
    return array.count
}
func getCount() -> String {
    return "\(count) items in line"
}
    mutating func enQueue(_ element: T) {
        array.append(element)
}
    mutating func deQueue() -> T! {
        if isEmpty {
            return nil
        } else {
            let removedElement = array.last
            print("Delete \(String(describing: removedElement!))")
            return array.removeLast()
        }
}
    var front: T! {
        return array.last
    }
    
  var description: String {
        return "Queue contents: \(self.array)"
    }
    
   func filter(array: [T], predicateSomeClosure: (T) -> Bool) -> [T] {
        
        var tmpArray = [T]()
        
        for element in array {
            if predicateSomeClosure(element) {
                tmpArray.append(element)
            }
        }
        
        return tmpArray
    }
    
}
    print("Queue implementation")

    var q01 = Queue<String>()

    print(q01)

q01.enQueue("Toyota")

q01.enQueue("BMW")

q01.enQueue("Mercedes-benz")

print(q01.getCount(), "\n")

print("\(q01)")

let sortedQueue = q01.array.sorted(by: >)
print("Sorted order in decreasing order: \(sortedQueue)\n")

let filteredQueue = q01.filter(array: q01.array) { (s1: String) -> Bool in
    return s1 == "Toyota"
}
print("Array from the filter queue: \(filteredQueue)\n")

while (q01.count > 0) {
    q01.deQueue()
    print(q01)
    print(q01.getCount())
}
