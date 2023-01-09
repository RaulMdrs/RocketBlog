//
//  Constants.swift
//  Rocket.up Blog
//
//  Created by Raul de Medeiros on 19/12/22.
//

import Foundation

class K {
    struct TypeTextField {
        static let name : String = "name"
        static let email : String = "email"
        static let password : String = "password"
        static let confirmPassword : String = "confirmPassword"
    }
    
    struct DefaultButton {
        static let buttonCornerRadius: CGFloat = 26
        static let buttonFontSize : CGFloat = 14.0
        static let buttonErrorModalCornerRadius : CGFloat = 12
        struct ButtonColors {
            static let primary : String = "Primary"
            static let secondary : String = "Secondary"
            static let danger : String = "Danger"
            static let disabledButton : String = "DisabledButton"
        }
    }
    
    struct Fonts {
        static let montserratBold : String = "Montserrat-Bold"
        static let montserratMedium : String = "Montserrat-Medium"
        static let montserratRegular : String = "Montserrat-Regular"
        struct Size {
            static let warningSize : CGFloat = 12.0
            
            static let buttonFontSizeGiant : CGFloat = 18
            static let buttonFontSizeLarge : CGFloat = 16
            static let buttonFontSizeMedium : CGFloat = 14
            static let buttonFontSizeSmall : CGFloat = 12
            static let buttonFontSizeTiny : CGFloat = 10
            
            static let h1Headline : CGFloat = 36
            static let h2Headline : CGFloat = 32
            static let h3Headline : CGFloat = 30
            static let h4Headline : CGFloat = 26
            static let h5Headline : CGFloat = 22
            
            static let s1Subtitle : CGFloat = 15
            static let s2Subtitle: CGFloat = 12
        }
    }
    
    struct Colors{
        
        static let warning : String = "Danger"
        static let success : String = "Success"
        static let attention : String = "Attention"
        
        static let black : String = "Black"
        static let white : String = "White"
        
        static let mediumGray : String = "MediumGray"
        static let lightGray : String = "LightGray"
        static let disabledButton : String = "DisableButton"
        
        static let primary : String = "Primary"
        static let secondary : String = "Secondary"
        static let blue : String = "Blue"
        static let turquoise : String = "Turquoise"
    }
    
    struct StoryboardNames{
        static let landingPage = "Main"
        static let signIn = "SignInView"
        static let signUp = "SignUpView"
        static let home = "HomeView"
    }
    
    struct nibName {
        static let rocketWarningModal : String = "RocketWarningModal"
        static let rocketTextField: String = "RocketTextField"
        static let loader : String = "Loader"
    }
    
    struct Intl {
        static let signInButtonTitle : String = "Login"
        static let signUpButtonTitle : String = "Inscrever-se"
        static let understoodButton: String = "Entendi"
        static let tryAgainButton : String = "Tentar Novamente"
        static let fullNamePlaceholder : String = "Nome completo"
        static let emailPlaceholder : String = "E-mail"
        static let passwordPlaceholder : String = "Senha"
        static let confirmPasswordPlaceholder : String = "Confirmação de senha"
        static let errorName : String = "Informe seu nome completo"
        static let errorEmail : String = "Formato de email inválido"
        static let errorEmailLoginScreen : String = "O e-mail informado não é válido."
        static let errorPassword : String = "Deve conter ao menos 1 letra, 1 número, 1 caractere especial e ter 6 ou mais caracteres"
        static let errorConfirmPassword : String = "A confirmação de senha deve ser idêntica à senha."
        static let errorDefaultErrorMessage : String = "Ops!\nAlgo inesperado aconteceu."
    }
    
    struct ImageTextField {
        static let social : String = "social"
        static let mail : String = "mail"
        static let locker : String = "locker"
        static let backArrow : String = "backArrow"
    }
    
    struct ResponseAPI {
        static let success : String = "success"
        static let failed : String = "failed"
        static let accessToken : String = "accessToken"
    }
}
