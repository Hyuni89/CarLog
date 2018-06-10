import Foundation
import CoreData
import UIKit

class CoreDataHandler {
    static let getInstance = CoreDataHandler()
    var appDelegate: AppDelegate?
    var context: NSManagedObjectContext?
    
    private init() {
        appDelegate = UIApplication.shared.delegate as? AppDelegate
        context = appDelegate?.persistentContainer.viewContext
    }
}
