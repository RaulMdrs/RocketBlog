//
//  RocketButton.swift
//  Rocket.up Blog
//
//  Created by Raul de Medeiros on 19/12/22.
//

import UIKit

class RocketButton: UIButton {
    var type : ButtonTypeEnum = .primary

    func setupButton(type : ButtonTypeEnum, title : String) {
        self.type = type
        layer.cornerRadius = K.DefaultButton.buttonCornerRadius
        layer.masksToBounds = true
        tintColor = .white
        titleLabel?.font = UIFont(name: K.Fonts.montserratBold, size: K.DefaultButton.buttonFontSize)
        backgroundColor = UIColor(named: type.rawValue)
        setTitle(title, for: .normal)
    }
    
    func buttonEnable() {
        isEnabled = true
        backgroundColor = UIColor(named: type.rawValue)
    }
    
    func buttonDisable() {
        isEnabled = false
        tintColor = .white
        backgroundColor = UIColor(named: ButtonTypeEnum.disabled.rawValue)
    }
}


enum ButtonTypeEnum : String {
    case primary = "Primary"
    case secondary = "Secondary"
    case disabled = "DisabledButton"
    case danger = "Danger"
}
