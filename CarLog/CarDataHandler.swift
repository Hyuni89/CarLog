import Foundation
import CoreData

class CarDataHandler {
    static let getInstance = CarDataHandler()
    var entity: NSEntityDescription?
    var context: NSManagedObjectContext?
    
    private init() {
        context = CoreDataHandler.getInstance.context
        entity = NSEntityDescription.entity(forEntityName: "CarData", in: context!)!
    }
    
    func getList(name: String) -> [Data] {
        let request = NSFetchRequest<NSManagedObject>(entityName: "CarData")
        request.predicate = NSPredicate(format: "car == %@", name)
        var history: [NSManagedObject]?
        
        do {
            history = try context?.fetch(request)
        } catch let error as NSError {
            print("Could not Save. \(error), \(error.userInfo)")
        }
        
        var ret = [Data]()
        for i in history! {
            ret.append(Data(object: i))
        }
        
        return ret
    }
    
    func getAllList() -> [NSManagedObject] {
        let request = NSFetchRequest<NSManagedObject>(entityName: "CarData")
        var car: [NSManagedObject]? = nil
        
        do {
            car = try context?.fetch(request)
        } catch let error as NSError {
            print("Could not Save. \(error), \(error.userInfo)")
        }
        
        return car!
    }
}
