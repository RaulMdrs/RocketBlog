//
//  LoaderViewController.swift
//  Rocket.up Blog
//
//  Created by Raul de Medeiros on 06/01/23.
//

import UIKit

class LoaderView: UIView {
    @IBOutlet var parentView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViewCustom()
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadViewCustom()
        setupLayout()
    }
    
    func loadViewCustom() {
        Bundle.main.loadNibNamed(K.NibName.loader, owner: self)
        addSubview(parentView)
        parentView.frame = self.bounds
        parentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    func setupLayout() {
        setupBackground()
    }
    
    func setupBackground() {
        self.backgroundColor = .clear
    }
    
    func showLoader() {
        DispatchQueue.main.async {
            self.isHidden = false
            self.activityIndicator.startAnimating()
        }
    }
    
    func hideLoader() {
        DispatchQueue.main.async {
            self.isHidden = true
            self.activityIndicator.stopAnimating()
        }
    }
}
