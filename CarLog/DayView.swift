import Foundation
import UIKit

extension DayView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "carListCell", for: indexPath) as! CarListCell
        cell.carName.text = "Hello"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
}

class DayView: UIViewController {
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var costTableView: UITableView!
    var car: Car?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        costTableView.register(CarListCell.self, forCellReuseIdentifier: "carListCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.calendar.setCurrentPage(Date(), animated: false)
    }
}
