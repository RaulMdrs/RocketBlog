//
//  SliderTab.swift
//  Rocket.up Blog
//
//  Created by Raul de Medeiros on 17/01/23.
//

import UIKit

protocol sliderTabProtocol {
    func redirectToForYou()
    func redirectToPeople()
}

class SliderTab: UIView {
    @IBOutlet var parentView: UIView!
    @IBOutlet weak var forYouButton: UIButton!
    @IBOutlet weak var peopleButton: UIButton!
    @IBOutlet weak var markView: UIView!
    
    var sliderDelegate: sliderTabProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViewCustom()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadViewCustom()
    }
    
    func loadViewCustom() {
        Bundle.main.loadNibNamed(K.NibName.sliderTab, owner: self)
        parentView.frame = bounds
        parentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        addSubview(parentView)
        setupLayout()
    }
    
    @IBAction func forYouButtonPressed(_ sender: Any) {
        animateMark(button: sender)
        setForYouButtonToSelect()
        sliderDelegate?.redirectToForYou()
    }
    
    @IBAction func peopleButtonPressed(_ sender: Any) {
        animateMark(button: sender)
        setPeopleButtonToSelect()
        sliderDelegate?.redirectToPeople()
    }
    
    private func setupLayout() {
        markView.layer.cornerRadius = 2
        markView.layer.masksToBounds = true
    }
    
    private func setForYouButtonToSelect() {
        forYouButton.titleLabel?.font = UIFont(name: K.Fonts.montserratSemiBold, size: 15)
        peopleButton.titleLabel?.font = UIFont(name: K.Fonts.montserratMedium, size: 15)
    }
    
    private func setPeopleButtonToSelect() {
        forYouButton.titleLabel?.font = UIFont(name: K.Fonts.montserratMedium, size: 15)
        peopleButton.titleLabel?.font = UIFont(name: K.Fonts.montserratSemiBold, size: 15)
    }

    func animateMark(button : Any) {
        UIView.animate(withDuration: 1.0, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.3) {
            self.markView.frame.origin.x = (button as AnyObject).frame!.midX - 15
        }
    }
}
