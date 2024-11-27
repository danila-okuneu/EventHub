//
//  ProfileViewController.swift
//  EventHub
//
//  Created by Team #1 on 15.11.24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

final class LoginViewController: UIViewController {

    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "background")
		imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "group")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "EventHub"
        label.font = UIFont.systemFont(ofSize: 35)
        label.textAlignment = .center
        return label
    }()
    
    private let signInLabel: UILabel = {
        let label = UILabel()
        label.text = "Sign in"
        label.font = UIFont.systemFont(ofSize: 24)
        label.textAlignment = .center
        return label
    }()
    
    private let emailTextField = CustomTextField(
        ofType: .email,
		with: "abc@email.com")
    
    private let passwordTextField = CustomTextField(
        ofType: .password,
        with: "Your password")
    
    private let rememberMeSwitch: UISwitch = {
        let switchControl = UISwitch()
        switchControl.onTintColor = UIColor.appPurpleDark
		switchControl.isOn = true
        switchControl.thumbTintColor = .white
        switchControl.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        return switchControl
    }()
    
    private let rememberMeLabel: UILabel = {
        let label = UILabel()
        label.text = "Remember Me"
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private let forgotPasswordButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Forgot Password?", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        return button
    }()
    
    private let signInButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("SIGN IN", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.appPurple
        button.layer.cornerRadius = 12
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        return button
    }()
    
    private let signInButtonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "buttonArrow")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let orLabel: UILabel = {
        let label = UILabel()
        label.text = "OR"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        return label
    }()
    
    private let loginWithGoogleButton: UIButton = {
        let button = UIButton(type: .system)
        
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .white
        config.baseForegroundColor = .black
        config.image = UIImage(named: "google")?.withRenderingMode(.alwaysOriginal)
        config.imagePadding = 37
        config.imagePlacement = .leading
        config.title = "Login with Google"
        
        button.configuration = config
        button.clipsToBounds = true
        button.layer.cornerRadius = 12
        
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 5)
        button.layer.shadowRadius = 4
        button.layer.shadowOpacity = 0.2
        button.layer.masksToBounds = false
        
        return button
    }()
    
    private let signUpLabel: UILabel = {
        let label = UILabel()
        label.text = "Don’t have an account?"
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    private let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign up", for: .normal)
        button.setTitleColor(.appPurple, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
		setupTags()
		signInButton.addTarget(self, action: #selector(signInButtonTapped), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
    }
    
    private func setupUI() {
        [backgroundImageView, logoImageView, titleLabel, signInLabel, emailTextField, passwordTextField, rememberMeSwitch, rememberMeLabel, forgotPasswordButton, signInButton, signInButtonImageView, orLabel, loginWithGoogleButton, signUpLabel, signUpButton].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 31),
            logoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 85),
            logoImageView.widthAnchor.constraint(equalToConstant: 55),
            logoImageView.heightAnchor.constraint(equalToConstant: 58),
            
            titleLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 8),
            titleLabel.centerXAnchor.constraint(equalTo: logoImageView.centerXAnchor),
            
            signInLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 29),
            signInLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 29),
            

            emailTextField.topAnchor.constraint(equalTo: signInLabel.bottomAnchor, constant: 22),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            emailTextField.heightAnchor.constraint(equalToConstant: 56),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            passwordTextField.heightAnchor.constraint(equalToConstant: 56),
            
            rememberMeSwitch.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 22),
            rememberMeSwitch.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor),
            
            rememberMeLabel.centerYAnchor.constraint(equalTo: rememberMeSwitch.centerYAnchor),
            rememberMeLabel.leadingAnchor.constraint(equalTo: rememberMeSwitch.trailingAnchor, constant: 20),
            
            forgotPasswordButton.centerYAnchor.constraint(equalTo: rememberMeSwitch.centerYAnchor),
            forgotPasswordButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            signInButton.topAnchor.constraint(equalTo: rememberMeSwitch.bottomAnchor, constant: 30),
            signInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signInButton.widthAnchor.constraint(equalToConstant: 271),
            signInButton.heightAnchor.constraint(equalToConstant: 58),
            
            signInButtonImageView.trailingAnchor.constraint(equalTo: signInButton.trailingAnchor, constant: -14),
            signInButtonImageView.centerYAnchor.constraint(equalTo: signInButton.centerYAnchor),
            signInButtonImageView.widthAnchor.constraint(equalToConstant: 30),
            signInButtonImageView.heightAnchor.constraint(equalToConstant: 30),
            
            orLabel.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 30),
            orLabel.centerXAnchor.constraint(equalTo: signInButton.centerXAnchor),
            
            loginWithGoogleButton.topAnchor.constraint(equalTo: orLabel.bottomAnchor, constant: 25),
            loginWithGoogleButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginWithGoogleButton.widthAnchor.constraint(equalToConstant: 273),
            loginWithGoogleButton.heightAnchor.constraint(equalToConstant: 56),
            
            signUpLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -41),
            signUpLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -20),
            
            signUpButton.leadingAnchor.constraint(equalTo: signUpLabel.trailingAnchor, constant: 5),
            signUpButton.centerYAnchor.constraint(equalTo: signUpLabel.centerYAnchor),
        ])
    }
    
	@objc private func signInButtonTapped() {
		
		guard let email = emailTextField.textField.text, email != "" else { emailTextField.showErrorAnimation(); return }
		guard let password = passwordTextField.textField.text, password != "" else { passwordTextField.showErrorAnimation(); return }
		
		
		
		DefaultsManager.isRemembered = rememberMeSwitch.isOn
		Task {
			do {
				let authResult = try await Auth.auth().signIn(withEmail: email, password: password)
				try await FirestoreService.fetchUserData(uid: authResult.user.uid)
				
				let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
				if let window = windowScene?.keyWindow {
					
					UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve) {
						window.rootViewController = CustomTabBarController()
					}
				}
			} catch {
				
				switch error.localizedDescription {
				case "The email address is badly formatted.":
					emailTextField.showErrorAnimation()
				default:					passwordTextField.showErrorAnimation()
				}				
			}
		}
		
		
	}
	
    @objc private func signUpButtonTapped() {
        let signupVC = SignupViewController()
        signupVC.modalPresentationStyle = .fullScreen
        present(signupVC, animated: true, completion: nil)
    }
}



// MARK: - TextField Delegate
extension LoginViewController: UITextFieldDelegate {

	func textFieldDidBeginEditing(_ textField: UITextField) {
		
		switch textField.tag {
		case 1:
			emailTextField.resetFieldColor()
		default:
			passwordTextField.resetFieldColor()
		}
			
		
		
	}
	
	private func setupTags() {
		
		emailTextField.tag = 1
		passwordTextField.tag = 2
		
		emailTextField.textField.tag = 1
		passwordTextField.textField.tag = 2
		
		emailTextField.textField.delegate = self
		passwordTextField.textField.delegate = self
		
	}
	
}

@available(iOS 17.0, *)
#Preview {
    return LoginViewController()
}
