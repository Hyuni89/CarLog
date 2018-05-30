import UIKit
import Foundation
import CoreData

class Car {
    var mName: String = ""
    var mDistance: Int = -1
    var mAvgFuelEffic: Double = -1
    var mYear: Int = -1
    var mLog: [Data]? = nil
    var entity: NSManagedObject?
    
    init() {
        load()
    }
    
    init(name: String, dist: Int, year: Int, effi: Double) {
        mName = name
        mDistance = dist
        mYear = year
        mAvgFuelEffic = effi
        
        print("\(mName), \(mDistance), \(mYear), \(mAvgFuelEffic)")
        load()
    }
    
    func load() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext

        
//        SAVE
//        let entity = NSEntityDescription.entity(forEntityName: "Person", in: managedContext)!
//        let person = NSManagedObject(entity: entity, insertInto: managedContext)
//        person.setValue(name, forKeyPath: "name")
//
//        do {
//            try managedContext.save()
//            people.append(person)
//        } catch let error as NSError {
//            print("Could not Save. \(error), \(error.userInfo)")
//        }
        
//        LOAD
//        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Person")
//
//        do {
//            people = try managedContext.fetch(fetchRequest)
//        } catch let error as NSError {
//            print("Could not Fetch. \(error), \(error.userInfo)")
//        }
    }
    
    func addData(data: Data) {
        print("Data Trans \(data.mDistance), \(data.mFuel), \(data.mPrice)")
    }
}
