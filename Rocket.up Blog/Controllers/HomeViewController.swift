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
    @IBOutlet weak var forYouView: UIView!
    @IBOutlet weak var peopleView: UIView!
    @IBOutlet weak var sliderBarView: SliderTab!

    var user: User = User(avatar: "", bio: "", name: "", email: "", background: nil, id: "")
    var loader = LoaderView()
    var getRequest = ApiManager()
    
    var forYouViewController : ForYouViewController?
    var peopleViewController : PeopleViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDefaultLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toForYou" {
            if let destinationViewController = segue.destination as? ForYouViewController {
                forYouViewController = destinationViewController
                forYouViewController?.loaderProtocol = self
            }
        } else if segue.identifier == "toPeople" {
            if let destinationViewController = segue.destination as? PeopleViewController {
                peopleViewController = destinationViewController
                peopleViewController?.loaderProtocol = self
            }
        }
    }
    
    private func setupDefaultLayout() {
        setDelegates()
        self.navigationController?.isNavigationBarHidden = true
        vocativeLabel.font = UIFont(name: K.Fonts.montserratBold, size: K.Fonts.Size.h5Headline)
        avatarLayout()
        loaderSetup()
        getRequest.genericRequest(model: UserResponse.self, path: ApiPath.apiGetMePath(), method: .get, header: ["Authorization" : Authentication.shared.getToken(), "accept" : "application/json"], body: nil)
        loader.showLoader()
        backgroundLayout()
        parentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        peopleView.isHidden = true
    }
    
    private func setDelegates() {
        getRequest.requestDelegate = self
        sliderBarView.sliderDelegate = self
    }
    
    private func avatarLayout() {
        avatarView.layer.cornerRadius = K.AvatarLayoutParameters.cornerRadiusHomeViewController
        avatarView.layer.masksToBounds = true
        avatarView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        avatarView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        avatarView.backgroundColor = .clear
    }
    
    private func backgroundLayout() {
        homeBackgroundImageView.frame = view.bounds
    }
    
    private func loaderSetup() {
        loader = LoaderView(frame: self.view.frame)
        loader.hideLoader()
        self.parentView.addSubview(loader)
    }
    
    func setupDefinitiveLayout() {
        vocativeLabel.text = setWelcomeMessage()
        setAvatarImage()
    }
    
    private func setWelcomeMessage() -> String {
        let name = GetUserFirstName.firstName(user.name)
        let message = K.Intl.vocativeLabel + name
        return message
    }
    
    private func setAvatarImage() {
        guard let image = user.avatar?.imageFromBase64 else {return}
        avatarImage.image = image
    }
}

extension HomeViewController : LoaderHomeViewProtocol {
    func showLoader() {
        loader.showLoader()
    }
    
    func hideLoader() {
        VerifyLoader.verifyLoader(loader: loader)
    }
}

protocol LoaderHomeViewProtocol {
    func hideLoader()
    func showLoader()
}
