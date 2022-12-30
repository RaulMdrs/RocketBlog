//
//  RocketWarningPopUpController.swift
//  Rocket.up Blog
//
//  Created by Aline do Amaral on 28/12/22.
//

import UIKit

class RocketWarningModalController: UIView {
    
    @IBOutlet weak var errorLabel: ErrorLabelModal!

    @IBOutlet weak var errorView: UIView!
    @IBOutlet var parentView: UIView!
    @IBOutlet weak var cancelButton: RocketButton!
    @IBOutlet weak var tryAgainButton: RocketButton!
    
    var tryAgainProtocol : TryAgainProtocol?

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViewCustom()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadViewCustom()
    }
    
    func loadViewCustom() {
        Bundle.main.loadNibNamed(K.nibName.RocketWarningModal, owner: self)
        addSubview(parentView)
        configLayout()
    }
    
    func configLayout() {
        isHidden = true
        tryAgainButton.isHidden = true
        errorView.layer.cornerRadius = 12
        errorView.layer.masksToBounds = true
        cancelButton.configButton(type: K.DefaultButton.cancelButton)
    }
    
    func setError(str: String = K.ErrorLabel.defaultErrorMessage) {
        isHidden = false
        errorLabel.setupError(message: str)
    }
    
    func resetError(){
        isHidden = true
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        resetError()
    }
}

protocol TryAgainProtocol{
    func tryAgain()
}
