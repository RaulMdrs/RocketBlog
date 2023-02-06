//
//  PostCollectionViewCell.swift
//  Rocket.up Blog
//
//  Created by Raul de Medeiros on 18/01/23.
//

import UIKit

class PostCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var personName: UILabel!
    @IBOutlet weak var personImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupLayout()
    }
    
    func setupLayout() {
        postImage.layer.cornerRadius = K.AvatarLayoutParameters.cornerRadiusPostCell
        postImage.layer.masksToBounds = true
        personImage.layer.cornerRadius = K.AvatarLayoutParameters.cornerRadiusPostCell
        personImage.clipsToBounds = true
        descriptionLabel.font = UIFont(name: K.Fonts.montserratSemiBold, size: K.Fonts.Size.s1Subtitle)
    }
    
    func setupPost(post: Post) {
        descriptionLabel.text = post.title
        personName.text = post.postedBy.first?.getFirstAndLastName()
        
        guard let userImage = post.postedBy.first?.avatar.imageFromBase64 else {return}
        personImage.image = userImage
        
        guard let postBackgroundImage = post.image?.imageFromBase64 else {return}
        postImage.image = postBackgroundImage
    }
}
