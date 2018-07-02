import UIKit

class ViewController: UIViewController {
    var car: Car?
    var addViewController: TypeValue?
    var carListController: CarList?
    @IBOutlet weak var dayView: UIView!
    @IBOutlet weak var monthView: UIView!
    @IBOutlet weak var yearView: UIView!
    @IBOutlet weak var viewConstraint: NSLayoutConstraint!
    @IBOutlet weak var sideView: UIView!
    let INITIALSIDEVIEW: CGFloat = -205
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sideView.layer.shadowColor = UIColor.black.cgColor
        sideView.layer.shadowOpacity = 0.8
        sideView.layer.shadowOffset = CGSize(width: 1, height: 0)
        viewConstraint.constant = INITIALSIDEVIEW
        
        addViewController = storyboard?.instantiateViewController(withIdentifier: "typeValue") as? TypeValue
        addViewController?.delegate = self
        carListController = storyboard?.instantiateViewController(withIdentifier: "carList") as? CarList
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewConstraint.constant = INITIALSIDEVIEW
        
        let defaultCar = UserDefaults.standard.object(forKey: "DefaultCar")
//        print(defaultCar)
        if defaultCar == nil {
            self.navigationController?.pushViewController(carListController!, animated: true)
        }
        loadCar()
        
//        let tmpLog = CarDataHandler.getInstance.getAllList()
//        for tmp in tmpLog {
//            let tmpname = tmp.value(forKeyPath: "car") as! String
//            let tmpdistance = tmp.value(forKeyPath: "distance")
//            let tmpfuel = tmp.value(forKeyPath: "fuel")
//            let tmpprice = tmp.value(forKeyPath: "price")
//            print(tmpname, tmpdistance, tmpfuel, tmpprice)
//        }
    }
    
    @IBAction func changeView(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            dayView.isHidden = false
            monthView.isHidden = true
            yearView.isHidden = true
//            print("1segment")
        case 1:
            dayView.isHidden = true
            monthView.isHidden = false
            yearView.isHidden = true
//            print("2segment")
        case 2:
            dayView.isHidden = true
            monthView.isHidden = true
            yearView.isHidden = false
//            print("3segment")
        default:
//            print("Error")
            break
        }
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
    
    @IBAction func panPerform(_ sender: UIPanGestureRecognizer) {
        if sender.state == .began || sender.state == .changed {
            let trans = sender.translation(in: self.view).x
            
            if trans > 0 {
                if viewConstraint.constant < 20 {
                    UIView.animate(withDuration: 0.2, animations: {
                        if self.viewConstraint.constant < 0 {
                            self.viewConstraint.constant += trans / 10
                        } else {
                            self.viewConstraint.constant = 0
                        }
                        self.view.layoutIfNeeded()
                    })
                }
            } else {
                if viewConstraint.constant > INITIALSIDEVIEW {
                    UIView.animate(withDuration: 0.2, animations: {
                        self.viewConstraint.constant += trans / 10
                        self.view.layoutIfNeeded()
                    })
                }
            }
        } else if sender.state == .ended {
            if viewConstraint.constant < -100 {
                UIView.animate(withDuration: 0.2, animations: {
                    self.viewConstraint.constant = self.INITIALSIDEVIEW
                    self.view.layoutIfNeeded()
                })
            } else {
                UIView.animate(withDuration: 0.2, animations: {
                    self.viewConstraint.constant = 0
                    self.view.layoutIfNeeded()
                })
            }
        }
    }
    
    @IBAction func toggleSideMenu(_ sender: UIBarButtonItem) {
        if viewConstraint.constant == 0 {
            UIView.animate(withDuration: 0.2, animations: {
                self.viewConstraint.constant = self.INITIALSIDEVIEW
                self.view.layoutIfNeeded()
            })
        } else {
            UIView.animate(withDuration: 0.2, animations: {
                self.viewConstraint.constant = 0
                self.view.layoutIfNeeded()
            })
        }
    }
    
    @IBAction func tapGesture(_ sender: UITapGestureRecognizer) {
        let touchPoint = sender.location(in: self.view)
        if viewConstraint.constant == 0 && touchPoint.x > -self.INITIALSIDEVIEW {
            UIView.animate(withDuration: 0.2, animations: {
                self.viewConstraint.constant = self.INITIALSIDEVIEW
                self.view.layoutIfNeeded()
            })
        }
    }
    
    @IBAction func showCarList(_ sender: UIButton) {
        self.navigationController?.pushViewController(carListController!, animated: true)
    }
    
    func loadCar() {
        car = Car()
    }
}

