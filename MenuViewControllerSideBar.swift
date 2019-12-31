
import UIKit
import Firebase

class MenuViewControllerSideBar : UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var interactor:Interactor? = nil
    
    var menuActionDelegate:MenuActionDelegate? = nil
    
    let menuItems = ["Home", "Profile", "Cart", "notification", "Quit"]
    let menuIcons = [#imageLiteral(resourceName: "baseline_home_black_24dp.png"), #imageLiteral(resourceName: "baseline_info_black_24dp"), #imageLiteral(resourceName: "baseline_language_black_24dp.png"), #imageLiteral(resourceName: "baseline_notification_important_black_24dp.png"), #imageLiteral(resourceName: "baseline_settings_black_24dp.png")]
    
    @IBAction func handleGesture(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)

        let progress = MenuHelper.calculateProgress(translation, viewBounds: view.bounds, direction: .left)
        
        MenuHelper.mapGestureStateToInteractor(
            sender.state,
            progress: progress,
            interactor: interactor){
                self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func closeMenu(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    

    
    func delay(seconds: Double, completion:@escaping ()->()) {
        let popTime = DispatchTime.now() + Double(Int64( Double(NSEC_PER_SEC) * seconds )) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: popTime) {
            completion()
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        dismiss(animated: true){
            self.delay(seconds: 0.5){
                self.menuActionDelegate?.reopenMenu()
            }
        }
    }
    
}

extension MenuViewControllerSideBar : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.imageView?.image = menuIcons[indexPath.row]
        cell.textLabel?.text = menuItems[indexPath.row]
        return cell
    }
}

extension MenuViewControllerSideBar : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            menuActionDelegate?.openSegue("openFirst", sender: nil)
        case 1:
            menuActionDelegate?.openSegue("openSecond", sender: nil)
        
        case 2:
                menuActionDelegate?.openSegue("openSecond", sender: nil)

        case 3:
            menuActionDelegate?.openSegue("openSecond", sender: nil)
            
        case 4:
            try! Auth.auth().signOut()
            print("sign out")
        default:
            break
        }
    }
}
