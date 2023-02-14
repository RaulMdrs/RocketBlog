//
//  SignUpViewControllerExtension.swift
//  Rocket.up Blog
//
//  Created by Raul de Medeiros on 09/02/23.
//

import UIKit

extension SignUpViewController : UITextFieldDelegate {
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
extension SignUpViewController: RequestDelegate {
    func success<T>(_ response: T) {
        guard response is RegisterResponse else {return}
        loader.hideLoader()
        self.navigationController?.popToRootViewController(animated: false)
    }
    
    func errorMessage(_ message: String) {
        loader.hideLoader()
        ShowError.ShowErrorModal(targetView: self.view, message: message, animationDuration: 0.5)
    }
}
