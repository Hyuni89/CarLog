import UIKit

class ViewController: UIViewController {
    
    var car: Car?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        car = Car()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func getData(data: Data) {
        car?.addData(data: data)
    }
}

