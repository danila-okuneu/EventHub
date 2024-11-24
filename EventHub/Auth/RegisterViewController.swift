//
//  RegisterViewController.swift
//  EventHub
//
//  Created by Danila Okuneu on 19.11.24.
//

import UIKit
import SnapKit

final class RegisterViewController: UIViewController {
	
	// MARK: - UI Components
	private let backgroundImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.image = UIImage(named: "background")
		imageView.contentMode = .scaleAspectFill
		return imageView
	}()
	
	private let fieldVStack: UIStackView = {
		let stack = UIStackView()
		stack.axis = .vertical
		stack.distribution = .fillEqually
		stack.spacing = Constants.stackSpacing
		return stack
	}()
	
	private let nameTextField = AuthTextField(ofType: .name, placeholder: "Full name")
	private let emailTextField = AuthTextField(ofType: .email, placeholder: "abc@email.com")
	private let passwordTextfield = AuthTextField(ofType: .password, placeholder: "Your password")
	private let repeatTextField = AuthTextField(ofType: .password, placeholder: "Confirm password")
	// MARK: - Life cycle
	override func viewDidLoad() {
		super.viewDidLoad()
		
		
		setupViews()
	}
	
	// MARK: - Layout
	private func setupViews() {
		view.addSubview(backgroundImageView)
		view.addSubview(fieldVStack)
		
		makeConstraints()
		setupStack()
	}
	
	private func makeConstraints() {
		backgroundImageView.frame = view.bounds
		
		fieldVStack.snp.makeConstraints { make in
			make.center.equalToSuperview()
		}
		
		nameTextField.snp.makeConstraints { make in
			make.width.equalTo(Constants.fieldWidth)
			make.height.equalTo(Constants.fieldHeight)
		}
	}
	
	private func setupStack() {
		fieldVStack.addArrangedSubview(nameTextField)
		fieldVStack.addArrangedSubview(emailTextField)
		fieldVStack.addArrangedSubview(passwordTextfield)
		fieldVStack.addArrangedSubview(repeatTextField)
	}
	
	// MARK: - Methods
	
	
	
	
}

extension RegisterViewController {
	
	private struct Constants {
		
		static let screenHeight = UIScreen.main.bounds.height
		static let screenWidth = UIScreen.main.bounds.width
		
		static let fieldHeight = screenHeight * 56 / 812
		static let fieldWidth = screenWidth * 317 / 375
		
		static let stackSpacing = screenHeight * 19 / 812
	}
	
}


@available(iOS 17.0, *)
#Preview {
	let vc = RegisterViewController()
	return vc
	
	
}


