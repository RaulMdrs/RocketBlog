//
//  ShowErrorModal.swift
//  Rocket.up Blog
//
//  Created by Raul de Medeiros on 25/01/23.
//

import UIKit

struct ShowError {
    static func ShowErrorModal(targetView: UIView, message: String, animationDuration: Float){
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){
            let errorModal = RocketWarningModal(frame: targetView.frame)
            errorModal.alpha = 0
            UIView.animate(withDuration: TimeInterval(animationDuration)) {
                errorModal.alpha = 1.0
            }
            errorModal.setError(str: message)
            targetView.addSubview(errorModal)
        }
    }
}

