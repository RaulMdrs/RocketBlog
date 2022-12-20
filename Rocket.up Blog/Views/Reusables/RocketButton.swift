//
//  RocketButton.swift
//  Rocket.up Blog
//
//  Created by Raul de Medeiros on 19/12/22.
//

import UIKit

class RocketButton: UIButton {
    
    func configButton(type : String){
        layer.cornerRadius = K.DefaultButton.buttonCornerRadius
        layer.masksToBounds = true
        tintColor = .white
        titleLabel?.font = UIFont(name: K.Fonts.montserratBold, size: K.DefaultButton.buttonFontSize)
        
        if type == K.DefaultButton.signInButton{
            configSignInButton()
        }else if type == K.DefaultButton.signUpButton{
            configSignUpButton()
        }
    }
    
    func configSignInButton(){
        backgroundColor = UIColor(named: K.Colors.primary)
        setTitle(K.Intl.signInButtonTitle, for: .normal)
    }
    
    func configSignUpButton(){
        backgroundColor = UIColor(named: K.Colors.secondary)
        setTitle(K.Intl.signUpButtonTitle, for: .normal)
    }

}


