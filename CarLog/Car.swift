import UIKit
import Foundation
import CoreData

class Car {
    var defaultCar: NSManagedObject?
    var mLog: [Data]? = nil
    
    init() {
        print("init:: default carName[\(UserDefaults.standard.object(forKey: "DefaultCar"))], carYear[\(UserDefaults.standard.object(forKey: "DefaultYear"))]")
        guard let name = UserDefaults.standard.object(forKey: "DefaultCar"), let year = UserDefaults.standard.object(forKey: "DefaultYear") else {
            defaultCar = nil
            return
        }
        defaultCar = CarListHandler.getInstance.getCar(name: name as! String, year: year as! Int)
        load()
    }
    
    func load() {
        
    }
    
    func addData(data: Data) {
        print("Data Trans \(data.mDistance), \(data.mFuel), \(data.mPrice)")
    }
}
