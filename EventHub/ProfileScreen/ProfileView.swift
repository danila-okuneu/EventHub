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
    let readMoreButton = UIButton()
    let aboutTextView = UITextView()
    
    let editButton = CustomButton(title: "Edit Profile", icon: .editIcon, hasBorder: true, borderColor: .accent, textColor: .accent, iconTintColor: .accent)
    let saveButton = CustomButton(title: "Save", icon: nil)
    let signOutButton = CustomButton(title: "Sign Out", icon: .signOutIcon, hasBorder: false, textColor: .black, iconTintColor: .gray)
    
    let editIcon = UIImageView(image: .editIcon)
    
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
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.topAnchor),
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
        
        // photo
        profileImageView.image = UIImage(named: "person.circle")
        profileImageView.layer.cornerRadius = 50
        profileImageView.clipsToBounds = true
        profileImageView.contentMode = .scaleAspectFill
        
        // name
        nameLabel.textAlignment = .center
        nameLabel.font = UIFont.systemFont(ofSize: 24, weight: .regular)
        nameLabel.textColor = .black
        
        nameTextField.textAlignment = .center
        nameTextField.font = UIFont.systemFont(ofSize: 24, weight: .regular)
        nameTextField.backgroundColor = .white
        nameTextField.textColor = .black
        nameTextField.rightView = editIcon
        nameTextField.rightViewMode = .always
        
        // About me header
        header2.text = "About me"
        header2.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        header2.textColor = .black
        
        editIcon.tintColor = .accent
        
        // user info "about"
        aboutLabel.layer.borderColor = UIColor.lightGray.cgColor
        aboutLabel.font = UIFont.systemFont(ofSize: 16, weight: .light)
        aboutLabel.textColor = .black
        aboutLabel.backgroundColor = .white
        aboutLabel.numberOfLines = 0
        aboutLabel.lineBreakMode = .byTruncatingTail
        
        // Настройка кнопки READ MORE
        readMoreButton.setTitle("Read more", for: .normal)
        readMoreButton.setTitleColor(.accent, for: .normal)
        readMoreButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .light)
        readMoreButton.isHidden = false
        readMoreButton.addTarget(self, action: #selector(readMoreTapped), for: .touchUpInside)
        
        aboutTextView.layer.borderColor = UIColor.systemGray5.cgColor
        aboutTextView.layer.borderWidth = 0.5
        aboutTextView.layer.cornerRadius = 8
        aboutTextView.font = UIFont.systemFont(ofSize: 16, weight: .light)
        aboutTextView.textColor = .black
        aboutTextView.backgroundColor = .white
        aboutTextView.isEditable = true
        
    //MARK: - constraint settings
        
        let views: [UIView] = [header1, profileImageView, nameLabel, nameTextField, header2, editIcon, aboutLabel, readMoreButton, aboutTextView, saveButton, editButton, signOutButton]
        
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
            editButton.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 15),
            editButton.widthAnchor.constraint(equalToConstant: 200),
            
            saveButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            saveButton.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 15),
            saveButton.widthAnchor.constraint(equalToConstant: 200),
            
            header2.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 19),
            header2.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 154),
            
            editIcon.leadingAnchor.constraint(equalTo: header2.trailingAnchor, constant: 8),
            editIcon.centerYAnchor.constraint(equalTo: header2.centerYAnchor),
            
            aboutLabel.topAnchor.constraint(equalTo: header2.bottomAnchor, constant: 35),
            aboutLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 19),
            aboutLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -35),
            
            readMoreButton.topAnchor.constraint(equalTo: aboutLabel.bottomAnchor, constant: 8),
            readMoreButton.leadingAnchor.constraint(equalTo: aboutLabel.leadingAnchor),
            
            aboutTextView.topAnchor.constraint(equalTo: header2.bottomAnchor, constant: 35),
            aboutTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 19),
            aboutTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -35),
            aboutTextView.heightAnchor.constraint(equalToConstant: 300),
            
            signOutButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            signOutButton.topAnchor.constraint(equalTo: aboutLabel.bottomAnchor, constant: 150),
            signOutButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),

        ])
    }
    
    @objc private func readMoreTapped() {
        delegate?.didTapReadMore()
    }
}
