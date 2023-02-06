//
//  PersonCardCollectionViewCell.swift
//  Rocket.up Blog
//
//  Created by Aline do Amaral on 19/01/23.
//

import UIKit

class PersonCardCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var cardContentView: UIView!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var avatarView: UIView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var personName: UILabel!
    @IBOutlet weak var goToProfileButton: RocketButton!
    
    @IBAction func seeProfileButtonPressed(_ sender: Any) {
        
        let storyboard: UIStoryboard = UIStoryboard(name: "ProfileView", bundle: nil)
        let profileScreen = storyboard.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        profileScreen.modalPresentationStyle = .overFullScreen
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupLayout()
    }

    func setupLayout() {
        cardContentView.layer.cornerRadius = 12
        cardContentView.layer.masksToBounds = true
        cardContentView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.16).cgColor
        cardContentView.layer.cornerRadius = 12
        cardContentView.layer.shadowOffset = CGSize(width: 10, height: 10)

        avatarView.layer.cornerRadius = 25
        avatarView.layer.masksToBounds = true
        goToProfileButton.type = .primary
        goToProfileButton.setTitle("Ver perfil", for: .normal)
        goToProfileButton.layer.cornerRadius = 12
    }
    
    
}
