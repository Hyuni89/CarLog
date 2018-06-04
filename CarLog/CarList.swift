import Foundation
import UIKit

extension CarList: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cars.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = cars[indexPath.row].mName
        //TODO show cars info briefly
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if UserDefaults.standard.object(forKey: "DefaultCar") as? String == cars[indexPath.row].mName {
                let alert = UIAlertController(title: "Can't Delete", message: "This is Default Car", preferredStyle: .alert)
                let confirm = UIAlertAction(title: "Confirm", style: .default)
                alert.addAction(confirm)
                present(alert, animated: true)
            } else {
                cars.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }
}

class CarList: UIViewController {
    
    @IBOutlet weak var carListTableView: UITableView!
    var cars: [Car] = []
    
    override func viewDidLoad() {
        carListTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        title = "Add Car"
        //TODO save and load cars data by CoreData
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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
            self.cars.append(Car(name: (carNameTextField?.text)!, dist: Int((carDistanceTextField?.text)!)!, year: Int((carYearTextField?.text)!)!, effi: effi))
            self.carListTableView.reloadData()
            
            let defaultCar = UserDefaults.standard.object(forKey: "DefaultCar")
            if defaultCar == nil {
                UserDefaults.standard.set((carNameTextField?.text)!, forKey: "DefaultCar")
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
