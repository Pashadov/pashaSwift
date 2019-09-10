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

struct Car {
    let brand: String
    var model: String
    let color: String

mutating func changeModel(c:String) {
    switch c {
    case "C300":
        self.model = " C300"
    case "CL500":
        self.model = " CL500"
    case "G500":
        self.model = " G500"
    case "GL500":
        self.model = " GL500"
    default:
        print("Input error.")
    }
    }
    
    let release : Int
    var trunkVolume : Double {
        willSet {
            if (trunkState == .empty) && (trunkVolume > 0) && (trunkVolume != 0) && (newValue < trunkVolume) {
                let space = trunkVolume - newValue
                print ("\(brand)\(model) trunk free: \(space)")
            } else { print("Input error or \(brand)\(model) trunk is full.")}
        }
    }
    
    var engineState : engineState {
        willSet {
            if newValue == .start {
                print ("\(brand)\(model) engine is on")
            } else {print("\(brand)\(model) engine is off")}
        }
    }
    
    var windowState : windowState {
        willSet {
            if newValue == .open {
                print("\(brand)\(model) windows are open")
            } else { print("\(brand)\(model) windows are close") }
        }
    }
    
    var trunkState : trunkState
    mutating func emptyTrunck() {
        self.trunkState = .empty
        print ("\(brand)\(model) trunck is empty")
    }
}

var car1 = Car(brand: "Mercedes", model: " SL500", color: "black", release: 2006, trunkVolume: 450.0 , engineState: .stop, windowState: .open, trunkState: .empty)

car1.engineState = .start
car1.trunkVolume = 340.0
car1.changeModel(c: "G500")

print ("Information about the first car: brand&model: \(car1.brand)\(car1.model), release: \(car1.release), color: \(String(describing: car1.color)), free trunkVolume: \(car1.trunkVolume), engine is \(car1.engineState)")


struct Truck {
    let brand : String
    let model : String
    var color : String
    
    mutating func changeColor(c:String) {
        switch c {
        case "white":
            self.color = "white"
        case "black":
            self.color = "black"
        case "red":
            self.color = "red"
        case "blue":
            self.color = "blue"
        default:
            print("Input error.")
        }
    }
    
    let release : Int
    var bodyVolume : Double {
        willSet {
            if (trunkState == .empty) && (bodyVolume > 0) && (bodyVolume != 0) && (newValue < bodyVolume) {
                let space = bodyVolume - newValue
                print ("\(brand)\(model) trunk free: \(space)")
            } else { print("Input error or \(brand)\(model) trunk is full.")}
        }
    }
    var engineState : engineState {
        willSet {
            if newValue == .start {
                print ("\(brand)\(model) engine is on")
            } else {print("\(brand)\(model) engine is off")}
        }
    }
    
    var windowState : windowState {
        willSet {
            if newValue == .open {
                print("\(brand)\(model) windows are open")
            } else { print("\(brand)\(model) windows are close") }
        }
    }
    
    var trunkState : trunkState
    mutating func emptyTrunck() {
        self.trunkState = .empty
        print ("\(brand)\(model) trunck is empty")
    }
}

var truck1 = Truck(brand: "VOLVO", model: " FH16", color: "white", release: 2012, bodyVolume: 100000.0, engineState: .start, windowState: .open, trunkState: .full)

truck1.engineState = .stop
truck1.windowState = .close

print ("Information about the first car: brand&model: \(truck1.brand)\(truck1.model), release: \(truck1.release), color: \(String(describing: truck1.color)), free trunkVolume: \(truck1.bodyVolume), engine is \(truck1.engineState)")
