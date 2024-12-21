//
//  CustomTextField.swift
//  EventHub
//
//  Created by Bakgeldi Alkhabay on 21.11.2024.
//

import UIKit

final class CustomTextField: UITextField {
    
    enum FieldType {
        case email
        case password
        case `default`
    }
    
    private let leftImageView = UIImageView()
    private var toggleButton: UIButton?
    
    private let textFieldHeight: CGFloat = 56
    private let cornerRadius: CGFloat = 12
    
    init(ofType type: FieldType, with placeholderText: String) {
        super.init(frame: .zero)
        
        setupTextField()
        configureTextField(with: type)
        
        leftImageView.tintColor = .authGrayTint
        leftImageView.contentMode = .scaleAspectFit
        leftImageView.translatesAutoresizingMaskIntoConstraints = false
        leftView = leftImageView
        leftViewMode = .always
        
        self.placeholder = placeholderText
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTextField() {
        layer.cornerRadius = cornerRadius
        layer.borderWidth = 1
        layer.borderColor = UIColor.authBorderGray.cgColor
        font = UIFont.systemFont(ofSize: 14)
        autocapitalizationType = .none
        backgroundColor = .white
        heightAnchor.constraint(equalToConstant: textFieldHeight).isActive = true
    }
    
    private func configureTextField(with type: FieldType) {
        switch type {
        case .email:
            keyboardType = .emailAddress
            spellCheckingType = .no
            autocorrectionType = .no
            textContentType = .emailAddress
            leftImageView.image = .authEnvelope.withRenderingMode(.alwaysTemplate)
            
        case .password:
            keyboardType = .asciiCapable
            isSecureTextEntry = true
            textContentType = .password
            leftImageView.image = .authPassword.withRenderingMode(.alwaysTemplate)
            setupPasswordToggle()
            
        case .default:
            autocapitalizationType = .words
            textContentType = .name
            leftImageView.image = .authProfile.withRenderingMode(.alwaysTemplate)
        }
    }
    
    private func setupPasswordToggle() {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
        button.tintColor = .authGrayTint
        button.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        rightView = button
        rightViewMode = .always
        toggleButton = button
    }
    
    func showErrorAnimation() {
        layer.borderColor = UIColor.appRed.cgColor
        let shakeAnimation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        shakeAnimation.timingFunction = CAMediaTimingFunction(name: .linear)
        shakeAnimation.duration = 0.6
        shakeAnimation.values = [-10, 10, -8, 8, -5, 5, 0]
        
        leftImageView.tintColor = .appRed
        layer.add(shakeAnimation, forKey: "shake")
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
        isSecureTextEntry.toggle()
        let imageName = isSecureTextEntry ? "eye.slash.fill" : "eye.fill"
        toggleButton?.setImage(UIImage(systemName: imageName), for: .normal)
    }
}

