import Foundation

class Data {
    var mDistance: Int = 0
    var mFuel: Int = 0
    var mPrice: Int = 0
    
    func setData(data: Data) {
        mDistance = data.mDistance
        mFuel = data.mFuel
        mPrice = data.mPrice
    }
    
    func setData(distance: Int, fuel: Int, price: Int) {
        mDistance = distance
        mFuel = fuel
        mPrice = price
    }
}
