import Foundation
import UIKit
import CoreData

extension CarList: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cars.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.translatesAutoresizingMaskIntoConstraints = false
        cell.textLabel?.text = cars[indexPath.row].value(forKeyPath: "name") as? String
        //TODO show cars info briefly
        
        if cell.textLabel?.text == UserDefaults.standard.object(forKey: "DefaultCar") as? String {
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 100))
            label.text = "Default"
            label.textColor = UIColor.red
            cell.contentView.addSubview(label)
            
            label.translatesAutoresizingMaskIntoConstraints = false
            label.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor).isActive = true
            label.trailingAnchor.constraint(equalTo: cell.contentView.layoutMarginsGuide.trailingAnchor).isActive = true
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if UserDefaults.standard.object(forKey: "DefaultCar") as? String == cars[indexPath.row].value(forKeyPath: "name") as? String {
                let alert = UIAlertController(title: "Can't Delete", message: "This is Default Car", preferredStyle: .alert)
                let confirm = UIAlertAction(title: "Confirm", style: .default)
                alert.addAction(confirm)
                present(alert, animated: true)
            } else {
                CarListHandler.getInstance.deleteData(name: (cars[indexPath.row].value(forKeyPath: "name") as? String)!, year: (cars[indexPath.row].value(forKeyPath: "year") as? Int)!)
                cars.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }
    
//    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
//        print("call")
//        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
//            print("del")
//        }
//        let edit = UITableViewRowAction(style: .default, title: "Edit") { (action, indexPath) in
//            print("edit")
//        }
//
//        return [delete, edit]
//    }
//
//    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        return true
//    }
    
//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let delete = UIContextualAction(style: .destructive, title: "Delete") {(action, view, completion) in
//            print("delete")
//            completion(true)
//        }
//        let edit = UIContextualAction(style: .normal, title: "Edit") {(action, view, completion) in
//            print("edit")
//            completion(true)
//        }
//        return UISwipeActionsConfiguration(actions: [delete, edit])
//    }
}

class CarList: UIViewController {
    
    @IBOutlet weak var carListTableView: UITableView!
    var cars: [NSManagedObject] = []
    
    override func viewDidLoad() {
        carListTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        carListTableView.translatesAutoresizingMaskIntoConstraints = false
        carListTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        carListTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        carListTableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        carListTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        title = "Add Car"
        //TODO save and load cars data by CoreData
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cars = CarListHandler.getInstance.getList()
        
        let defualtCar = UserDefaults.standard.object(forKey: "DefualtCar")
        if defualtCar == nil && cars.count == 0 {
            let alert = UIAlertController(title: "Add First Car", message: "At least One Car needed", preferredStyle: .alert)
            let confirm = UIAlertAction(title: "Confirm", style: .default)
            alert.addAction(confirm)
            present(alert, animated: true)
        }
    }
    
    @IBAction func addCar(_ sender: Any) {
        let alert = UIAlertController(title: "Please Type Car Info", message: "Car Name, Distance, Year are essential", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Save", style: .default) {
            [unowned self] action in
            
            let carNameTextField = alert.textFields?[0]
            let carDistanceTextField = alert.textFields?[1]
            let carYearTextField = alert.textFields?[2]
            let carAverageEffTextField = alert.textFields?[3]
            
            if carNameTextField?.text == "" || carDistanceTextField?.text == "" || carYearTextField?.text == "" {
                let subAlert = UIAlertController(title: "Please Type Name, Distance, Year at least", message: nil, preferredStyle: .alert)
                let confirmAction = UIAlertAction(title: "Confirm", style: .default) {
                    action in
                    self.present(alert, animated: true)
                }
                subAlert.addAction(confirmAction)
                self.present(subAlert, animated: true)
                
                return
            }
            
            print("\(carNameTextField), \(carDistanceTextField), \(carYearTextField), \(carAverageEffTextField)")
            
            let effi: Double = (carAverageEffTextField?.text)! == "" ? 0 : Double((carAverageEffTextField?.text)!)!
            CarListHandler.getInstance.saveData(name: (carNameTextField?.text)!, distance: Int((carDistanceTextField?.text)!)!, year: Int((carYearTextField?.text)!)!, effi: effi)
            self.cars = CarListHandler.getInstance.getList()
            self.carListTableView.reloadData()
            
            let defaultCar = UserDefaults.standard.object(forKey: "DefaultCar")
            if defaultCar == nil {
                UserDefaults.standard.set((carNameTextField?.text)!, forKey: "DefaultCar")
                UserDefaults.standard.set(Int((carYearTextField?.text!)!)!, forKey: "DefaultYear")
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default)
        
        alert.addTextField(configurationHandler: {(textField) in
            textField.placeholder = "Car Name"
        })
        alert.addTextField(configurationHandler: {(textField) in
            textField.placeholder = "Drive Distance"
            textField.keyboardType = .numberPad
        })
        alert.addTextField(configurationHandler: {(textField) in
            textField.placeholder = "Year (YYYY)"
            textField.keyboardType = .numberPad
        })
        alert.addTextField(configurationHandler: {(textField) in
            textField.placeholder = "Average Efficience"
            textField.keyboardType = .decimalPad
        })
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
}
