import Foundation

class Car {
    var mName: String = ""
    var mDistance: Int = -1
    var mAvgFuelEffic: Double = -1
    var mLog: [Data]? = nil
    
    init() {
        load()
    }
    
    func load() {}
}
