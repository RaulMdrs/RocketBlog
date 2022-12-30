//
//  RocketTextFieldViewController.swift
//  Rocket.up Blog
//
//  Created by Aline do Amaral on 21/12/22.
//

import UIKit

class RocketTextFieldController: UIView {

    @IBOutlet var parentView: UIView!
    
    @IBOutlet weak var labelView: UIView!
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var errorLabel: WarningLabelController!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var imageFromTextField: UIImageView!
    @IBOutlet weak var viewForImage: UIView!
    
    var isWarning = false
    
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
        
        Bundle.main.loadNibNamed(K.nibName.RocketTextField, owner: self)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    func configWarning() {
        if !isWarning {
            isWarning = true
            viewForImage.backgroundColor = UIColor(named: K.Colors.warning)
            parentView.layer.borderColor = UIColor(named: K.Colors.warning)?.cgColor
            labelView.isHidden = false
        } else {
            isWarning = false
            viewForImage.backgroundColor = UIColor(named: K.Colors.secondary)
            parentView.layer.borderColor = UIColor(named: K.Colors.mediumGray)?.cgColor
            labelView.isHidden = true
            errorLabel.resetWarning()
        }
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
    
    func customTextField(type : String){
        switch type{
        case K.TypeTextField.name:
            textField.text = nil
            textField.placeholder = K.Intl.fullNamePlaceholder
            imageFromTextField.image = UIImage(named: K.ImageTextField.social)
        case K.TypeTextField.email:
            textField.text = nil
            textField.placeholder = K.Intl.emailPlaceholder
            imageFromTextField.image = UIImage(named: K.ImageTextField.mail)
        case K.TypeTextField.password:
            textField.text = nil
            textField.isSecureTextEntry = true
            textField.textContentType = .oneTimeCode
            textField.placeholder = K.Intl.passwordPlaceholder
            imageFromTextField.image = UIImage(named: K.ImageTextField.locker)
        case K.TypeTextField.confirmPassword:
            textField.text = nil
            textField.isSecureTextEntry = true
            textField.textContentType = .oneTimeCode
            textField.placeholder = K.Intl.confirmPasswordPlaceholder
            imageFromTextField.image = UIImage(named: K.ImageTextField.locker)
        default:  textField.placeholder = ""
            
        }
    }
}

