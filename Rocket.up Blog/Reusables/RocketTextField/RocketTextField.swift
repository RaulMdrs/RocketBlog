//
//  RocketTextFieldViewController.swift
//  Rocket.up Blog
//
//  Created by Aline do Amaral on 21/12/22.
//

import UIKit

class RocketTextField: UIView {
    @IBOutlet var parentView: UIView!
    @IBOutlet weak var labelView: UIView!
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var errorLabel: WarningLabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var imageFromTextField: UIImageView!
    @IBOutlet weak var viewForImage: UIView!
    
    var isWarning = false
    private var color : UIColor = UIColor(named: K.Colors.secondary) ?? .black
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadViewCustom()
        self.configLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.loadViewCustom()
        self.configLayout()
    }
    
    func loadViewCustom() {
        Bundle.main.loadNibNamed(K.NibName.rocketTextField, owner: self)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    func setError(message: String) {
        isWarning = true
        viewForImage.backgroundColor = UIColor(named: K.Colors.warning)
        parentView.layer.borderColor = UIColor(named: K.Colors.warning)?.cgColor
        labelView.isHidden = false
        errorLabel.setupWarning(message: message)
    }
    
    func resetError() {
        isWarning = false
        viewForImage.backgroundColor = color
        parentView.layer.borderColor = UIColor(named: K.Colors.mediumGray)?.cgColor
        labelView.isHidden = true
        errorLabel.resetWarning()
    }
    
    func configLayout() {
        viewDefaultForImageSetup()
        parentViewSetup()
        textDefaultFieldSetup()
        errorLabel.setupLayout()
        labelView.isHidden = true
    }
    
    func parentViewSetup() {
        parentView.layer.borderColor = UIColor(named: K.Colors.mediumGray)?.cgColor
        parentView.layer.masksToBounds = true
        parentView.layer.borderWidth = 1
        parentView.layer.cornerRadius = 26
    }
    
    func setColor(newColor : String){
        color = UIColor(named: newColor) ?? .black
    }
    
    func viewDefaultForImageSetup() {
        viewForImage.layer.cornerRadius = 20
        viewForImage.layer.masksToBounds = true
        viewForImage.layer.backgroundColor = UIColor(named: K.Colors.secondary)?.cgColor
    }
    
    func textDefaultFieldSetup() {
        textField.font = UIFont(name: K.Fonts.montserratMedium, size: 12)
        textField.borderStyle = .none
        textField.textColor = .black
        textField.attributedPlaceholder = NSAttributedString(string: "a", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: K.Colors.mediumGray)!])
    }
    
    func customTextField(type : TextFieldType, newColor : String = K.Colors.secondary) {
        setColor(newColor: newColor)
        viewForImage.backgroundColor = color
        textField.returnKeyType = .continue
        switch type {
        case .name:
            textField.text = nil
            textField.keyboardType = .namePhonePad
            textField.placeholder = K.Intl.fullNamePlaceholder
            imageFromTextField.image = UIImage(named: K.ImageTextField.social)
        case .email:
            textField.text = nil
            textField.keyboardType = .emailAddress
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
