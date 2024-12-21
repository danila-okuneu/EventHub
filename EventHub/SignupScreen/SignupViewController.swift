//
//  SignupViewController.swift
//  EventHub
//
//  Created by Bakgeldi Alkhabay on 21.11.2024.
//

import UIKit
import FirebaseAuth
import FirebaseCore
import GoogleSignIn

final class SignupViewController: UIViewController {

    // MARK: - Properties
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "background")
		imageView.contentMode = .scaleAspectFill
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
        ofType: .default,
        with: "Full name")

    private let emailTextField = CustomTextField(
        ofType: .email,
		with: "abc@email.com")

    private let passwordTextField = CustomTextField(
        ofType: .password,
        with: "Your password")

    private let confirmPasswordTextField = CustomTextField(
        ofType: .password,
        with: "Confirm password")

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

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
		
		setupTextFields()
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
		signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        signInButton.addTarget(self, action: #selector(signInButtonTapped), for: .touchUpInside)
		loginWithGoogleButton.addTarget(self, action: #selector(googleSignInTapped), for: .touchUpInside)
    }

    // MARK: - Setup UI
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
    
    // MARK: - Functions
    
    @objc private func backButtonTapped() {
        navigateToLoginViewController()
    }
	
    private func navigateToLoginViewController() {
        let windowScene = UIApplication.shared.connectedScenes.first as! UIWindowScene
        guard let window = windowScene.keyWindow else { return }
        

        UIView.transition(with: window, duration: 0.4, options: .transitionCrossDissolve) {
            window.rootViewController = LoginViewController()
        }
    }
    
	@objc private func signUpButtonTapped() {
		
		print("sign UP tapper")
        guard let name = fullNameTextField.text, !name.isEmpty else {
            fullNameTextField.showErrorAnimation()
            return
        }
        guard let email = emailTextField.text, !email.isEmpty, email.contains("@") else {
            emailTextField.showErrorAnimation()
            return
        }
        guard let password = passwordTextField.text,
              !password.isEmpty, password.count >= 8, !password.contains(" ") else {
            passwordTextField.showErrorAnimation()
            return
        }
        guard let confirmPassword = confirmPasswordTextField.text, confirmPassword == password else {
            confirmPasswordTextField.showErrorAnimation()
            return
        }
		
		Task {
			do {
				let authResult = try await Auth.auth().createUser(withEmail: email, password: password)
				let user = User(uid: authResult.user.uid, name: name)
				DefaultsManager.currentUser = user
				FirestoreService.saveUserData(user: user, uid: authResult.user.uid)
				
				
				DefaultsManager.isRegistered = true
				
				let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
				guard let window = windowScene?.keyWindow else { return }
				
				UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve) {
					window.rootViewController = CustomTabBarController()
				}
				
			} catch {
				print("error")
			}
		}
	}
	
	
	private func signInWithGoogle() async {
		
		guard let clientID = FirebaseApp.app()?.options.clientID else {
			fatalError("ID not found")
		}
		print(clientID)
		
		let config = GIDConfiguration(clientID: clientID)
		GIDSignIn.sharedInstance.configuration = config
		
		guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
			  let window = windowScene.keyWindow,
			  let rootViewController = window.rootViewController else {
			print("There is no root VCs")
			return
		}
		
		do {
			let userAuthentication = try await GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController)
			let userAuth = userAuthentication.user
			guard let idToken = userAuth.idToken else {
				print("ID token not recieved")
				return
			}
			let accessToken = userAuth.accessToken
			let creditional = GoogleAuthProvider.credential(withIDToken: idToken.tokenString, accessToken: accessToken.tokenString)
			
			
			let result = try await Auth.auth().signIn(with: creditional)
			
			let user = User(uid: result.user.uid)
			DefaultsManager.currentUser = user
			FirestoreService.saveUserData(user: user, uid: result.user.uid)
			
			DefaultsManager.isRegistered = true
			
			let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
			guard let window = windowScene?.keyWindow else { return }
			
			UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve) {
				window.rootViewController = CustomTabBarController()
			}
			
		} catch {
			print(error.localizedDescription)
			return
		}
	}
	
	@objc private func googleSignInTapped() {
		
		Task {
			await signInWithGoogle()
		}
		
	}
	
    @objc private func signInButtonTapped() {
        navigateToLoginViewController()
    }
}

// MARK: - TextField Delegate
extension SignupViewController: UITextFieldDelegate {
    
    private func setupTextFields() {
        fullNameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        confirmPasswordTextField.delegate = self
        
        fullNameTextField.tag = 1
        emailTextField.tag = 2
        passwordTextField.tag = 3
        confirmPasswordTextField.tag = 4
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField.tag {
        case 1 where textField.text == "":
            (textField as? CustomTextField)?.showError()
        case 2 where textField.text?.count(where: { $0 == "@" }) != 1:
            (textField as? CustomTextField)?.showError()
        case 3 where textField.text!.count < 8 || textField.text!.contains(" "):
            (textField as? CustomTextField)?.showError()
        case 4 where textField.text != passwordTextField.text:
            (textField as? CustomTextField)?.showError()
        default:
            return
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField.tag {
        case 1:
            fullNameTextField.resetFieldColor()
        case 2:
            emailTextField.resetFieldColor()
        case 3:
            passwordTextField.resetFieldColor()
        default:
            confirmPasswordTextField.resetFieldColor()
            
        }
    }
    
}

// MARK: - Preview
@available(iOS 17.0, *)
#Preview{
    return SignupViewController()
}


