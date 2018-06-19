import UIKit

class ViewController: UIViewController {
    var car: Car?
    var addViewController: TypeValue?
    var carListController: CarList?
    @IBOutlet weak var dayView: UIView!
    @IBOutlet weak var monthView: UIView!
    @IBOutlet weak var yearView: UIView!
    
    @IBAction func changeView(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            dayView.isHidden = false
            monthView.isHidden = true
            yearView.isHidden = true
            print("1segment")
        case 1:
            dayView.isHidden = true
            monthView.isHidden = false
            yearView.isHidden = true
            print("2segment")
        case 2:
            dayView.isHidden = true
            monthView.isHidden = true
            yearView.isHidden = false
            print("3segment")
        default:
            print("Error")
            break
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addViewController = storyboard?.instantiateViewController(withIdentifier: "typeValue") as? TypeValue
        addViewController?.delegate = self
        carListController = storyboard?.instantiateViewController(withIdentifier: "carList") as? CarList
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let defaultCar = UserDefaults.standard.object(forKey: "DefaultCar")
        print(defaultCar)
        if defaultCar == nil {
            self.navigationController?.pushViewController(carListController!, animated: true)
        }
        car = Car()
    }

    @IBAction func selectCar(_ sender: Any) {
        self.navigationController?.pushViewController(carListController!, animated: true)
    }
    
    @IBAction func addCost(_ sender: Any) {
        self.navigationController?.pushViewController(addViewController!, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func sendData(data: Data) {
        car?.addData(data: data)
    }
}

