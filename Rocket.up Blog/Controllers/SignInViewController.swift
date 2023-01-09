//
//  SignInViewController.swift
//  Rocket.up Blog
//
//  Created by Raul de Medeiros on 19/12/22.
//

import UIKit

class SignInViewController: UIViewController {
    
    @IBOutlet var parentView: UIView!
    @IBOutlet weak var signInButton: RocketButton!
    @IBOutlet weak var passwordTextField: RocketTextField!
    @IBOutlet weak var emailTextField: RocketTextField!
    
    var loader = LoaderView()
    
    var userToLogin : UserLogin = UserLogin(email: "", password: "")
    var postRequest = ApiManager()
    var readyToLogin = ReadyToLogin()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        postRequest.loginDelegate = self
        setupLayout()
        setupGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        checkTextFieldsValue()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        refreshNavigation()
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    private func setupGesture() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func setupLayout() {
        setTextFieldDelegate()
        setupButton()
        setupTextField()
        loaderSetup()
    }
    
    func setTextFieldDelegate() {
         emailTextField.textField.delegate = self
         passwordTextField.textField.delegate = self
    }
    
    func setupButton() {
        signInButton.setupButton(type: .primary, title: K.Intl.signInButtonTitle)
        signInButton.buttonEnable()
    }
    
    func setupTextField() {
        emailTextField.customTextField(type: .email, newColor: K.Colors.primary)
        passwordTextField.customTextField(type: .password, newColor: K.Colors.primary)
    }
    
    func loaderSetup() {
        loader = LoaderView(frame: self.parentView.frame)
        loader.hideLoader()
        self.parentView.addSubview(loader)
    }
    
    @IBAction func signInButtonPressed(_ sender: Any) {
        checkEmailParameter()
        finalVerificationBeforeSendingToAPI()
    }
    
    @IBAction func signUpButtonPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: K.StoryboardNames.signUp, bundle: nil)
        
        let controller = storyboard.instantiateViewController(withIdentifier: K.StoryboardNames.signUp) as! SignUpViewController
        
        navigationController?.pushViewController(controller, animated: true)
    }
    
    private func checkTextFieldsValue() {
        guard let emailLength = emailTextField.textField.text?.count else {return}
        guard let password = passwordTextField.textField.text else {return}
        if (ParametersVerifier.verifyLetterCount(texts:  [emailLength])) && (ParametersVerifier.verifyLetterCountLoginPassword(text: password) == true) {
            signInButton.buttonEnable()
            guard let textReceived = passwordTextField.textField.text else {return}
            userToLogin.password = textReceived
            readyToLogin.setPassword(state: true)
        } else {
            signInButton.buttonDisable()
            readyToLogin.setPassword(state: false)
        }
    }
    
    private func checkEmailParameter() {
        guard let emailText = emailTextField.textField.text else {return}
        if ParametersVerifier.verifyEmailTextField(emailText) {
            userToLogin.email = emailText
            readyToLogin.setEmail(state: true)
            emailTextField.resetError()
        } else {
            readyToLogin.setEmail(state: false)
            emailTextField.setError(message: K.Intl.errorEmailLoginScreen)
            }
        }
    
    private func finalVerificationBeforeSendingToAPI() {
        if readyToLogin.readyToLogin() {
            loader.showLoader()
            postRequest.makePostLoginRequest(userToLogin)
        }
    }
    
    private func redirectToHomeViewControllerScreen() {
        let storyboard = UIStoryboard(name: K.StoryboardNames.home, bundle: nil)
        
        let controller = storyboard.instantiateViewController(withIdentifier: K.StoryboardNames.home) as! HomeViewController
        
        navigationController?.pushViewController(controller, animated: true)
    }
    
    private func refreshNavigation() {
        navigationItem.hidesBackButton = true
        self.dismiss(animated: false)
        self.removeFromParent()
    }
}

extension SignInViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        checkTextFieldsValue()
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        checkTextFieldsValue()
    }
}

extension SignInViewController : PostLoginDelegateProtocol {
    func success(_ response: LoginResponse) {
        loader.hideLoader()
        redirectToHomeViewControllerScreen()
    }
    
    func failed(_ message: String) {
        loader.hideLoader()
        let errorModalTest = RocketWarningModal(frame: self.parentView.frame)
        errorModalTest.setError(str: message)
        self.parentView.addSubview(errorModalTest)
    }
}
