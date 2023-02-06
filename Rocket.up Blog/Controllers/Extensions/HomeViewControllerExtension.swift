import UIKit

extension HomeViewController : sliderTabProtocol {
    func redirectToForYou() {
        forYouView.isHidden = false
        peopleView.isHidden = true
        forYouViewController?.getPosts()
    }
    
    func redirectToPeople() {
        VerifyLoader.forYouRequest = false
        forYouView.isHidden = true
        peopleView.isHidden = false
    }
}

extension HomeViewController: RequestDelegate {
    func success<T>(_ response: T) {
        guard let userResponse = response as? UserResponse else {return}
        guard let data = userResponse.data else {return}
        user = data
        DispatchQueue.main.async {
            self.setupDefinitiveLayout()
        }
        VerifyLoader.headerRequest = true
        VerifyLoader.verifyLoader(loader: loader)
    }
    
    func errorMessage(_ message: String) {
        VerifyLoader.headerRequest = true
        VerifyLoader.verifyLoader(loader: loader)
        ShowError.ShowErrorModal(targetView: self.view, message: message, animationDuration: 0.5)
    }
}
