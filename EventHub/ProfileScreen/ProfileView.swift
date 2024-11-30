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
    
	let profileImageView = UIImageView()
    let nameTitleLabel = UILabel()
	let aboutTitleLabel = UILabel()
    let nameTextField = UITextField()
    let aboutTextView = UITextView()
	
    let editButton = CustomButton(title: "Edit Profile", icon: .editIcon, hasBorder: true, borderColor: .accent, textColor: .accent, iconTintColor: .accent)
	
    let backSaveButton = UIButton(type: .system)
    let signOutButton = CustomButton(title: "Sign Out", icon: .signOutIcon, hasBorder: false, textColor: .black, iconTintColor: .gray)
    
    let editNameButton = UIButton()
	let editAboutButton = UIButton()
    
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
        nameTitleLabel.text = "Profile"
        nameTitleLabel.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        nameTitleLabel.textAlignment = .center
        nameTitleLabel.textColor = .black
        
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
        nameTextField.textAlignment = .center
        nameTextField.font = UIFont.systemFont(ofSize: 24, weight: .regular)
        nameTextField.backgroundColor = .white
        nameTextField.textColor = .black
        nameTextField.rightView = editNameButton
        nameTextField.rightViewMode = .always
		nameTextField.isEnabled = false
		nameTextField.tag = 1
		nameTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 22, height: 22))
		nameTextField.leftViewMode = .always
		
		editNameButton.layer.opacity = 0.0
		editNameButton.setBackgroundImage(.editIcon, for: .normal)
		editNameButton.addTarget(self, action: #selector(editNameButtonTapped), for: .touchUpInside)
		
        
        // About me
        aboutTitleLabel.text = "About me"
        aboutTitleLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        aboutTitleLabel.textColor = .black
        
        aboutTextView.layer.borderColor = UIColor.systemGray5.cgColor
        aboutTextView.layer.borderWidth = 0.5
        aboutTextView.layer.cornerRadius = 8
        aboutTextView.font = UIFont.systemFont(ofSize: 16, weight: .light)
        aboutTextView.textColor = .black
        aboutTextView.backgroundColor = .white
		aboutTextView.typingAttributes = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16, weight: .light)]
		aboutTextView.allowsEditingTextAttributes = false
		aboutTextView.isScrollEnabled = false
		
		editNameButton.layer.opacity = 0.0
		editAboutButton.setBackgroundImage(.editIcon, for: .normal)
		editAboutButton.addTarget(self, action: #selector(editAboutButtonTapped), for: .touchUpInside)
        
    //MARK: - constraint settings
        
        let views: [UIView] = [nameTitleLabel, profileImageView, nameTextField, aboutTitleLabel, editAboutButton, aboutTextView, backSaveButton, editButton, signOutButton]
        
        views.forEach { view in
            contentView.addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
        }
		
        
        NSLayoutConstraint.activate([
            nameTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            nameTitleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            profileImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            profileImageView.topAnchor.constraint(equalTo: nameTitleLabel.bottomAnchor, constant: 29),
            profileImageView.widthAnchor.constraint(equalToConstant: 96),
            profileImageView.heightAnchor.constraint(equalToConstant: 96),
            
            nameTextField.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            nameTextField.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 21),
            nameTextField.widthAnchor.constraint(equalToConstant: 200),
            
            editButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
			editButton.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 15),
            editButton.widthAnchor.constraint(equalToConstant: 200),
            
            backSaveButton.centerYAnchor.constraint(equalTo: nameTitleLabel.centerYAnchor),
            backSaveButton.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 25),
            backSaveButton.widthAnchor.constraint(equalToConstant: 22),
            backSaveButton.heightAnchor.constraint(equalToConstant: 22),
            
            aboutTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 19),
            aboutTitleLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 154),
            
            editAboutButton.leadingAnchor.constraint(equalTo: aboutTitleLabel.trailingAnchor, constant: 8),
            editAboutButton.centerYAnchor.constraint(equalTo: aboutTitleLabel.centerYAnchor),
            editAboutButton.heightAnchor.constraint(equalTo: aboutTitleLabel.heightAnchor),
            editAboutButton.widthAnchor.constraint(equalTo: aboutTitleLabel.heightAnchor),
            
           
            
            aboutTextView.topAnchor.constraint(equalTo: aboutTitleLabel.bottomAnchor, constant: 19),
            aboutTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 19),
            aboutTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -35),
            
            signOutButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
			signOutButton.topAnchor.constraint(equalTo: aboutTextView.bottomAnchor, constant: 50),
            contentView.bottomAnchor.constraint(equalTo: signOutButton.bottomAnchor, constant: 20)
        ])
    }
    
    @objc private func didTapReadMore() {
        delegate?.didTapReadMore()
    }
	
	@objc private func editNameButtonTapped() {
		nameTextField.becomeFirstResponder()
	}
	
	@objc private func editAboutButtonTapped() {
		aboutTextView.becomeFirstResponder()
	}
}

@available(iOS 17.0, *)
#Preview {
	return ProfileViewController()
	
}
