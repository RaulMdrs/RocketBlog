//
//  ViewController.swift
//  Rocket.up Blog
//
//  Created by Aline do Amaral on 15/12/22.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var signInButton: RocketButton!
    @IBOutlet weak var signUpButton: RocketButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signInButton.configButton(type: K.DefaultButton.signInButton)
        signUpButton.configButton(type: K.DefaultButton.signUpButton)
    }
    
    
    @IBAction func loginButtonPressed(_ sender: RocketButton) {
        let storyboard = UIStoryboard(name: K.StoryboardNames.signIn, bundle: nil)
        
        let controller = storyboard.instantiateViewController(withIdentifier: K.StoryboardNames.signIn) as! SignInViewController
        
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func signUpButtonPressed(_ sender: RocketButton) {
        let storyboard = UIStoryboard(name: K.StoryboardNames.signUp, bundle: nil)
        
        let controller = storyboard.instantiateViewController(withIdentifier: K.StoryboardNames.signUp) as! SignUpViewController
        
        navigationController?.pushViewController(controller, animated: true)
    }
    

}

