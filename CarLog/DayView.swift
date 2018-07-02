import Foundation
import UIKit

extension DayView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "carListCell", for: indexPath) as! CarListCell
        cell.carName.text = String(describing: (carData?[indexPath.row].mDistance)!)
        cell.carInfo.text = String(describing: (carData?[indexPath.row].mFuel)!)
        cell.defaultFlag.text = "-" + String(describing: (carData?[indexPath.row].mPrice)!)
        cell.defaultFlag.textColor = UIColor.red
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (carData?.count)!
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let edit = UITableViewRowAction(style: .default, title: "Edit") {(action, indexPath) in
            
        }
        edit.backgroundColor = UIColor.blue
        
        let delete = UITableViewRowAction(style: .default, title: "Delete") {(action, indexPath) in
            
        }
        
        return [delete, edit]
    }
}

class DayView: UIViewController {
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var costTableView: UITableView!
    var carData: [Data]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        carData = CarDataHandler.getInstance.getList(name: UserDefaults.standard.object(forKey: "DefaultCar") as! String)
        costTableView.reloadData()
        self.calendar.setCurrentPage(Date(), animated: false)
    }
}
