import Foundation
import UIKit
import CoreData

class CarList: UITableViewController {
    
    @IBOutlet weak var carListTableView: UITableView!
    var cars: [NSManagedObject] = []
    
    override func viewDidLoad() {
        title = "Add Car"
        
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(CarList.longPress(longPressGestureRecognizer:)))
        self.carListTableView.addGestureRecognizer(longPressRecognizer)
    }
    
    @objc func longPress(longPressGestureRecognizer: UILongPressGestureRecognizer) {
        if longPressGestureRecognizer.state == UIGestureRecognizerState.began {
            let touchPoint = longPressGestureRecognizer.location(in: self.view)
            if let indexPath = tableView.indexPathForRow(at: touchPoint) {
                let alert = UIAlertController(title: "Are you sure to change default car?", message: nil, preferredStyle: .alert)
                let confirm = UIAlertAction(title: "Confirm", style: .default) {action in
                    let name = self.cars[indexPath.row].value(forKeyPath: "name")
                    let year = self.cars[indexPath.row].value(forKeyPath: "year")
                    
                    UserDefaults.standard.set(name, forKey: "DefaultCar")
                    UserDefaults.standard.set(year, forKey: "DefaultYear")
                    self.carListTableView.reloadData()
                }
                let cancel = UIAlertAction(title: "Cancel", style: .default)
                
                alert.addAction(confirm)
                alert.addAction(cancel)
                
                present(alert, animated: true)
            }
        }
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
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cars.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "carListCell", for: indexPath) as! CarListCell
        let name = cars[indexPath.row].value(forKeyPath: "name") as! String
        let info = """
        [\(String(describing: cars[indexPath.row].value(forKeyPath: "year")!))][\(String(describing: cars[indexPath.row].value(forKeyPath: "distance")!)) Km]
        """
        
        if name == UserDefaults.standard.object(forKey: "DefaultCar") as! String {
            cell.setting(name: name, info: info, isDefault: true)
        } else {
            cell.setting(name: name, info: info, isDefault: false)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            if UserDefaults.standard.object(forKey: "DefaultCar") as? String == self.cars[indexPath.row].value(forKeyPath: "name") as? String {
                let alert = UIAlertController(title: "Can't Delete", message: "This is Default Car", preferredStyle: .alert)
                let confirm = UIAlertAction(title: "Confirm", style: .default)
                alert.addAction(confirm)
                self.present(alert, animated: true)
            } else {
                let carData = CarDataHandler.getInstance.getList(name: (self.cars[indexPath.row].value(forKeyPath: "name") as? String)!)
                for data in carData {
                    data.delete()
                }
                CarListHandler.getInstance.deleteData(name: (self.cars[indexPath.row].value(forKeyPath: "name") as? String)!, year: (self.cars[indexPath.row].value(forKeyPath: "year") as? Int)!)
                self.cars.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
        let edit = UITableViewRowAction(style: .default, title: "Edit") { (action, indexPath) in
            let alert = UIAlertController(title: "Edit Car Info", message: "Type if you want to edit field", preferredStyle: .alert)
            let editAction = UIAlertAction(title: "Edit", style: .default) {
                [unowned self] action in
                
                let carNameTextField = alert.textFields?[0]
                let carDistanceTextField = alert.textFields?[1]
                let carYearTextField = alert.textFields?[2]
                let carAverageEffTextField = alert.textFields?[3]
                
                let effi: Double = (carAverageEffTextField?.text)! == "" ? 0 : Double((carAverageEffTextField?.text)!)!
                if carNameTextField?.text != "" {
                    self.cars[indexPath.row].setValue(carNameTextField?.text, forKeyPath: "name")
                    UserDefaults.standard.set(carNameTextField?.text, forKey: "DefaultCar")
                }
                if carDistanceTextField?.text != "" {
                    self.cars[indexPath.row].setValue(Double((carDistanceTextField?.text)!)!, forKeyPath: "distance")
                }
                if carYearTextField?.text != "" {
                    self.cars[indexPath.row].setValue(Int((carYearTextField?.text)!)!, forKeyPath: "year")
                    UserDefaults.standard.set(carYearTextField?.text, forKey: "DefaultYear")
                }
                if effi != 0 {
                    self.cars[indexPath.row].setValue(effi, forKeyPath: "efficience")
                }
                
                CarListHandler.getInstance.save()
                self.carListTableView.reloadData()
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .default)
            
            alert.addTextField(configurationHandler: {(textField) in
                textField.placeholder = self.cars[indexPath.row].value(forKeyPath: "name") as? String
            })
            alert.addTextField(configurationHandler: {(textField) in
                textField.placeholder = String(describing: self.cars[indexPath.row].value(forKeyPath: "distance")!)
                textField.keyboardType = .numberPad
            })
            alert.addTextField(configurationHandler: {(textField) in
                textField.placeholder = String(describing: self.cars[indexPath.row].value(forKeyPath: "year")!)
                textField.keyboardType = .numberPad
            })
            alert.addTextField(configurationHandler: {(textField) in
                textField.placeholder = String(describing: self.cars[indexPath.row].value(forKeyPath: "efficience")!)
                textField.keyboardType = .decimalPad
            })
            alert.addAction(editAction)
            alert.addAction(cancelAction)
            
            self.present(alert, animated: true)
        }
        edit.backgroundColor = UIColor.blue
        
        return [delete, edit]
    }
}
