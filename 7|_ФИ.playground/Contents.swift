import UIKit

enum GroupOfAutosError: Error {
    case notFound
}

struct Auto {
    let brand: String
    let model: String
    let year: Int
    var engineVolume: Double
}

class GroupOfAuto {
    
    var autos = [
        "001": Auto(brand: "BMW", model: "X3", year: 2008, engineVolume: 3.0),
        "002": Auto(brand: "Mercedes-Benz", model: "SL500", year: 2003, engineVolume: 5.0),
        "003": Auto(brand: "AUDI", model: "A5", year: 2014, engineVolume: 1.8),
        "004": Auto(brand: "Toyota", model: "Camry", year: 2008, engineVolume: 2.4)
    ]
    
    func getInfo(number auto: String) throws -> Auto {
        guard let auto = autos[auto] else {
            throw GroupOfAutosError.notFound
        }
        return auto
    }
    
}

extension Auto: CustomStringConvertible {
    public var description: String {
        return "Car \(brand) \(model) year of issue \(year) engine volume \(engineVolume) L."
    }
}

let autos = GroupOfAuto()
do {
    let auto = try autos.getInfo(number: "0012")
    print(auto.description)
} catch GroupOfAutosError.notFound {
    print("Car not found")
}
