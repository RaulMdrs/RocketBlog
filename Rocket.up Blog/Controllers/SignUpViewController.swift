//
//  SignUpViewController.swift
//  Rocket.up Blog
//
//  Created by Raul de Medeiros on 19/12/22.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet var parentView: UIView!
    @IBOutlet weak var signUpLabel: UILabel!
    @IBOutlet weak var signUpButton: RocketButton!
    @IBOutlet weak var nameTextField: RocketTextField!
    @IBOutlet weak var emailTextField: RocketTextField!
    @IBOutlet weak var passwordTextField: RocketTextField!
    @IBOutlet weak var confirmPasswordTextField: RocketTextField!
    
    var loader = LoaderView()
    
    var newUser = UserRegister(name: "", email: "", password: "", confirmPassword: "")
    var postRequest = ApiManager()
    var readyToRegister = ReadyToRegister()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        postRequest.requestDelegate = self
        setupLayout()
        setupGesture()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        setupTextField()
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
        setupLabel()
        setupButton()
        setupTextField()
        loaderSetup()
    }
    
    func setupButton() {
        signUpButton.type = .secondary
        signUpButton.setTitle(K.Intl.signUpButtonTitle, for: .normal)
        signUpButton.buttonEnable()
    }
    func setupLabel() {
        signUpLabel.font = UIFont(name: K.Fonts.montserratBold, size: K.Fonts.Size.h3Headline)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkTextFieldsValue()
    }
    
    private func loaderSetup() {
        loader = LoaderView(frame: self.parentView.frame)
        loader.hideLoader()
        self.parentView.addSubview(loader)
    }
    
    @IBAction private func submitSignUpPressed(_ sender: Any) {
        checkNameParameter()
        checkEmailParameter()
        checkPasswordParameter()
        checkConfirmPassword()
        finalVerificationBeforeSendingToAPI()
    }
    
    @IBAction private func redirectToLoginScreen(_ sender: Any) {
        let storyboard = UIStoryboard(name: K.StoryboardNames.signIn, bundle: nil)
        
        let controller = storyboard.instantiateViewController(withIdentifier: K.StoryboardNames.signIn) as! SignInViewController
        
        navigationController?.pushViewController(controller, animated: true)
    }
    
    private func checkTextFieldsValue() {
        guard let emailLength = emailTextField.textField.text?.count,
              let nameLenght = nameTextField.textField.text?.count,
              let passwordLenght = passwordTextField.textField.text?.count,
              let confirmPasswordLenght = confirmPasswordTextField.textField.text?.count else {
            signUpButton.buttonDisable()
            return }
        if ParametersVerifier.verifyLetterCount(texts: [
            nameLenght,
            emailLength,
            passwordLenght,
            confirmPasswordLenght
        ]) {
            signUpButton.buttonEnable()
            signUpButton.type = .secondary
        } else {
            signUpButton.buttonDisable()
        }
    }
    
    func setupTextField() {
        nameTextField.customTextField(type: .name)
        emailTextField.customTextField(type: .email)
        passwordTextField.customTextField(type: .password)
        confirmPasswordTextField.customTextField(type: .confirmPassword)
    }
    
    private func checkNameParameter() {
        guard let nameText = nameTextField.textField.text else {return}
        if ParametersVerifier.verifyNameTextField(nameText) {
            newUser.name = nameText
            readyToRegister.nameIsSet = true
            nameTextField.resetError()
        } else {
            readyToRegister.emailIsSet = false
            nameTextField.setError(message: K.Intl.errorName)
        }
    }
    
    private func checkEmailParameter() {
        guard let emailText = emailTextField.textField.text else {return}
        if ParametersVerifier.verifyEmailTextField(emailText) {
            newUser.email = emailText
            readyToRegister.emailIsSet = true
            emailTextField.resetError()
        } else {
            readyToRegister.emailIsSet = false
            emailTextField.setError(message: K.Intl.errorEmail)
        }
    }
    
    private func checkPasswordParameter() {
        guard let passwordText = passwordTextField.textField.text else {return}
        if ParametersVerifier.verifyPasswordTextField(passwordText){
            newUser.password = passwordText
            readyToRegister.passwordIsSet = true
            passwordTextField.resetError()
        } else {
            readyToRegister.passwordIsSet = false
            passwordTextField.setError(message: K.Intl.errorPassword)
        }
    }
    
    private func checkConfirmPassword() {
        guard let passwordConfirmText = confirmPasswordTextField.textField.text else {return}
        if ParametersVerifier.verifyPasswordConfirmation(passwordReceived: passwordConfirmText, newUserPassword: newUser.password) {
            newUser.confirmPassword = passwordConfirmText
            readyToRegister.confirmPasswordIsSet = true
            confirmPasswordTextField.resetError()
        } else {
            readyToRegister.confirmPasswordIsSet = false
            confirmPasswordTextField.setError(message: K.Intl.errorConfirmPassword)
        }
    }
    
    private func setTextFieldDelegate() {
        nameTextField.textField.delegate = self
        emailTextField.textField.delegate = self
        passwordTextField.textField.delegate = self
        confirmPasswordTextField.textField.delegate = self
    }
    
    private func finalVerificationBeforeSendingToAPI() {
        if readyToRegister.readyToRegister() {
            loader.showLoader()
            postRequest.genericRequest(model: RegisterResponse.self, path: ApiPath.apiRegisterPath(), method: .post, header: ["accept":"application/json",
                "Content-Type":"application/json"], body: [
                "name": newUser.name,
                "email": newUser.email,
                "password": newUser.password,
                "confirmPassword":newUser.confirmPassword])
        }
    }
    
    private func refreshNavigation() {
        navigationItem.hidesBackButton = true
        self.dismiss(animated: false)
        self.removeFromParent()
    }
}

extension SignUpViewController : UITextFieldDelegate {
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
extension SignUpViewController: RequestDelegate {
    func success<T>(_ response: T) {
        guard response is RegisterResponse else {return}
        loader.hideLoader()
        self.navigationController?.popToRootViewController(animated: false)
    }
    
    func errorMessage(_ message: String) {
        loader.hideLoader()
        ShowError.ShowErrorModal(targetView: self.view, message: message, animationDuration: 0.5)
    }
}


