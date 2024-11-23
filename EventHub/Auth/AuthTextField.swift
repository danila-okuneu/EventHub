//
//  AuthTextFieldExtension.swift
//  EventHub
//
//  Created by Danila Okuneu on 19.11.24.
//

import UIKit
import SnapKit

final class AuthTextField: UITextField {
	
	
	
	
	
	// MARK: - Life cycle
	init(ofType type: FieldType, placeholder: String) {
		super.init(frame: .zero)
		self.placeholder = placeholder
		
		setupTextField()
		configure(as: type)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	// MARK: - Methods
	
	private func setupTextField() {
		layer.cornerRadius = Constants.cornerRadius
		layer.borderWidth = Constants.borderWidth
		layer.borderColor = UIColor.fieldBorderGray.cgColor
		
		font = .cerealFont(ofSize: Constants.fontSize)
		textColor = .authText
	}
	
	private func configure(as fieldType: FieldType) {
		
		
		let leftImageView = UIImageView()
		let leftImageContainer = UIView()
		

		leftImageContainer.addSubview(leftImageView)
		
		
		let containerWidth = Constants.imageSize + Constants.imageXInset * 2
		let containerHeight = Constants.imageSize + Constants.imageYInset * 2
		leftImageContainer.frame.size = CGSize(width: containerWidth, height: containerHeight)
		leftImageView.frame.size = CGSize(width: Constants.imageSize, height: Constants.imageSize)
		leftImageView.center = leftImageContainer.center
		
		
		
		
		
		leftImageView.contentMode = .scaleAspectFit
		
		
		leftView = leftImageContainer
		leftViewMode = .always
		
		switch fieldType {
		case .name:
			leftImageView.image = UIImage(named: "authProfile")
			keyboardType = .namePhonePad
		case .email:
			leftImageView.image = UIImage(named: "authEnvelope")
			keyboardType = .emailAddress
		case .password:
			leftImageView.image = UIImage(named: "authPassword")
			isSecureTextEntry = true
			
			let rightImageView = UIImageView()
			rightImageView.contentMode = .scaleAspectFit
			rightImageView.image = UIImage(systemName: "eye.slash.fill")
			let rightImageContainer = UIView()
			rightImageContainer.addSubview(rightImageView)
			rightImageView.frame = leftImageView.frame
			rightImageContainer.frame = leftImageContainer.frame
			
			rightView = rightImageContainer
			rightViewMode = .always
			
		}
		
	}
	
}


extension AuthTextField {
	
	enum FieldType {
		case name
		case email
		case password
	}
	
	private struct Constants {
		
		static let screenHeight = UIScreen.main.bounds.height
		static let screenWidth = UIScreen.main.bounds.width
		
		static let cornerRadius = screenHeight * 12 / 812
		static let borderWidth = screenWidth * 1 / 812
		
		static let imageSize = screenHeight * 22 / 812
		static let imageYInset = screenHeight * 17 / 812
		static let imageXInset = screenHeight * 15 / 812
		
		static let fontSize = screenHeight * 14 / 812
		
	}
	
}


