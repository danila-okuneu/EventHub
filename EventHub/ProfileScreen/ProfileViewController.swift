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
    }
    
    private func setupActions() {
        profileView.editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        profileView.saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        profileView.signOutButton.addTarget(self, action: #selector(signOutButtonTapped), for: .touchUpInside)
    }
    
    private func updateUI() {
        switch profileMode {
        case .view:
            // Показать текстовые метки / скрыть текстовые поля
            profileView.header1.isHidden = false
            
            profileView.profileImageView.image = user.profileImage
            profileView.profileImageView.isHidden = false
            
            profileView.nameLabel.text = user.name.isEmpty ? "No Name" : user.name
            profileView.nameLabel.isHidden = false
            
            profileView.header2.isHidden = false
            
            let truncatedText = (user.about as NSString).substring(to: 150) + "..."
            profileView.aboutLabel.text = truncatedText
            profileView.aboutLabel.isHidden = false
            profileView.readMoreButton.isHidden = false
            
            profileView.editButton.isHidden = false
            profileView.signOutButton.isHidden = false
            
            profileView.editIcon.isHidden = true
            profileView.aboutTextView.isHidden = true
            profileView.nameTextField.isHidden = true
            profileView.saveButton.isHidden = true
            
        case .edit:
            // Показать текстовые поля / скрыть метки
            profileView.header1.isHidden = false
            profileView.profileImageView.image = user.profileImage
            profileView.profileImageView.isHidden = false
            
            profileView.nameTextField.text = user.name
            profileView.nameTextField.isHidden = false
            profileView.saveButton.isHidden = false
            
            profileView.header2.isHidden = false
            profileView.editIcon.isHidden = false
            profileView.aboutTextView.text = user.about
            profileView.aboutTextView.isHidden = false
            
            profileView.nameLabel.isHidden = true
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
    
    func didTapReadMore() {
        profileView.aboutLabel.text = user.about
        profileView.readMoreButton.isHidden = true
    }
    
    @objc private func signOutButtonTapped() {
    }
}
