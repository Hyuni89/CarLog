import UIKit

class ViewController: UIViewController {
    var car: Car?
    var addViewController: TypeValue?

    override func viewDidLoad() {
        super.viewDidLoad()
        addViewController = storyboard?.instantiateViewController(withIdentifier: "typeValue") as? TypeValue
        addViewController?.delegate = self
        
        car = Car()
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

