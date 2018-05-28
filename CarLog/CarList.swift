import Foundation
import UIKit

extension CarList: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cars.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = carName[indexPath.row]
        //TODO show cars info briefly
        
        return cell
    }
}

class CarList: UIViewController {
    
    @IBOutlet weak var carListTableView: UITableView!
    //TODO switch carName to cars
    var carName: [String] = []
    var cars: [Car] = []
    
    override func viewDidLoad() {
        carListTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        //TODO save and load cars data by CoreData
    }
    
    @IBAction func addCar(_ sender: Any) {
        let alert = UIAlertController(title: "Please Type Car Info", message: "Car Name, Distance, Year are essential", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Save", style: .default) {
            [unowned self] action in
            guard let textField = alert.textFields?.first, let nameToSave = textField.text else {
                return
            }
            
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
            
            //TODO append car info to cars array
            self.carName.append(nameToSave)
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
