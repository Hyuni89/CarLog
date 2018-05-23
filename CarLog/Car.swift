import Foundation
import CoreData

class Car {
    var mName: String = ""
    var mDistance: Int = -1
    var mAvgFuelEffic: Double = -1
    var mLog: [Data]? = nil
    var entity: NSManagedObject?
    
    init() {
        load()
    }
    
    func load() {
    }
    
    func addData(data: Data) {
        print("Data Trans \(data.mDistance), \(data.mFuel), \(data.mPrice)")
    }
}
