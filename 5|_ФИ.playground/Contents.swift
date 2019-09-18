import UIKit

enum trunkState {
    case full, empty
}

enum engineState {
    case start, stop
}

enum windowState {
    case open, close
}

protocol Car {
    var brand: String {get set}
    var model: String {get set}
    var color: String {get set}
    
    func beep()
}

extension Car {
    
    func engineState(state: engineState) {
    switch state {
    case .start:
        print("Trunk is full")
    case .stop:
        print("Trunk is empty")
        
    }
}
    func windowState(state: windowState) {
    switch state {
    case .open:
        print("Window is open")
    case .close:
        print("Window is close")
    }
}
    func trunkState(state: trunkState) {
        switch state {
        case .full:
            print("Trunk is full")
        case .empty:
            print("Trunk is empty")
            }
}
    func beep() {
    }
}
class trunkCar: Car {
    
    enum Trailer: String {
        case yes, no
    }
    
    var brand: String
    
    var model: String
    
    var color: String
 
    var isTrailer: Trailer
        
        init(brand: String, model: String, color: String, isTrailer: Trailer) {
            self.brand = brand
            self.model = model
            self.color = color
            self.isTrailer = isTrailer
            
        }
}
extension trunkCar: CustomStringConvertible {
    var description: String {
        return "Truck \(self.brand), model \(self.model), color \(self.color), trailer \(self.isTrailer)"
    }
}

class sportCar: Car {
   
    enum Turbo: String {
        case on, off
        }
   
    var brand: String
    
    var model: String
    
    var color: String
    
    var turbo: Turbo
 
    init(brand: String, model: String, color: String, turbo: Turbo) {
        self.brand = brand
        self.model = model
        self.color = color
        self.turbo = turbo
    }
}
extension sportCar: CustomStringConvertible {
    var description: String {
        return "SportCar \(self.brand), model \(self.model), color \(self.color), turbo is \(self.turbo)"
    }
}

let trunk01 = trunkCar(brand: "Volvo", model: "FH16", color: "BLACK", isTrailer: .yes)
print(trunk01)

let sportCar01 = sportCar(brand: "Ferrari", model: "F30", color: "RED", turbo: .off)
print(sportCar01)
