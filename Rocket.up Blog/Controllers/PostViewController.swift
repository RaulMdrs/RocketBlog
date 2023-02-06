import UIKit

class PostViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
        navigationItem.hidesBackButton = false
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.navigationItem.hidesBackButton = true
        self.dismiss(animated: false)
        self.removeFromParent()
    }
}
