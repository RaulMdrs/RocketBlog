//
//  WarningLabelController.swift
//  Rocket.up Blog
//
//  Created by Raul de Medeiros on 23/12/22.
//

import UIKit

class WarningLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayout()
    }
    
    func setupLayout() {
        self.isHidden = true
        self.text = ""
        self.font = UIFont(name: K.Fonts.montserratRegular, size: 12)
        textColor = UIColor(named: K.Colors.warning)
    }
    
    func setupWarning(message : String) {
        isHidden = false
        text = message
    }
    
    func resetWarning() {
        isHidden = true
        text = ""
    }
}
