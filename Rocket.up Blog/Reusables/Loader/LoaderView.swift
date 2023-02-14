//
//  LoaderViewController.swift
//  Rocket.up Blog
//
//  Created by Raul de Medeiros on 06/01/23.
//

import UIKit

class LoaderView: UIView {
    private let loader : UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.style = .large
        activityIndicator.color = UIColor(named: K.Colors.secondary)
        activityIndicator.backgroundColor = UIColor(named: K.Colors.secondary)?.withAlphaComponent(0.5)
        return activityIndicator
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayout()
    }
    
    private func setupLayout() {
        setupBackground()
        setupHierarchy()
        setupConstraints()
    }
    
    private func setupBackground() {
        self.backgroundColor = .clear
    }
    
    private func setupHierarchy() {
        addSubview(loader)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            loader.topAnchor.constraint(equalTo: self.topAnchor),
            loader.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            loader.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            loader.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    func showLoader() {
        DispatchQueue.main.async {
            self.isHidden = false
            self.loader.startAnimating()
        }
    }
    
    func hideLoader() {
        DispatchQueue.main.async {
            self.isHidden = true
            self.loader.stopAnimating()
        }
    }
}
