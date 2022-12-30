//
//  SignUpViewController.swift
//  Rocket.up Blog
//
//  Created by Raul de Medeiros on 19/12/22.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var signUpLabel: UILabel!
    @IBOutlet weak var signUpButton: RocketButton!
    @IBOutlet weak var nameTextField: RocketTextFieldController!
    @IBOutlet weak var emailTextField: RocketTextFieldController!
    @IBOutlet weak var passwordTextField: RocketTextFieldController!
    @IBOutlet weak var confirmPasswordTextField: RocketTextFieldController!
    
    @IBOutlet weak var activityIndicatorView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var errorModal: RocketWarningModalController!
    
    var newUser = User(name: "", email: "", password: "", confirmPassword: "")
    var postRequest = ParseJSON()
    var readyToRegister = ReadyToRegister()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        postRequest.delegate = self
        setupLayout()
    }
    func setupLayout() {
        setTextFieldDelegate()
        setupLabel()
        setupButton()
        setupTextField()
    }
    
    func setupButton() {
        signUpButton.configButton(type: K.DefaultButton.signUpButton)
        signUpButton.buttonEnable(type: K.DefaultButton.signUpButton)
    }
    func setupLabel() {
        signUpLabel.font = UIFont(name: K.Fonts.montserratBold, size: K.Fonts.Size.h3Headline)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        setupTextField()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkTextFieldsValue()
    }
    
    private func showLoader() {
        activityIndicatorView.isHidden = false
        activityIndicator.startAnimating()
    }
    
    private func hideLoader() {
        DispatchQueue.main.async {
            self.activityIndicatorView.isHidden = true
            self.activityIndicator.stopAnimating()
        }
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
        if ParametersVerifier.verifyLetterCount(texts: [
            nameTextField.textField.text?.count ?? 0,
            emailTextField.textField.text?.count ?? 0,
            passwordTextField.textField.text?.count ?? 0,
            confirmPasswordTextField.textField.text?.count ?? 0
        ]){
            signUpButton.buttonEnable(type: K.DefaultButton.signUpButton)
        }else{
            signUpButton.buttonDisable()
        }
    }
    
    func setupTextField() {
        nameTextField.customTextField(type: K.TypeTextField.name)
        emailTextField.customTextField(type: K.TypeTextField.email)
        passwordTextField.customTextField(type: K.TypeTextField.password)
        confirmPasswordTextField.customTextField(type: K.TypeTextField.confirmPassword)
    }
    
    private func checkNameParameter() {
        if ParametersVerifier.verifyNameTextField(nameTextField.textField.text ?? "") {
            newUser.name = nameTextField.textField.text ?? ""
            readyToRegister.nameIsSet = true
            if nameTextField.isWarning {
                nameTextField.configWarning()
            }
        } else {
            readyToRegister.nameIsSet = false
            if !nameTextField.isWarning {
                nameTextField.configWarning()
            }
            nameTextField.errorLabel.setupWarning(message: K.ErrorLabel.name)
        }
    }
    
    private func checkEmailParameter() {
        if ParametersVerifier.verifyEmailTextField(emailTextField.textField.text ?? "") {
            newUser.email = emailTextField.textField.text ?? ""
            readyToRegister.emailIsSet = true
            if emailTextField.isWarning {
                emailTextField.configWarning()
            }
        } else {
            readyToRegister.emailIsSet = false
            if !emailTextField.isWarning {
                emailTextField.configWarning()
                emailTextField.errorLabel.setupWarning(message: K.ErrorLabel.email)
            }
        }
    }
    
    private func checkPasswordParameter() {
        if ParametersVerifier.verifyPasswordTextField(passwordTextField.textField.text ?? ""){
            newUser.password = passwordTextField.textField.text!
            readyToRegister.passwordIsSet = true
            if passwordTextField.isWarning {
                passwordTextField.configWarning()
            }
        } else {
            readyToRegister.passwordIsSet = false
            if !passwordTextField.isWarning {
                passwordTextField.configWarning()
                passwordTextField.errorLabel.setupWarning(message: K.ErrorLabel.password)
            }
        }
    }
    
    private func checkConfirmPassword() {
        if ParametersVerifier.verifyPasswordConfirmation(passwordReceived: confirmPasswordTextField.textField.text ?? "", newUserPassword: newUser.password){
            guard let confirmPassword = confirmPasswordTextField.textField.text else {return}
            newUser.confirmPassword = confirmPassword
            readyToRegister.confirmPasswordIsSet = true
            if confirmPasswordTextField.isWarning{
                confirmPasswordTextField.configWarning()
            }
        }else{
            readyToRegister.confirmPasswordIsSet = false
            if !confirmPasswordTextField.isWarning{
                confirmPasswordTextField.configWarning()
                confirmPasswordTextField.errorLabel.setupWarning(message: K.ErrorLabel.confirmPassword)
            }
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
            showLoader()
            postRequest.makePostRequest(newUser)
            
        } 
    }
}

extension SignUpViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        checkTextFieldsValue()
        textField.endEditing(true)
        return true
    }
}

extension SignUpViewController : PostDelegateProtocol {
    func success(_ response: Response) {
        hideLoader()
        self.navigationController?.popToRootViewController(animated: false)
    }
    
    func failed(_ message: String) {
        self.hideLoader()
        self.errorModal.setError(str: message)
    }
}

