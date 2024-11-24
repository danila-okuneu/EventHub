//
//  SignupViewController.swift
//  EventHub
//
//  Created by Bakgeldi Alkhabay on 21.11.2024.
//

import UIKit
import FirebaseAuth

final class SignupViewController: UIViewController {

    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "background")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "arrow-left")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Sign up"
        label.font = UIFont.systemFont(ofSize: 24, weight: .regular)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let fullNameTextField = CustomTextField(
        type: .default,
        placeholderText: "Full name",
        icon: UIImage(systemName: "person")
    )

    private let emailTextField = CustomTextField(
        type: .email,
        placeholderText: "abc@email.com",
        icon: UIImage(systemName: "envelope")
    )

    private let passwordTextField = CustomTextField(
        type: .password,
        placeholderText: "Your password",
        icon: UIImage(systemName: "lock")
    )

    private let confirmPasswordTextField = CustomTextField(
        type: .password,
        placeholderText: "Confirm password",
        icon: UIImage(systemName: "lock")
    )

    private let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("SIGN UP", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.appPurple
        button.layer.cornerRadius = 12
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        return button
    }()

    private let signUpButtonImageView: UIImageView = {
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
        label.textColor = .gray
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

    private let alreadyHaveAccountLabel: UILabel = {
        let label = UILabel()
        label.text = "Already have an account?"
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .black
        return label
    }()

    private let signInButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Signin", for: .normal)
        button.setTitleColor(UIColor.appPurple, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
		
		setupTextFields()
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
		signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        signInButton.addTarget(self, action: #selector(signInButtonTapped), for: .touchUpInside)
    }

    private func setupUI() {
        [backgroundImageView, backButton, titleLabel, fullNameTextField, emailTextField, passwordTextField, confirmPasswordTextField, signUpButton, signUpButtonImageView, orLabel, loginWithGoogleButton, alreadyHaveAccountLabel, signInButton].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 9),
            backButton.widthAnchor.constraint(equalToConstant: 22),
            backButton.heightAnchor.constraint(equalToConstant: 22),

            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
            
            fullNameTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
            fullNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            fullNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            fullNameTextField.heightAnchor.constraint(equalToConstant: 56),

            emailTextField.topAnchor.constraint(equalTo: fullNameTextField.bottomAnchor, constant: 20),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            emailTextField.heightAnchor.constraint(equalToConstant: 56),

            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            passwordTextField.heightAnchor.constraint(equalToConstant: 56),

            confirmPasswordTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            confirmPasswordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            confirmPasswordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            confirmPasswordTextField.heightAnchor.constraint(equalToConstant: 56),

            signUpButton.topAnchor.constraint(equalTo: confirmPasswordTextField.bottomAnchor, constant: 30),
            signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signUpButton.widthAnchor.constraint(equalToConstant: 271),
            signUpButton.heightAnchor.constraint(equalToConstant: 58),

            signUpButtonImageView.trailingAnchor.constraint(equalTo: signUpButton.trailingAnchor, constant: -14),
            signUpButtonImageView.centerYAnchor.constraint(equalTo: signUpButton.centerYAnchor),
            signUpButtonImageView.widthAnchor.constraint(equalToConstant: 30),
            signUpButtonImageView.heightAnchor.constraint(equalToConstant: 30),

            orLabel.topAnchor.constraint(equalTo: signUpButton.bottomAnchor, constant: 30),
            orLabel.centerXAnchor.constraint(equalTo: signUpButton.centerXAnchor),

            loginWithGoogleButton.topAnchor.constraint(equalTo: orLabel.bottomAnchor, constant: 25),
            loginWithGoogleButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginWithGoogleButton.widthAnchor.constraint(equalToConstant: 273),
            loginWithGoogleButton.heightAnchor.constraint(equalToConstant: 56),

            alreadyHaveAccountLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -41),
            alreadyHaveAccountLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -20),

            signInButton.leadingAnchor.constraint(equalTo: alreadyHaveAccountLabel.trailingAnchor, constant: 5),
            signInButton.centerYAnchor.constraint(equalTo: alreadyHaveAccountLabel.centerYAnchor),
        ])
    }
    
    @objc private func backButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
	
	@objc private func signUpButtonTapped() {
		
		print("sign UP tapper")
		guard let name = fullNameTextField.textField.text, name != "" else { return }
		guard let email = emailTextField.textField.text, email != "" else { return }
		guard let password = passwordTextField.textField.text, password != "" else { return }
		
		Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
			guard error == nil else { return }
			
			let user = User(name: name, about: "")
//			authResult?.user.uid
		}
	
		DefaultsManager.isRegistered = true
		
		let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
		guard let window = windowScene?.keyWindow else { return }
		
		UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve) {
			window.rootViewController = CustomTabBarController()
		}
		
		
		
	}
    
    @objc private func signInButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - TextField Delegate
extension SignupViewController: UITextFieldDelegate {
	
	private func setupTextFields() {
		fullNameTextField.textField.delegate = self
		emailTextField.textField.delegate = self
		passwordTextField.textField.delegate = self
		confirmPasswordTextField.textField.delegate = self
		
		fullNameTextField.textField.tag = 1
		emailTextField.textField.tag = 2
		passwordTextField.textField.tag = 3
		confirmPasswordTextField.textField.tag = 4
	}
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		
		
		
		print("TFDelegate")
		if textField.tag == 1, textField.text == "" {
			print("false")
			return false
		}
		
		if textField.tag == 1, textField.text == "" {
			print("false")
			return false
		}

		if textField.tag == 2, textField.text?.count(where:  {$0 == "@" }) != 1 {
			return false
		}
		
		if (textField.tag == 3 || textField.tag == 4), (textField.text!.contains(" ") || textField.text!.count < 8) {
			return false
		}
		
		
		textField.endEditing(true)
		return true
	}
	
	
}

extension SignupViewController {
	
	private func register() {
		
		
		
		
	}
	
}

@available(iOS 17.0, *)
#Preview{
    return SignupViewController()
}
