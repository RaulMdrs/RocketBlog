//
//  ViewController.swift
//  Rocket.up Blog
//
//  Created by Aline do Amaral on 15/12/22.
//

import UIKit

class LandingPageViewController: UIViewController {
    
    let signIn = SignInViewController()
    
    private let background: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.image = UIImage(named: "backgroundLandingPage")
        return image
    }()
    
    private let logo: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: K.Images.rocketUpLogo)
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private let buttonStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 8
        return stack
    }()
    
    lazy var signInButton: RocketButton = {
        let button = RocketButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.type = .primary
        button.setTitle(K.Intl.signInButtonTitle, for: .normal)
        button.addAction(UIAction(handler: { UIAction in
            self.signInButtonPressed()
        }), for: .touchUpInside)
        return button
    }()
    
    lazy var signUpButton: RocketButton = {
        let button = RocketButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.type = .secondary
        button.setTitle(K.Intl.signUpButtonTitle, for: .normal)
        button.addAction(UIAction(handler: { UIAction in
            self.signUpButtonPressed()
        }), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    private func setupLayout() {
        configureNavigationController()
        setupHierarchy()
        setupConstraints()
    }
    
    private func configureNavigationController() {
        navigationItem.backButtonTitle = " "
    }
    
    private func setupHierarchy() {
        self.view.addSubview(background)
        self.view.addSubview(logo)
        self.view.addSubview(buttonStackView)
        buttonStackView.insertArrangedSubview(signInButton, at: 0)
        buttonStackView.insertArrangedSubview(signUpButton, at: 1)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            background.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            background.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            background.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            background.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            
            logo.heightAnchor.constraint(equalToConstant: 200),
            logo.widthAnchor.constraint(equalToConstant: 200),
            logo.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            logo.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -20),
            
            buttonStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            buttonStackView.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 64),
            buttonStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -55),
            buttonStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 55),
            
            signInButton.heightAnchor.constraint(equalToConstant: 52),
            signUpButton.heightAnchor.constraint(equalToConstant: 52)
        ])
    }
    
    private func signInButtonPressed() {
        //let storyboard = UIStoryboard(name: K.StoryboardNames.signIn, bundle: nil)
        //let controller = storyboard.instantiateViewController(withIdentifier: signIn.identifier) as! SignInViewController
        
        navigationController?.pushViewController(signIn, animated: true)
    }
    
    private func signUpButtonPressed() {
        let storyboard = UIStoryboard(name: K.StoryboardNames.signUp, bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: K.StoryboardNames.signUp) as! SignUpViewController
        navigationController?.pushViewController(controller, animated: true)
    }
}

