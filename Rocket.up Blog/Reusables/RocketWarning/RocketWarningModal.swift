//
//  RocketWarningPopUpController.swift
//  Rocket.up Blog
//
//  Created by Aline do Amaral on 28/12/22.
//

import UIKit

class RocketWarningModal: UIView {
    
    private let alertImage : UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "alertImage")
        image.backgroundColor = .clear
        return image
    }()
    
    private let errorLabel: ErrorModalLabel = {
        let label = ErrorModalLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont(name: K.Fonts.montserratSemiBold, size: 17)
        label.contentMode = .center
        label.textAlignment = .center
        return label
    }()
    private let errorView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var cancelButton: RocketButton = {
        let rocketButton = RocketButton()
        rocketButton.translatesAutoresizingMaskIntoConstraints = false
        rocketButton.type = .primary
        rocketButton.setTitle(K.Intl.understoodButton, for: .normal)
        rocketButton.layer.cornerRadius = K.DefaultButton.buttonErrorModalCornerRadius
        rocketButton.addAction(UIAction(handler: { UIAction in
            self.resetError()
        }), for: .touchUpInside)
        return rocketButton
    }()
    private let tryAgainButton: RocketButton = {
        let rocketButton = RocketButton()
        return rocketButton
    }()
    
    private let stackView : UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        return stackView
    }()
    
    var tryAgainProtocol : TryAgainProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configLayout()
    }
    
    private func configLayout() {
        setupHierarchy()
        setupConstraints()
        isHidden = true
        tryAgainButton.isHidden = true
        backgroundColor = .black.withAlphaComponent(0.30)
        setupErrorView()
    }
    
    func setupErrorView() {
        errorView.layer.cornerRadius = 12
        errorView.layer.masksToBounds = true
    }
    
    func setError(str: String = K.Intl.errorDefaultErrorMessage) {
        isHidden = false
        errorLabel.setupError(message: str)
    }
    
    private func resetError() {
        self.removeFromSuperview()
    }
    
    private func setupHierarchy() {
        addSubview(errorView)
        errorView.addSubview(alertImage)
        errorView.addSubview(errorLabel)
        errorView.addSubview(stackView)
        
        stackView.addArrangedSubview(cancelButton)
        stackView.addArrangedSubview(tryAgainButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            errorView.topAnchor.constraint(equalTo: topAnchor, constant: 180),
            errorView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            errorView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            errorView.heightAnchor.constraint(equalToConstant: 220),
            
            alertImage.topAnchor.constraint(equalTo: errorView.topAnchor, constant: 27),
            alertImage.heightAnchor.constraint(equalToConstant: 60),
            alertImage.widthAnchor.constraint(equalToConstant: 60),
            alertImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            errorLabel.topAnchor.constraint(equalTo: alertImage.bottomAnchor, constant: 12),
            errorLabel.leadingAnchor.constraint(equalTo: errorView.leadingAnchor, constant: 25),
            errorLabel.trailingAnchor.constraint(equalTo: errorView.trailingAnchor, constant: -25),
            
            stackView.topAnchor.constraint(equalTo: errorLabel.bottomAnchor, constant: 35),
            stackView.leadingAnchor.constraint(equalTo: errorView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: errorView.trailingAnchor, constant: -20)
        ])
    }
}

protocol TryAgainProtocol{
    func tryAgain()
}
