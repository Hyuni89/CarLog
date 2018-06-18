import UIKit

extension ViewController: FSCalendarDelegate, FSCalendarDataSource {
}

class ViewController: UIViewController {
    var car: Car?
    var addViewController: TypeValue?
    var carListController: CarList?
    @IBOutlet weak var calendar: FSCalendar!
    
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
        self.calendar.setCurrentPage(Date(), animated: false)
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

