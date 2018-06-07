import Foundation
import CoreData
import UIKit

class CarListHandler {
    static let getInstance = CarListHandler()
    var appDelegate: AppDelegate?
    var context: NSManagedObjectContext?
    var entity: NSEntityDescription?
    
    private init() {
        appDelegate = UIApplication.shared.delegate as? AppDelegate
        context = appDelegate?.persistentContainer.viewContext
        entity = NSEntityDescription.entity(forEntityName: "CarListData", in: context!)!
    }
    
    func saveData(name: String, distance: Int, year: Int, effi: Double) {
        let car = NSManagedObject(entity: entity!, insertInto: context!)
        car.setValue(name, forKeyPath: "name")
        car.setValue(distance, forKeyPath: "distance")
        car.setValue(year, forKeyPath: "year")
        car.setValue(effi, forKey: "efficience")
        
        do {
            try context?.save()
        } catch let error as NSError {
            print("Could not Save. \(error), \(error.userInfo)")
        }
    }
    
    func deleteData(name: String, year: Int) {
        let car = getCar(name: name, year: year)

        do {
            context?.delete(car)
            try context?.save()
        } catch let error as NSError {
            print("Could not Save. \(error), \(error.userInfo)")
        }
    }
    
    func getList() -> [NSManagedObject] {
        let request = NSFetchRequest<NSManagedObject>(entityName: "CarListData")
        var car: [NSManagedObject]? = nil
        
        do {
            car = try context?.fetch(request)
        } catch let error as NSError {
            print("Could not Save. \(error), \(error.userInfo)")
        }
        
        return car!
    }
    
    func getCar(name: String, year: Int) -> NSManagedObject {
        let request = NSFetchRequest<NSManagedObject>(entityName: "CarListData")
        request.predicate = NSPredicate(format: "name == %@ && year == %@", name, NSNumber(value: year))
        var car: NSManagedObject?
        
        do {
            car = try context?.fetch(request)[0]
        } catch let error as NSError {
            print("Could not Save. \(error), \(error.userInfo)")
        }
        
        return car!
    }
}
