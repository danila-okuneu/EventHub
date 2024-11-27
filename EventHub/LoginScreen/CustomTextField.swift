//
//  CustomTextField.swift
//  EventHub
//
//  Created by Bakgeldi Alkhabay on 21.11.2024.
//

import UIKit

class CustomTextField: UIView {
    
    enum FieldType {
        case email
        case password
        case `default`
    }
    
	let textField = UITextField()
    private let leftImageView = UIImageView()
    private var toggleButton: UIButton?
    
    private let textFieldHeight: CGFloat = 56
    private let cornerRadius: CGFloat = 12
    
	init(ofType type: FieldType, with placeholderText: String) {
        super.init(frame: .zero)
		
        setupView()
		configureTextField(with: type)
		leftImageView.tintColor = .authGrayTint
        leftImageView.contentMode = .scaleAspectFit
        leftImageView.translatesAutoresizingMaskIntoConstraints = false
        
        textField.placeholder = placeholderText
        textField.borderStyle = .none
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.autocapitalizationType = .none
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(leftImageView)
        addSubview(textField)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
	
	private func configureTextField(with type: FieldType) {
		switch type {
		case .email:
			textField.keyboardType = .emailAddress
			textField.autocapitalizationType = .none
			textField.spellCheckingType = .no
			textField.autocorrectionType = .no
			textField.textContentType = .emailAddress
			leftImageView.image = .authEnvelope.withRenderingMode(.alwaysTemplate)
			
		case .password:
			textField.keyboardType = .asciiCapable
			textField.isSecureTextEntry = true
			textField.textContentType = .password
			leftImageView.image = .authPassword.withRenderingMode(.alwaysTemplate)
			setupPasswordToggle()
			
		case .default:
			textField.autocapitalizationType = .words
			textField.textContentType = .name
			leftImageView.image = .authProfile.withRenderingMode(.alwaysTemplate)
		}
		
	}
    
    private func setupView() {
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = 1
		self.layer.borderColor = UIColor.authBorderGray.cgColor
        self.backgroundColor = .white
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalToConstant: textFieldHeight).isActive = true
    }
    
    private func setupPasswordToggle() {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
		button.tintColor = .authGrayTint
        button.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        addSubview(button)
        toggleButton = button
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            leftImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            leftImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            leftImageView.widthAnchor.constraint(equalToConstant: 22),
            leftImageView.heightAnchor.constraint(equalToConstant: 22),
        ])
        
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: leftImageView.trailingAnchor, constant: 14),
            textField.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            textField.widthAnchor.constraint(equalToConstant: 220),
        ])
        
        if let button = toggleButton {
            NSLayoutConstraint.activate([
                button.leadingAnchor.constraint(equalTo: textField.trailingAnchor, constant: 6),
                button.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
                button.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                button.widthAnchor.constraint(equalToConstant: 24),
                button.heightAnchor.constraint(equalToConstant: 24),
            ])
        } else {
            NSLayoutConstraint.activate([
                textField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            ])
        }
    }
	
	func showErrorAnimation() {
		
		self.layer.borderColor = UIColor.appRed.cgColor
		let shakeAnimation = CAKeyframeAnimation(keyPath: "transform.translation.x")
		shakeAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
		shakeAnimation.duration = 0.6
		shakeAnimation.values = [-10, 10, -8, 8, -5, 5, 0]
		
		self.leftImageView.tintColor = .appRed
		self.layer.add(shakeAnimation, forKey: "shake")
	}
	
	func showError() {
		UIView.animate(withDuration: 0.15) {
			self.layer.borderColor = UIColor.appRed.cgColor
		}
	}
	
	func resetFieldColor() {
		UIView.animate(withDuration: 0.3) {
			self.layer.borderColor = UIColor.authBorderGray.cgColor
			self.leftImageView.tintColor = .authGrayTint
		}
	}
    
    @objc private func togglePasswordVisibility() {
        textField.isSecureTextEntry.toggle()
        let imageName = textField.isSecureTextEntry ? "eye.slash.fill" : "eye.fill"
        toggleButton?.setImage(UIImage(systemName: imageName), for: .normal)
    }
}
