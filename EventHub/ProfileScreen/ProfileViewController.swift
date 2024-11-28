//
//  ProfileViewController.swift
//  EventHub
//
//  Created by Team #1 on 15.11.24.
//

import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController, ProfileViewDelegate {
    
	var user: User! = DefaultsManager.currentUser
	
	var profileMode: ProfileMode = .view

	var nameTextField: UITextField!
    var aboutTextView: UITextView!
    
    private var profileView: ProfileView {
        return view as! ProfileView
    }
    
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
		aboutTextView.addGestureRecognizer(readMoreGesture)
    }
    
    private func updateUI() {
        
        // Назначаем делегаты для текстовых полей
        nameTextField.delegate = self
		aboutTextView.delegate = self
        
        // Добавляем жест для скрытия клавиатуры
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
		
		profileView.nameTextField.text = user.name
		profileView.aboutTextView.text = user.about
		
        if profileMode == .view {
            // using mock data
			self.profileView.nameTextField.isEnabled = false
			
			UIView.animate(withDuration: 0.3) {
				self.profileView.editButton.layer.opacity = 1.0
				self.profileView.backSaveButton.layer.opacity = 0.0
				self.profileView.editNameButton.layer.opacity = 0.0
				self.profileView.editAboutButton.layer.opacity = 0.0
			}
			
			profileView.profileImageView.image = user.profileImage
            setupAboutLabel(with: user.about ?? "")
            
      
        } else {
			
			self.profileView.nameTextField.isEnabled = true
			
			UIView.animate(withDuration: 0.3) {
				self.profileView.editButton.layer.opacity = 0.0
				self.profileView.backSaveButton.layer.opacity = 1.0
				self.profileView.editNameButton.layer.opacity = 1.0
				self.profileView.editAboutButton.layer.opacity = 1.0
			}

			aboutTextView.attributedText = NSMutableAttributedString(string: user.about ?? "", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .light)])
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
		
		guard text.count > 150 else {
			profileView.aboutTextView.text = text
			return
		}
		
        let maxLength = 150
        var truncatedText = String(text.prefix(maxLength))
        
        if let lastSpaceIndex = truncatedText.range(of: " ", options: .backwards)?.lowerBound {
            truncatedText = String(truncatedText[..<lastSpaceIndex])
        }
        
		truncatedText.append("...")
        
        let fullText = truncatedText + " Read more"
        
		let attributedString = NSMutableAttributedString(string: fullText, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .light)])
        let readMoreRange = (fullText as NSString).range(of: "Read more")
        attributedString.addAttribute(.foregroundColor, value: UIColor.accent, range: readMoreRange)
		
        
		profileView.aboutTextView.attributedText = attributedString
		profileView.aboutTextView.isUserInteractionEnabled = true
    }
    
    @objc func didTapReadMore() {
        profileMode = .view
		
		aboutTextView.attributedText = NSAttributedString(string: user.about ?? "")
    }
    
    @objc private func signOutButtonTapped() {
        
		
		do {
			try Auth.auth().signOut()
			DefaultsManager.currentUser = nil
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
extension ProfileViewController: UITextFieldDelegate {

	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		textField.resignFirstResponder()
		
		
		return true
	}
	
	func textFieldDidEndEditing(_ textField: UITextField) {
		guard let uid = Auth.auth().currentUser?.uid else { return }
		Task {
			try? await FirestoreService.changeName(forUserWith: uid, to: textField.text ?? "Unknown")
			textField.text = user.name
		}
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

// MARK: - TextView Delegate
extension ProfileViewController: UITextViewDelegate {
	
	func textViewDidEndEditing(_ textView: UITextView) {
		guard let uid = Auth.auth().currentUser?.uid else { return }
		
		Task {
			try? await FirestoreService.changeAbout(forUserWith: uid, to: textView.text)
			UIView.transition(with: textView, duration: 0.3, options: [.transitionCrossDissolve]) {
				textView.text = self.user.about
			}
		}
		
	}
	
}


// MARK: - User handlers
