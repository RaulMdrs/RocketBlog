//
//  RocketButton.swift
//  Rocket.up Blog
//
//  Created by Raul de Medeiros on 19/12/22.
//

import UIKit

final class RocketButton: UIButton {
    enum ButtonType {
        case primary
        case secondary
        case disabled
        case danger
        case tertiary
        case quaternary
    }
    
    var type: ButtonType = .primary {
        didSet {
            setupTheButton()
        }
    }
    
    init() {
        super.init(frame: .zero)
        setupTheButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupTheButton()
    }
    
    private func setupTheButton() {
        layer.cornerRadius = K.DefaultButton.buttonCornerRadius
        layer.masksToBounds = true
        tintColor = .white
        titleLabel?.font = UIFont(name: K.Fonts.montserratBold, size: K.DefaultButton.buttonFontSize)
        
        switch type {
        case .primary:
            backgroundColor = UIColor(named: K.DefaultButton.ButtonColors.primary)
        case .secondary:
            backgroundColor = UIColor(named: K.DefaultButton.ButtonColors.secondary)
        case .tertiary:
            backgroundColor = .clear
            setTitleColor(UIColor(named: K.DefaultButton.ButtonColors.primary), for: .normal)
        case .quaternary:
            backgroundColor = .clear
            setTitleColor(UIColor(named: K.DefaultButton.ButtonColors.secondary), for: .normal)
        case .disabled:
            backgroundColor = UIColor(named: K.DefaultButton.ButtonColors.disabledButton)
            tintColor = .white
        case .danger:
            backgroundColor = UIColor(named: K.DefaultButton.ButtonColors.danger)
        }
    }
        
    func buttonEnable() {
        isEnabled = true
    }
    
    func buttonDisable() {
        isEnabled = false
        self.type = .disabled
    }
}
