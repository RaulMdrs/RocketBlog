//
//  PostCollectionViewCell.swift
//  Rocket.up Blog
//
//  Created by Raul de Medeiros on 18/01/23.
//

import UIKit

class PostCollectionViewCell: UICollectionViewCell {

    let identifier = "PostCollectionCell"
    
    private let postImage: UIImageView = {
        var image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = K.AvatarLayoutParameters.cornerRadiusPostCell
        image.layer.masksToBounds = true
        image.image = UIImage(named: K.Images.defaultPostCardBackground)
        return image
    }()
    
    private let descriptionLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: K.Fonts.montserratSemiBold, size: K.Fonts.Size.s1Subtitle)
        label.numberOfLines = 2
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    private let personName: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: K.Fonts.montserratMedium, size: 13)
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    private let personImage: UIImageView = {
        var image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 15
        image.layer.masksToBounds = true
        image.image = UIImage(systemName: "person")
        image.tintColor = UIColor(named: K.Colors.primary)
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCollectionViewCell()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let personStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 4
        stack.distribution = .fill
        stack.alignment = .fill
        return stack
    }()
    
    private func setupCollectionViewCell() {
        self.addSubview(postImage)
        self.addSubview(descriptionLabel)
        self.addSubview(personStackView)
        personStackView.insertArrangedSubview(personImage, at: 0)
        personStackView.insertArrangedSubview(personName, at: 1)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            postImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 7),
            postImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -7),
            postImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 7),
            postImage.heightAnchor.constraint(equalToConstant: 170),
            
            descriptionLabel.topAnchor.constraint(equalTo: postImage.bottomAnchor, constant: 4),
            descriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            descriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 45),
            
            personImage.heightAnchor.constraint(equalToConstant: 26),
            personImage.widthAnchor.constraint(equalToConstant: 26),
            
            personStackView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 4),
            personStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            personStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            personStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8)
        ])
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
