import Foundation
import UIKit

class TypeValue: UIViewController {
    
    @IBOutlet weak var disfield: UITextField!
    @IBOutlet weak var fuelfield: UITextField!
    @IBOutlet weak var pricefield: UITextField!
    var delegate: ViewController?
    
    @IBAction func click(_ sender: Any) {
        let dis = Int(disfield.text! == "" ? "0" : disfield.text!)!
        let fuel = Int(fuelfield.text! == "" ? "0" : fuelfield.text!)!
        let price = Int(pricefield.text! == "" ? "0" : pricefield.text!)!
        print("[\(dis)][\(fuel)][\(price)]")
        
        let data = Data()
        data.setData(distance: dis, fuel: fuel, price: price)
        delegate?.sendData(data: data)
        navigationController?.popViewController(animated: true)
    }
    
}
