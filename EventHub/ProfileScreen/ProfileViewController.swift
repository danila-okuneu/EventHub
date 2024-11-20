//
//  ProfileViewController.swift
//  EventHub
//
//  Created by Team #1 on 15.11.24.
//

import UIKit

class ProfileViewController: UIViewController, ProfileViewDelegate {
    
    // mock user
    var user: User = User(
        name: "Ashfak Sayem",
        profileImage: UIImage(named: "photoProfile"),
        about: "I am passionate about exploring the world through art, music, and storytelling, always seeking new experiences that inspire creativity and personal growth. I am passionate about exploring the world through art, music, and storytelling, always seeking new experiences that inspire creativity and personal growth. I am passionate about exploring the world through art, music, and storytelling, always seeking new experiences that inspire creativity and personal growth. I am passionate about exploring the world through art, music, and storytelling, always seeking new experiences that inspire creativity and personal growth."
    )
    
    private var profileView: ProfileView {
        return view as! ProfileView
    }
    
    var profileMode: ProfileMode = .view
    
    override func loadView() {
        view = ProfileView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        profileView.delegate = self
        setupActions()
        updateUI()
		profileView.nameTextField.delegate = self
    }
    
    private func setupActions() {
        profileView.editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        profileView.saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        profileView.signOutButton.addTarget(self, action: #selector(signOutButtonTapped), for: .touchUpInside)
		profileView.editIcon2.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(editBioTapped)))
		profileView.editIcon2.isUserInteractionEnabled = true
    }
    
    private func updateUI() {
        switch profileMode {
        case .view:
            // Показать текстовые метки / скрыть текстовые поля
            profileView.header1.isHidden = false
            
            profileView.profileImageView.image = user.profileImage
            profileView.profileImageView.isHidden = false
		
            profileView.header2.isHidden = false
            
            let truncatedText = (user.about as NSString).substring(to: 150) + "..."
            profileView.aboutLabel.text = truncatedText
            profileView.aboutLabel.isHidden = false
            profileView.readMoreButton.isHidden = false
            
            profileView.editButton.isHidden = false
            profileView.signOutButton.isHidden = false
            
            profileView.editIcon.isHidden = true
			profileView.editIcon2.isHidden = true
            profileView.aboutTextView.isHidden = true
			profileView.nameTextField.text = user.name
			profileView.nameTextField.isEnabled = false
            profileView.saveButton.isHidden = true
            
        case .edit:
            // Показать текстовые поля / скрыть метки
            profileView.header1.isHidden = false
            profileView.profileImageView.image = user.profileImage
            profileView.profileImageView.isHidden = false
		
            
			profileView.nameTextField.isEnabled = true
            profileView.saveButton.isHidden = false
            
            profileView.header2.isHidden = false
            profileView.editIcon.isHidden = false
			profileView.editIcon2.isHidden = false
            profileView.aboutTextView.text = user.about
            profileView.aboutTextView.isHidden = false
            
            profileView.aboutLabel.isHidden = true
            profileView.readMoreButton.isHidden = true
            profileView.editButton.isHidden = true
            profileView.signOutButton.isHidden = true
        }
    }
    
    @objc private func showFullText() {
        profileView.aboutLabel.text = user.about
        profileView.readMoreButton.isHidden = true
    }
    
    // change mode -> edit
    @objc private func editButtonTapped() {
        profileMode = .edit
        updateUI()
    }
    
    // change mode -> view
    @objc private func saveButtonTapped() {
        // save changes to the model
        user.name = profileView.nameTextField.text ?? user.name
        user.about = profileView.aboutTextView.text ?? user.about
        
        profileMode = .view
        updateUI()
    }
	
	@objc private func editBioTapped() {
		
		profileView.aboutTextView.becomeFirstResponder()
	}
    
    func didTapReadMore() {
        profileView.aboutLabel.text = user.about
        profileView.readMoreButton.isHidden = true
    }
    
    @objc private func signOutButtonTapped() {
    }
}


// MARK: - TextField Delegate
extension ProfileViewController: UITextFieldDelegate {
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		true
	}

	func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
		true
	}
	
}
