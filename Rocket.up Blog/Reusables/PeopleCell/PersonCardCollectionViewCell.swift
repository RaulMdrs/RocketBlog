//
//  PersonCardCollectionViewCell.swift
//  Rocket.up Blog
//
//  Created by Aline do Amaral on 19/01/23.
//

import UIKit

class PersonCardCollectionViewCell: UICollectionViewCell {
    let identifier = "PersonCardCollectionCell"
    var delegate : GoToUser?
    var user : User?
    lazy var shadowView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .none
        view.frame = contentView.frame
        view.clipsToBounds = false
        view.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.16).cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 7
        view.layer.shadowOffset = CGSize(width: 2, height: 2)
        view.layer.bounds = view.bounds
        view.layer.position = view.center
        view.layer.cornerRadius = 12
        view.layer.masksToBounds = true
        return view
    }()
    
    private let cardContentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.layer.masksToBounds = true
        return view
    }()
    
    private let backgroundImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: K.Images.defaultPostCardBackground)
        image.contentMode = .scaleToFill
        return image
    }()
    
    private let avatarView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 29
        view.backgroundColor = .white
        view.layer.masksToBounds = true
        return view
    }()
    
    private let avatarImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.tintColor = UIColor(named: K.Colors.primary)
        image.contentMode = .scaleAspectFill
        image.layer.masksToBounds = true
        return image
    }()
    
    private let personNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: K.Fonts.montserratMedium, size: 15)
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.textAlignment = .center
        return label
    }()
    
    lazy var goToProfileButton: RocketButton = {
        let button = RocketButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.type = .primary
        button.setTitle("Ver perfil", for: .normal)
        button.layer.cornerRadius = 12
        button.addAction(UIAction(handler: { UIAction in
            self.goToProfileButtonPressed()
        }), for: .touchUpInside)
        return button
    }()
    
    private func goToProfileButtonPressed() {
        if let user = user{
            delegate?.gotToUser(user: user)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    private func setupUI() {
        setupHierarchy()
        setupConstraints()
    }
    
    private func setupHierarchy() {
        self.addSubview(shadowView)
        shadowView.addSubview(cardContentView)
        cardContentView.addSubview(backgroundImage)
        cardContentView.addSubview(avatarView)
        avatarView.addSubview(avatarImageView)
        cardContentView.addSubview(personNameLabel)
        cardContentView.addSubview(goToProfileButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            shadowView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            shadowView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            shadowView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            shadowView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            
            cardContentView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            cardContentView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            cardContentView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
            cardContentView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            cardContentView.heightAnchor.constraint(equalToConstant: 215),
            cardContentView.widthAnchor.constraint(equalToConstant: 140),
            
            backgroundImage.centerXAnchor.constraint(equalTo: self.cardContentView.centerXAnchor, constant: 0),
            backgroundImage.topAnchor.constraint(equalTo: self.cardContentView.topAnchor, constant: 0),
            backgroundImage.trailingAnchor.constraint(equalTo: self.cardContentView.trailingAnchor, constant: 0),
            backgroundImage.leadingAnchor.constraint(equalTo: self.cardContentView.leadingAnchor, constant: 0),
            backgroundImage.heightAnchor.constraint(equalToConstant: 78),
            
            avatarView.centerXAnchor.constraint(equalTo: self.cardContentView.centerXAnchor, constant: 0),
            avatarView.topAnchor.constraint(equalTo: self.cardContentView.topAnchor, constant: 49),
            avatarView.heightAnchor.constraint(equalToConstant: 58),
            avatarView.widthAnchor.constraint(equalToConstant: 58),
            
            avatarImageView.topAnchor.constraint(equalTo: avatarView.topAnchor),
            avatarImageView.bottomAnchor.constraint(equalTo: avatarView.bottomAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: avatarView.leadingAnchor),
            avatarImageView.trailingAnchor.constraint(equalTo: avatarView.trailingAnchor),
            
            personNameLabel.topAnchor.constraint(equalTo: self.avatarView.bottomAnchor, constant: 5),
            personNameLabel.trailingAnchor.constraint(equalTo: self.cardContentView.trailingAnchor, constant: -18),
            personNameLabel.leadingAnchor.constraint(equalTo: self.cardContentView.leadingAnchor, constant: 18),
            
            goToProfileButton.topAnchor.constraint(equalTo: self.personNameLabel.bottomAnchor, constant: 7),
            goToProfileButton.trailingAnchor.constraint(equalTo: self.cardContentView.trailingAnchor, constant: -16),
            goToProfileButton.bottomAnchor.constraint(equalTo: self.cardContentView.bottomAnchor, constant: -34),
            goToProfileButton.leadingAnchor.constraint(equalTo: self.cardContentView.leadingAnchor, constant: 16),
            goToProfileButton.heightAnchor.constraint(equalToConstant: 38)
        ])
    }
    
    func setupDefinitiveLayout(user : User) {
        self.user = user
        if let image = user.avatar?.imageFromBase64 {
            avatarImageView.image = image
        } else {
            avatarImageView.image = UIImage(systemName: "person.circle")
        }

        if let bgImage = user.background?.imageFromBase64 {
            backgroundImage.image = bgImage
        } else {
            backgroundImage.image = UIImage(named: "DefaultPostCardBackground")
        }
        
        personNameLabel.text = user.getFirstAndLastName()
    }
}

protocol GoToUser {
    func gotToUser(user : User)
}
