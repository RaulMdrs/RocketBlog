//
//  RocketWarningPopUpController.swift
//  Rocket.up Blog
//
//  Created by Aline do Amaral on 28/12/22.
//

import UIKit

class RocketWarningModal: UIView {
    
    @IBOutlet weak var errorLabel: ErrorModalLabel!
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
        Bundle.main.loadNibNamed(K.NibName.rocketWarningModal, owner: self)
        parentView.frame = bounds
        parentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        addSubview(parentView)
        configLayout()
    }
    
    func configLayout() {
        isHidden = true
        tryAgainButton.isHidden = true
        setupErrorView()
        setupButton()
    }
    
    func setupErrorView() {
        errorView.layer.cornerRadius = 12
        errorView.layer.masksToBounds = true
    }
    
    func setupButton() {
        cancelButton.type = .primary
        cancelButton.setTitle(K.Intl.understoodButton, for: .normal)
        cancelButton.layer.cornerRadius = K.DefaultButton.buttonErrorModalCornerRadius
    }
    
    func setError(str: String = K.Intl.errorDefaultErrorMessage) {
        isHidden = false
        errorLabel.setupError(message: str)
    }
    
    func resetError() {
        self.removeFromSuperview()
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        resetError()
    }
}

protocol TryAgainProtocol{
    func tryAgain()
}
