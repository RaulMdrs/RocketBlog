//
//  SignUpViewController.swift
//  Rocket.up Blog
//
//  Created by Raul de Medeiros on 19/12/22.
//

import UIKit

class SignUpViewController: UIViewController {
    
    let loader = LoaderView()
    var newUser = UserRegister(name: "", email: "", password: "", confirmPassword: "")
    var postRequest = ApiManager()
    var readyToRegister = ReadyToRegister()
    
    private let signUpLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = K.Intl.signUpLabelText
        label.font = UIFont(name: K.Fonts.montserratSemiBold, size: K.Fonts.Size.h4Headline)
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()
    
    lazy var signUpButton: RocketButton = {
       let rocketButton = RocketButton()
        rocketButton.translatesAutoresizingMaskIntoConstraints = false
        rocketButton.type = .secondary
        rocketButton.setTitle(K.Intl.signUpButtonTitle, for: .normal)
        rocketButton.buttonEnable()
        rocketButton.addAction(UIAction(handler: { UIAction in
            self.submitSignUpPressed()
        }), for: .touchUpInside)
        return rocketButton
    }()
    
    lazy var signInButton: RocketButton = {
       let rocketButton = RocketButton()
        rocketButton.translatesAutoresizingMaskIntoConstraints = false
        rocketButton.type = .tertiary
        rocketButton.setTitle(K.Intl.signInButtonTitle, for: .normal)
        rocketButton.buttonEnable()
        rocketButton.addAction(UIAction(handler: { UIAction in
            self.redirectToSignIn()
        }), for: .touchUpInside)
        return rocketButton
    }()
    
    private let nameTextField: RocketTextField = {
        let rocketTextField = RocketTextField()
        rocketTextField.translatesAutoresizingMaskIntoConstraints = false
        rocketTextField.customTextField(type: .name)
        return rocketTextField
    }()
    
    private let emailTextField: RocketTextField = {
        let rocketTextField = RocketTextField()
        rocketTextField.translatesAutoresizingMaskIntoConstraints = false
        rocketTextField.customTextField(type: .email)
        return rocketTextField
    }()
    
    private let passwordTextField: RocketTextField = {
        let rocketTextField = RocketTextField()
        rocketTextField.translatesAutoresizingMaskIntoConstraints = false
        rocketTextField.customTextField(type: .password)
        return rocketTextField
    }()
    
    private let confirmPasswordTextField: RocketTextField = {
        let rocketTextField = RocketTextField()
        rocketTextField.translatesAutoresizingMaskIntoConstraints = false
        rocketTextField.customTextField(type: .confirmPassword)
        return rocketTextField
    }()
    
    private let textFieldsStackView : UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.alignment = .fill
        stack.distribution = .fill
        stack.axis = .vertical
        stack.spacing = 11
        return stack
    }()
    
    private let headerStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.alignment = .center
        stack.distribution = .fill
        stack.axis = .vertical
        stack.spacing = 40
        return stack
    }()
    
    private let scrollView : UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.alwaysBounceVertical = false
        scroll.alwaysBounceHorizontal = false
        scroll.isDirectionalLockEnabled = true
        scroll.bounces = false
        return scroll
    }()
    
    private let contentView : UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let logo : UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: K.Images.rocketUpLogoAndTitle)
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private let bottomStackView : UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 3
        stack.alignment = .fill
        stack.distribution = .fill
        return stack
    }()
    
    private let areYouSubscribed : UILabel = {
        let label = UILabel()
        label.text = K.Intl.areYouSubscribed
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: K.Colors.mediumGray)
        label.numberOfLines = 1
        label.font = UIFont(name: K.Fonts.montserratSemiBold, size: 13)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        postRequest.requestDelegate = self
        setupLayout()
        setupGesture()
        setupNavigationItem()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        setupTextField()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        refreshNavigation()
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    private func setupNavigationItem() {
        navigationItem.backButtonTitle = " "
    }
    
    private func setupGesture() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    private func setupLayout() {
        self.view.backgroundColor = .white
        setupHierarchy()
        setupConstraints()
        setTextFieldDelegate()
        loaderSetup()
    }
    
    private func setupHierarchy() {
        self.view.addSubview(scrollView)
        scrollView.addSubview(headerStackView)
        scrollView.addSubview(textFieldsStackView)
        scrollView.addSubview(bottomStackView)
        
        headerStackView.addArrangedSubview(logo)
        headerStackView.addArrangedSubview(signUpLabel)
        
        textFieldsStackView.addArrangedSubview(nameTextField)
        textFieldsStackView.addArrangedSubview(emailTextField)
        textFieldsStackView.addArrangedSubview(passwordTextField)
        textFieldsStackView.addArrangedSubview(confirmPasswordTextField)
        
        scrollView.addSubview(signUpButton)
        
        bottomStackView.addArrangedSubview(areYouSubscribed)
        bottomStackView.addArrangedSubview(signInButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            headerStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            headerStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            logo.heightAnchor.constraint(equalToConstant: 144),
            logo.widthAnchor.constraint(equalToConstant: 144),
            
            signUpLabel.heightAnchor.constraint(equalToConstant: 40),
            signUpLabel.widthAnchor.constraint(equalToConstant: 180),
            
            textFieldsStackView.topAnchor.constraint(equalTo: headerStackView.bottomAnchor, constant: 40),
            textFieldsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 55),
            textFieldsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -55),
            textFieldsStackView.heightAnchor.constraint(greaterThanOrEqualToConstant: 0),
            
            signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signUpButton.topAnchor.constraint(equalTo: textFieldsStackView.bottomAnchor, constant: 20),
            signUpButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 55),
            signUpButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -55),
            signUpButton.heightAnchor.constraint(equalToConstant: 52),
            
            bottomStackView.topAnchor.constraint(equalTo: signUpButton.bottomAnchor, constant: 50),
            bottomStackView.heightAnchor.constraint(equalToConstant: 52),
            bottomStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bottomStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -10)
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkTextFieldsValue()
    }
    
    private func loaderSetup() {
        loader.frame = self.view.frame
        loader.hideLoader()
        self.view.addSubview(loader)
    }
    
    private func submitSignUpPressed() {
        checkNameParameter()
        checkEmailParameter()
        checkPasswordParameter()
        checkConfirmPassword()
        finalVerificationBeforeSendingToAPI()
    }
    
    private func redirectToSignIn() {
        let controller = SignInViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func checkTextFieldsValue() {
        guard let emailLength = emailTextField.textField.text?.count,
              let nameLength = nameTextField.textField.text?.count,
              let passwordLength = passwordTextField.textField.text?.count,
              let confirmPasswordLength = confirmPasswordTextField.textField.text?.count else {
            signUpButton.buttonDisable()
            return }
        if ParametersVerifier.verifyLetterCount(texts: [
            nameLength,
            emailLength,
            passwordLength,
            confirmPasswordLength
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
        if ParametersVerifier.verifyPasswordTextField(passwordText) {
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


