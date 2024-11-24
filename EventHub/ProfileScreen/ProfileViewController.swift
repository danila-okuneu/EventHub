//
//  ProfileViewController.swift
//  EventHub
//
//  Created by Team #1 on 15.11.24.
//

import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController, ProfileViewDelegate {
    
    var nameTextField: UITextField!
    var aboutTextView: UITextView!
    
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
        nameTextField = profileView.nameTextField
        aboutTextView = profileView.aboutTextView
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
        profileView.backSaveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        profileView.signOutButton.addTarget(self, action: #selector(signOutButtonTapped), for: .touchUpInside)
        
        let readMoreGesture = UITapGestureRecognizer(target: self, action: #selector(didTapReadMore))
        profileView.aboutLabel.addGestureRecognizer(readMoreGesture)
    }
    
    private func updateUI() {
        
        // Назначаем делегаты для текстовых полей
        nameTextField.delegate = self
        aboutTextView.delegate = self
        
        // Добавляем жест для скрытия клавиатуры
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        let commonElements: [UIView] = [profileView.header1, profileView.profileImageView, profileView.header2]
        let viewModeElements: [UIView] = [profileView.nameLabel, profileView.aboutLabel, profileView.editButton, profileView.signOutButton]
        let editModeElements: [UIView] = [profileView.nameTextField, profileView.aboutTextView, profileView.backSaveButton, profileView.editAboutIcon]
        
        // Set visibility based on mode
        commonElements.forEach { $0.isHidden = false }
        
        if profileMode == .view {
            // using mock data
            profileView.profileImageView.image = user.profileImage
            profileView.nameLabel.text = user.name
            setupAboutLabel(with: user.about)
            
            viewModeElements.forEach { $0.isHidden = false }
            editModeElements.forEach { $0.isHidden = true }
        } else {
            // using mock data
            profileView.nameTextField.text = user.name
            profileView.aboutTextView.text = user.about
            
            editModeElements.forEach { $0.isHidden = false }
            viewModeElements.forEach { $0.isHidden = true }
        }
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
    
    //setup "read more" button
    func setupAboutLabel(with text: String) {
        let maxLength = 150
        var truncatedText = String(text.prefix(maxLength))
        
        if let lastSpaceIndex = truncatedText.range(of: " ", options: .backwards)?.lowerBound {
            truncatedText = String(truncatedText[..<lastSpaceIndex])
        }
        
        truncatedText += "..."
        
        let fullText = truncatedText + " Read more"
        
        let attributedString = NSMutableAttributedString(string: fullText)
        let readMoreRange = (fullText as NSString).range(of: "Read more")
        attributedString.addAttribute(.foregroundColor, value: UIColor.accent, range: readMoreRange)
        
        profileView.aboutLabel.attributedText = attributedString
        profileView.aboutLabel.isUserInteractionEnabled = true
    }
    
    @objc func didTapReadMore() {
        profileMode = .view
        profileView.aboutLabel.text = user.about
    }
    
    @objc private func signOutButtonTapped() {
        
		
		do {
			try Auth.auth().signOut()
		} catch {
			print(error.localizedDescription)
			return
		}
		
		let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
		guard let window = windowScene?.keyWindow else { return }
		
		UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve) {
			window.rootViewController = LoginViewController()
		}

    }
}

@available(iOS 17.0, *)
#Preview {
    ProfileViewController()
}

// MARK: - TextField Delegate
extension ProfileViewController: UITextFieldDelegate, UITextViewDelegate {
    
    // Обработка событий для nameTextField
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    // Обработка событий для aboutTextView
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        return true
    }
    
    // Закрытие клавиатуры при нажатии на экран
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
