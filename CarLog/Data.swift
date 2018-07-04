import Foundation
import CoreData

class Data {
    var mDistance: Double {
        didSet {
            mObject?.setValue(mDistance, forKeyPath: "distance")
        }
    }
    var mFuel: Double {
        didSet {
            mObject?.setValue(mFuel, forKeyPath: "fuel")
        }
    }
    var mPrice: Int {
        didSet {
            mObject?.setValue(mPrice, forKeyPath: "price")
        }
    }
    var mComment: String? {
        didSet {
            mObject?.setValue(mComment, forKeyPath: "comment")
        }
    }
    var mEffi: Double? {
        didSet {
            mObject?.setValue(mEffi, forKeyPath: "efficience")
        }
    }
    var mDate: Date? {
        didSet {
            mObject?.setValue(mDate, forKeyPath: "date")
        }
    }
    var mObject: NSManagedObject?
    
    init() {
        let context = CoreDataHandler.getInstance.context
        let entity = NSEntityDescription.entity(forEntityName: "CarData", in: context!)!
        mObject = NSManagedObject(entity: entity, insertInto: context!)
        mDistance = 0
        mPrice = 0
        mFuel = 0
        mComment = ""
        mEffi = 0
        mDate = Date()
    }
    
    init(object: NSManagedObject) {
        mObject = object
        mDistance = mObject?.value(forKeyPath: "distance") as! Double
        mFuel = mObject?.value(forKeyPath: "fuel") as! Double
        mPrice = mObject?.value(forKeyPath: "price") as! Int
        mComment = mObject?.value(forKeyPath: "comment") as? String
        mEffi = mObject?.value(forKeyPath: "efficience") as? Double
        mDate = mObject?.value(forKeyPath: "date") as? Date
    }
    
    func save() {
        mObject?.setValue(UserDefaults.standard.object(forKey: "DefaultCar"), forKeyPath: "car")
        
        do {
            try CoreDataHandler.getInstance.context?.save()
        } catch let error as NSError {
            print("Could not Save. \(error), \(error.userInfo)")
        }
    }
    
    func delete() {
        CoreDataHandler.getInstance.context?.delete(mObject!)
        
        do {
            try CoreDataHandler.getInstance.context?.save()
        } catch let error as NSError {
            print("Could not Save. \(error), \(error.userInfo)")
        }
    }
}
