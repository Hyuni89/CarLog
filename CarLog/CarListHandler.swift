import Foundation
import CoreData
import UIKit

class CarListHandler {
    static let getInstance = CarListHandler()
    var entity: NSEntityDescription?
    var context: NSManagedObjectContext?
    
    private init() {
        context = CoreDataHandler.getInstance.context
        entity = NSEntityDescription.entity(forEntityName: "CarListData", in: context!)!
    }
    
    func save() {
        do {
            try context?.save()
        } catch let error as NSError {
            print("Could not Save. \(error), \(error.userInfo)")
        }
    }
    
    func saveData(name: String, distance: Int, year: Int, effi: Double) {
        let car = NSManagedObject(entity: entity!, insertInto: context!)
        car.setValue(name, forKeyPath: "name")
        car.setValue(distance, forKeyPath: "distance")
        car.setValue(year, forKeyPath: "year")
        car.setValue(effi, forKeyPath: "efficience")
        
        save()
    }
    
    func deleteData(name: String, year: Int) {
        let car = getCar(name: name, year: year)
        context?.delete(car)

        save()
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
