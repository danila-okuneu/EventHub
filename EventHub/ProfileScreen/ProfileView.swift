//
//  ProfileView.swift
//  EventHub
//
//  Created by Vika on 20.11.24.
//

import UIKit

protocol ProfileViewDelegate: AnyObject {
    func didTapReadMore()
}

class ProfileView: UIView {
    
    weak var delegate: ProfileViewDelegate?

    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    //MARK: - ui properties
    
    let header1 = UILabel()
    let profileImageView = UIImageView()
    let nameLabel = UILabel()
    let nameTextField = UITextField()
    let header2 = UILabel()
    let aboutLabel = UILabel()
    let aboutTextView = UITextView()
    
    let editButton = CustomButton(title: "Edit Profile", icon: .editIcon, hasBorder: true, borderColor: .accent, textColor: .accent, iconTintColor: .accent)
	
    let backSaveButton = UIButton(type: .system)
    let signOutButton = CustomButton(title: "Sign Out", icon: .signOutIcon, hasBorder: false, textColor: .black, iconTintColor: .gray)
    
    let editNameIcon = UIImageView(image: .editIcon)
    let editAboutIcon = UIImageView(image: .editIcon)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
    
    //MARK: - scroll settings
        
        addSubview(scrollView)
        scrollView.addSubview(contentView)
		scrollView.isScrollEnabled = true
		scrollView.alwaysBounceVertical = true
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
        
    //MARK: - ui settings
        
        // profile header
        header1.text = "Profile"
        header1.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        header1.textAlignment = .center
        header1.textColor = .black
        
        // back arrow
        backSaveButton.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        backSaveButton.tintColor = .black
        var config = UIButton.Configuration.plain()
        backSaveButton.configuration = config
        config.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)

        // photo
        profileImageView.image = UIImage(systemName: "person.fill")
        profileImageView.layer.cornerRadius = 50
        profileImageView.clipsToBounds = true
        profileImageView.contentMode = .scaleAspectFill
        
		// name
        nameLabel.textAlignment = .center
        nameLabel.textColor = .black
        nameLabel.font = UIFont.systemFont(ofSize: 24, weight: .regular)
        
        nameTextField.textAlignment = .center
        nameTextField.font = UIFont.systemFont(ofSize: 24, weight: .regular)
        nameTextField.backgroundColor = .white
        nameTextField.textColor = .black
        nameTextField.rightView = editNameIcon
        nameTextField.rightViewMode = .always
        
        // About me header
        header2.text = "About me"
        header2.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        header2.textColor = .black
        
        // user info "about"
        aboutLabel.font = UIFont.systemFont(ofSize: 16, weight: .light)
        aboutLabel.textColor = .black
        aboutLabel.numberOfLines = 0
        aboutLabel.lineBreakMode = .byWordWrapping
        aboutLabel.isUserInteractionEnabled = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapReadMore))
        aboutLabel.addGestureRecognizer(tapGesture)
        
        aboutTextView.layer.borderColor = UIColor.systemGray5.cgColor
        aboutTextView.layer.borderWidth = 0.5
        aboutTextView.layer.cornerRadius = 8
        aboutTextView.font = UIFont.systemFont(ofSize: 16, weight: .light)
        aboutTextView.textColor = .black
        aboutTextView.backgroundColor = .white
        aboutTextView.isEditable = true
        
    //MARK: - constraint settings
        
        let views: [UIView] = [header1, profileImageView, nameLabel, nameTextField, header2, editAboutIcon, aboutLabel, aboutTextView, backSaveButton, editButton, signOutButton]
        
        views.forEach { view in
            contentView.addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            header1.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            header1.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            profileImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            profileImageView.topAnchor.constraint(equalTo: header1.bottomAnchor, constant: 29),
            profileImageView.widthAnchor.constraint(equalToConstant: 96),
            profileImageView.heightAnchor.constraint(equalToConstant: 96),
            
            nameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            nameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 21),
            
            nameTextField.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            nameTextField.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 21),
            nameTextField.widthAnchor.constraint(equalToConstant: 200),
            
            editButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
			editButton.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 15),
            editButton.widthAnchor.constraint(equalToConstant: 200),
            
            backSaveButton.centerYAnchor.constraint(equalTo: header1.centerYAnchor),
            backSaveButton.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 25),
            backSaveButton.widthAnchor.constraint(equalToConstant: 22),
            backSaveButton.heightAnchor.constraint(equalToConstant: 22),
            
            header2.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 19),
            header2.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 154),
            
            editAboutIcon.leadingAnchor.constraint(equalTo: header2.trailingAnchor, constant: 8),
            editAboutIcon.centerYAnchor.constraint(equalTo: header2.centerYAnchor),
            editAboutIcon.heightAnchor.constraint(equalTo: header2.heightAnchor),
            editAboutIcon.widthAnchor.constraint(equalTo: header2.heightAnchor),
            
            aboutLabel.topAnchor.constraint(equalTo: header2.bottomAnchor, constant: 19),
            aboutLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 19),
            aboutLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -35),
            
            aboutTextView.topAnchor.constraint(equalTo: header2.bottomAnchor, constant: 19),
            aboutTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 19),
            aboutTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -35),
            aboutTextView.heightAnchor.constraint(equalToConstant: 300),
            
            signOutButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            signOutButton.topAnchor.constraint(equalTo: aboutLabel.bottomAnchor, constant: 100),
            signOutButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),

            contentView.bottomAnchor.constraint(equalTo: signOutButton.bottomAnchor, constant: 20)
        ])
    }
    
    @objc private func didTapReadMore() {
        delegate?.didTapReadMore()
    }
}
