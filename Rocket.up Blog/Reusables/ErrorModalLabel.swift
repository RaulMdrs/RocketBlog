//
//  ErrorLabelPopUp.swift
//  Rocket.up Blog
//
//  Created by Raul de Medeiros on 29/12/22.
//

import UIKit

class ErrorModalLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayout()
    }
    
    func setupLayout() {
        self.text = ""
        self.font = UIFont(name: K.Fonts.montserratBold, size: K.Fonts.Size.s1Subtitle)
        textColor = UIColor(named: K.Colors.black)
    }
    
    func setupError(message: String) {
        text = message
    }
}
