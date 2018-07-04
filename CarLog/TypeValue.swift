import Foundation
import UIKit

class TypeValue: UIViewController {
    
    @IBOutlet weak var disfield: UITextField!
    @IBOutlet weak var fuelfield: UITextField!
    @IBOutlet weak var pricefield: UITextField!
    @IBOutlet weak var commentfield: UITextField!
    @IBOutlet weak var effifield: UITextField!
    @IBOutlet weak var datepicker: UIDatePicker!
    var delegate: ViewController?
    
    @IBAction func click(_ sender: Any) {
        let dis = Double(disfield.text! == "" ? "0" : disfield.text!)!
        let fuel = Double(fuelfield.text! == "" ? "0" : fuelfield.text!)!
        let price = Int(pricefield.text! == "" ? "0" : pricefield.text!)!
        let comment = commentfield.text
        let effi = Double(effifield.text!)
        let date = datepicker.date
        print("[\(dis)][\(fuel)][\(price)][\(comment)][\(effi)][\(date)]")
        
        let data = Data()
        data.mDistance = dis
        data.mFuel = fuel
        data.mPrice = price
        data.mComment = comment
        data.mEffi = effi
        data.mDate = date
        data.save()
        delegate?.sendData(data: data)
        navigationController?.popViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        disfield.text = ""
        fuelfield.text = ""
        pricefield.text = ""
        commentfield.text = ""
        effifield.text = ""
    }
}
