//
//  SplashViewController.swift
//  EventHub
//
//  Created by Danila Okuneu on 24.11.24.
//

import UIKit
import SnapKit
import FirebaseAuth

final class SplashViewController: UIViewController {
	
	private let backgroundImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.contentMode = .scaleAspectFill
		imageView.image = .background
		return imageView
	}()
	
	private let logoImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.contentMode = .scaleAspectFit
		imageView.image = .logo
		return imageView
	}()

	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupViews()
		animateLogo()
		Task {
			await loadUserData()
			transitionVCs()
		}
	}
	
	
	// MARK: - Layout
	private func setupViews() {
		view.addSubview(backgroundImageView)
		view.addSubview(logoImageView)
		
		backgroundImageView.frame = view!.bounds
		makeConstraints()
		
		Task {
			await loadUserData()
			
			
			
		}
	}
	
	private func makeConstraints() {
		
		logoImageView.snp.makeConstraints { make in
			make.center.equalToSuperview()
			make.height.equalToSuperview().multipliedBy(0.1)
		}
	}
	
	// MARK: - Methods
	private func animateLogo() {
		
		if Auth.auth().currentUser == nil { return }
		
		UIView.animate(withDuration: 0.75, delay: 0, options: [.autoreverse, .repeat, .curveEaseOut]) {
			self.logoImageView.layer.opacity = 0.4
		}
		
	}
	
	private func transitionVCs() {
		
		
		let windowScene = UIApplication.shared.connectedScenes.first as! UIWindowScene
		guard let window = windowScene.keyWindow else { return }
		
		
		let rootVC = chooseRoot()
		
		UIView.transition(with: window, duration: 0.4, options: .transitionCrossDissolve) {
			window.rootViewController = rootVC
		}
		
		
	}
	
	
	private func chooseRoot() -> UIViewController {
		
		if Auth.auth().currentUser != nil {
			return CustomTabBarController()
		} else if DefaultsManager.isRegistered {
			return LoginViewController()
		} else {
			return SignupViewController()
		}
		
		
	}
	
	private func loadUserData() async {
		
		
			if let uid = Auth.auth().currentUser?.uid {
				
				do {
					// MARK: -  Для защиты вкл.
//					try? await Task.sleep(nanoseconds: 4 * 1_000_000_000)
					
					try await FirestoreManager.fetchUserData(uid: uid)
				} catch {
					print("Downloading user data error")
				}
			}
			
		
	}
}


@available(iOS 17.0, *)
#Preview {
	return SplashViewController()
}
