//
//  RocketTextFieldViewController.swift
//  Rocket.up Blog
//
//  Created by Aline do Amaral on 21/12/22.
//

import UIKit

class RocketTextField: UIView {
   
    var isWarning = false
    private var color : UIColor = UIColor(named: K.Colors.secondary) ?? .black
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView
            .axis = .vertical
        stackView.spacing = 4
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()
    
    private let textFieldView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let errorView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let viewForImage: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
        view.layer.backgroundColor = UIColor(named: K.Colors.secondary)?.cgColor
        return view
    }()
    
    private let imageFromTextField: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let errorLabel: WarningLabel = {
        let label = WarningLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .justified
        label.setupLayout()
        return label
    }()
    
    let textField: UITextField = {
       let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont(name: K.Fonts.montserratMedium, size: 12)
        textField.borderStyle = .none
        textField.textColor = .black
        textField.attributedPlaceholder = NSAttributedString(string: "a", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: K.Colors.mediumGray)!])
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHierarchy()
        setupConstraints()
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupHierarchy()
        setupConstraints()
        setupLayout()
    }
    
    private func setupHierarchy() {
        addSubview(stackView)
        stackView.addArrangedSubview(textFieldView)
        stackView.addArrangedSubview(errorView)
        textFieldView.addSubview(viewForImage)
        viewForImage.addSubview(imageFromTextField)
        textFieldView.addSubview(textField)
        errorView.addSubview(errorLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            textFieldView.heightAnchor.constraint(equalToConstant: 52),
            
            viewForImage.widthAnchor.constraint(equalToConstant: 42),
            viewForImage.topAnchor.constraint(equalTo: textFieldView.topAnchor, constant: 5),
            viewForImage.bottomAnchor.constraint(equalTo: textFieldView.bottomAnchor, constant: -5),
            viewForImage.leadingAnchor.constraint(equalTo: textFieldView.leadingAnchor, constant: 5),
            
            imageFromTextField.centerXAnchor.constraint(equalTo: viewForImage.centerXAnchor),
            imageFromTextField.centerYAnchor.constraint(equalTo: viewForImage.centerYAnchor),
            imageFromTextField.widthAnchor.constraint(equalToConstant: 11),
            imageFromTextField.heightAnchor.constraint(equalToConstant: 11),
            
            textField.topAnchor.constraint(equalTo: textFieldView.topAnchor, constant: 4),
            textField.leadingAnchor.constraint(equalTo: viewForImage.trailingAnchor, constant: 8),
            textField.bottomAnchor.constraint(equalTo: textFieldView.bottomAnchor, constant: -4),
            textField.trailingAnchor.constraint(equalTo: textFieldView.trailingAnchor, constant: -4),
            
            errorLabel.topAnchor.constraint(equalTo: errorView.topAnchor),
            errorLabel.leadingAnchor.constraint(equalTo: errorView.leadingAnchor, constant: 8),
            errorLabel.trailingAnchor.constraint(equalTo: errorView.trailingAnchor),
            errorLabel.bottomAnchor.constraint(equalTo: errorView.bottomAnchor),
            errorLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 12)
        ])
    }
    
    func setupLayout() {
        textFieldView.layer.borderColor = UIColor(named: K.Colors.mediumGray)?.cgColor
        textFieldView.layer.masksToBounds = true
        textFieldView.layer.borderWidth = 1
        textFieldView.layer.cornerRadius = 26
        errorView.isHidden = true
    }
    
    func setError(message: String) {
        isWarning = true
        viewForImage.backgroundColor = UIColor(named: K.Colors.warning)
        layer.borderColor = UIColor(named: K.Colors.warning)?.cgColor
        errorView.isHidden = false
        errorLabel.setupWarning(message: message)
    }
    
    func resetError() {
        isWarning = false
        viewForImage.backgroundColor = color
        layer.borderColor = UIColor(named: K.Colors.mediumGray)?.cgColor
        errorView.isHidden = true
        errorLabel.resetWarning()
    }
    
    func setColor(newColor : String){
        color = UIColor(named: newColor) ?? .black
    }
    
    func customTextField(type : TextFieldType, newColor : String = K.Colors.secondary) {
        setColor(newColor: newColor)
        viewForImage.backgroundColor = color
        textField.returnKeyType = .continue
        switch type {
        case .name:
            textField.text = nil
            textField.autocapitalizationType = .words
            textField.keyboardType = .namePhonePad
            textField.placeholder = K.Intl.fullNamePlaceholder
            imageFromTextField.image = UIImage(named: K.ImageTextField.social)
        case .email:
            textField.text = nil
            textField.keyboardType = .emailAddress
            textField.autocapitalizationType = .none
            textField.placeholder = K.Intl.emailPlaceholder
            imageFromTextField.image = UIImage(named: K.ImageTextField.mail)
        case .password:
            textField.text = nil
            textField.isSecureTextEntry = true
            textField.textContentType = .oneTimeCode
            textField.placeholder = K.Intl.passwordPlaceholder
            imageFromTextField.image = UIImage(named: K.ImageTextField.locker)
        case .confirmPassword:
            textField.text = nil
            textField.isSecureTextEntry = true
            textField.textContentType = .oneTimeCode
            textField.placeholder = K.Intl.confirmPasswordPlaceholder
            imageFromTextField.image = UIImage(named: K.ImageTextField.locker)
        }
    }
}

enum TextFieldType {
    case name
    case email
    case password
    case confirmPassword
}
