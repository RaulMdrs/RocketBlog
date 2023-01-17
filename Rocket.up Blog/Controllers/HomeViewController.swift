//
//  HomeViewController.swift
//  Rocket.up Blog
//
//  Created by Aline do Amaral on 03/01/23.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet var parentView: UIView!
    @IBOutlet weak var vocativeLabel: UILabel!
    @IBOutlet weak var avatarView: UIView!
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var homeBackgroundImageView: UIImageView!
    var user: User = User(avatar: "", bio: "", name: "", email: "", background: nil)
    var loader = LoaderView()
    var getRequest = ApiManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDefaultLayout()
    }
    
    func setupDefaultLayout() {
        setDelegates()
        self.navigationController?.isNavigationBarHidden = true
        vocativeLabel.font = UIFont(name: K.Fonts.montserratBold, size: K.Fonts.Size.h5Headline)
        avatarLayout()
        loaderSetup()
        getRequest.makeGetMeRequest()
        loader.showLoader()
        backgroundLayout()
        parentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    func setDelegates() {
        getRequest.userDelegate = self
    }
    
    func avatarLayout() {
        avatarView.layer.cornerRadius = K.AvatarLayoutParameters.cornerRadius
        avatarView.layer.masksToBounds = true
        avatarView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        avatarView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        avatarView.backgroundColor = .clear
    }
    
    func backgroundLayout() {
        homeBackgroundImageView.frame = view.bounds
    }
    
    func loaderSetup() {
        loader = LoaderView(frame: self.parentView.frame)
        loader.hideLoader()
        self.parentView.addSubview(loader)
    }
    
    func setupDefinitiveLayout() {
        vocativeLabel.text = setWelcomeMessage()
        setAvatarImage()
    }
    
    func setWelcomeMessage() -> String {
        let name = GetUserFirstName.firstName(user.name)
        let message = K.Intl.vocativeLabel + name
        return message
    }
    
    func setAvatarImage() {
        guard let image = user.avatar?.imageFromBase64 else {return}
        avatarImage.image = image
    }
}

extension HomeViewController: GetDelegateProtocol {
    func success(_ response: UserResponse) {
        guard let data = response.data else {return}
        user = data
        DispatchQueue.main.async {
            self.setupDefinitiveLayout()
        }
        loader.hideLoader()
    }
    
    func failed(_ message: String) {
        loader.hideLoader()
        let errorModalTest = RocketWarningModal(frame: self.parentView.frame)
        errorModalTest.setError(str: message)
        self.parentView.addSubview(errorModalTest)
    }
}
