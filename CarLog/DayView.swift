import Foundation
import UIKit

class DayView: UIViewController {
    @IBOutlet weak var calendar: FSCalendar!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.calendar.setCurrentPage(Date(), animated: false)
    }
}
