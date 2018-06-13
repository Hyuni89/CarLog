import Foundation
import UIKit

class CarListCell: UITableViewCell {
    
    @IBOutlet weak var carName: UILabel!
    @IBOutlet weak var carInfo: UILabel!
    @IBOutlet weak var defaultFlag: UILabel!
    
    func setting(name: String, info: String, isDefault: Bool) {
        carName.text = name
        carInfo.text = info
        carInfo.textColor = UIColor.gray
        
        if isDefault == true {
            defaultFlag.isHidden = false
            defaultFlag.text = "Default"
            defaultFlag.textColor = UIColor.red
        } else {
            defaultFlag.isHidden = true
        }
    }
}
