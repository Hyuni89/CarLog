import Foundation
import UIKit

class CarList: UITableViewController {
    
    @IBOutlet weak var carListTableView: UITableView!
    var cars: [Car] = []
    
    override func viewDidLoad() {
        carListTableView.delegate = self
        carListTableView.dataSource = self
//        carListTableView.register(tableViewCell.self, forCellReuseIdentifier: "tableViewCell")
        //TODO save and load cars data by CoreData
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cars.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as? TableViewCell else {
            fatalError("Error unwrapping tableViewCell")
        }
        
        cell.mainText?.text = cars[indexPath.row].mName
        cell.subText?.text = "Dist " + String(cars[indexPath.row].mDistance) + ", Year " + String(cars[indexPath.row].mYear)
        cell.subText?.textColor = UIColor.gray
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            cars.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func log() {
        for i in cars {
            print(i.mName)
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

