import UIKit

class SignInViewController: UIViewController {
    
    let identifier = "SignInView"

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = true
        scrollView.isScrollEnabled = true
        scrollView.alwaysBounceVertical = true
        return scrollView
    }()

    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let logoAndGreetingsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 40
        return stackView
    }()

    private let rocketLogo: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "procket2")
        return img
    }()

    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Bem vindo!"
        label.font = UIFont(name: K.Fonts.montserratBold, size: 30)
        label.tintColor = .black
        return label
    }()

    private let textfieldStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 11
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()

    private let emailTextField: RocketTextField = {
        let txf = RocketTextField()
        txf.translatesAutoresizingMaskIntoConstraints = false
        txf.customTextField(type: .email, newColor: K.Colors.primary)
        return txf
    }()

    private let passwordTextField: RocketTextField = {
        let txf = RocketTextField()
        txf.translatesAutoresizingMaskIntoConstraints = false
        txf.customTextField(type: .password, newColor: K.Colors.primary)
        return txf
    }()

    lazy var signInButton: RocketButton = {
        let button = RocketButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.buttonEnable()
        button.type = .primary
        button.setTitle(K.Intl.signInButtonTitle, for: .normal)
        button.addAction(UIAction(handler: { UIAction in
            self.signInButtonPressed()
        }), for: .touchUpInside)
        return button
    }()

    private let footerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        return stackView
    }()

    private let newAccountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Criar nova conta?"
        return label
    }()

    lazy var redirectToSignUpButton: RocketButton = {
        let button = RocketButton()
        button.type = .quaternary
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Inscrever-se", for: .normal)
        button.addAction(UIAction(handler: { UIAction in
            self.signUpButtonPressed()
        }), for: .touchUpInside)
        return button
    }()

    var loader = LoaderView()
    var userToLogin : UserLogin = UserLogin(email: "", password: "")
    var postRequest = ApiManager()
    var readyToLogin = ReadyToLogin()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupUI()
        postRequest.requestDelegate = self
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
    
    private func setupUI() {
        setupHierarchy()
        setupConstraints()
    }

    private func setupLayout() {
        setTextFieldDelegate()
        loaderSetup()
    }

    private func setTextFieldDelegate() {
        emailTextField.textField.delegate = self
        passwordTextField.textField.delegate = self
    }

    private func loaderSetup() {
        loader = LoaderView(frame: self.view.frame)
        loader.hideLoader()
        self.view.addSubview(loader)
    }

    private func signInButtonPressed() {
        checkEmailParameter()
        finalVerificationBeforeSendingToAPI()
    }

    private func signUpButtonPressed() {
        let controller = SignUpViewController()
        navigationController?.pushViewController(controller, animated: true)
    }

    private func checkTextFieldsValue() {
        guard let emailLength = emailTextField.textField.text?.count else {return}
        guard let password = passwordTextField.textField.text else {return}
        if (ParametersVerifier.verifyLetterCount(texts:  [emailLength])) && (ParametersVerifier.verifyLetterCountLoginPassword(text: password) == true) {
            signInButton.buttonEnable()
            signInButton.type = .primary
            signInButton.setTitle(K.Intl.signInButtonTitle, for: .normal)
            guard let textReceived = passwordTextField.textField.text else {return}
            userToLogin.password = textReceived
            readyToLogin.setPassword(state: true)
        } else {
            signInButton.buttonDisable()
            signInButton.setTitle(K.Intl.signInButtonTitle, for: .disabled)
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
            postRequest.genericRequest(model: LoginResponse.self, path: ApiPath.apiLoginPath(), method: .post, header: ["accept":"application/json", "Content-Type":"application/json"], body: ["email": userToLogin.email, "password": userToLogin.password])
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

    private func setupHierarchy() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(logoAndGreetingsStackView)
        logoAndGreetingsStackView.addArrangedSubview(rocketLogo)
        logoAndGreetingsStackView.addArrangedSubview(welcomeLabel)
        contentView.addSubview(textfieldStackView)
        textfieldStackView.addArrangedSubview(emailTextField)
        textfieldStackView.addArrangedSubview(passwordTextField)
        contentView.addSubview(signInButton)
        contentView.addSubview(footerStackView)
        footerStackView.addArrangedSubview(newAccountLabel)
        footerStackView.addArrangedSubview(redirectToSignUpButton)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),

            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),

            logoAndGreetingsStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            logoAndGreetingsStackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            logoAndGreetingsStackView.widthAnchor.constraint(equalToConstant: 200),

            rocketLogo.heightAnchor.constraint(equalToConstant: 140),
            rocketLogo.widthAnchor.constraint(equalToConstant: 144),

            textfieldStackView.topAnchor.constraint(equalTo: logoAndGreetingsStackView.bottomAnchor, constant: 40),
            textfieldStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -55),
            textfieldStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 55),
            textfieldStackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 0),
            
            signInButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            signInButton.heightAnchor.constraint(equalToConstant: 52),
            signInButton.topAnchor.constraint(equalTo: textfieldStackView.bottomAnchor, constant: 20),
            signInButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 55),
            signInButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 55),
            
    
            footerStackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            footerStackView.heightAnchor.constraint(equalToConstant: 44),
            footerStackView.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 51),
            footerStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
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
extension SignInViewController: RequestDelegate {
    func success<T>(_ response: T) {
        guard let loginResponse = response as? LoginResponse else {return}
        guard let token = loginResponse.data?.accessToken else {return}
        Authentication.shared.accessToken = token
        loader.hideLoader()
        redirectToHomeViewControllerScreen()
    }

    func errorMessage(_ message: String) {
        loader.hideLoader()
        ShowError.ShowErrorModal(targetView: self.view, message: message, animationDuration: 0.5)
    }
}

