//
//  OnboardingViewController.swift
//  EventHub
//
//  Created by Danila Okuneu on 15.11.24.
//

import UIKit
import SnapKit

final class OnboardingViewController: UIViewController {
	
	private var currentPage = 0
	
	private let phoneCollectionView: PhoneCollectionView = {
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .horizontal
		layout.minimumInteritemSpacing = 0
		layout.minimumLineSpacing = 0
		layout.itemSize = CGSize(width: Constants.phoneWidth, height: Constants.phoneHeight)
		let collectionView = PhoneCollectionView(frame: .zero, collectionViewLayout: layout)
		collectionView.isScrollEnabled = false
		
		return collectionView
	}()
	
	
	private let phoneImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.image = .phoneShape
		imageView.contentMode = .scaleAspectFit
		return imageView
	}()
	
	
	private let baseView: UIView = {
		let view = UIView()
		view.backgroundColor = .appPurple
		view.layer.cornerRadius = Constants.subViewCR
		return view
	}()
	
	private let titleLabel: UILabel = {
		let label = UILabel()
		label.text = "Explore Upcoming and \n Nearby events"
		label.numberOfLines = 2
		label.textColor = .white
		label.textAlignment = .center
		label.font = .systemFont(ofSize: Constants.titleFontSize)
		return label
	}()
	
	private let subtitleLabel: UILabel = {
		let label = UILabel()
		label.text = "some text some text some text some text some text some text"
		label.numberOfLines = 2
		label.textColor = .white
		label.textAlignment = .center
		label.font = .systemFont(ofSize: Constants.subtitleFontSize, weight: .light)
		return label
	}()
	
	private let pageControlHStack: UIStackView = {
		let stack = UIStackView()
		stack.axis = .horizontal
		stack.spacing = 5
		stack.distribution = .fillProportionally
		return stack
	}()
	
	private let skipButton: UIButton = {
		let button = UIButton()
		button.setTitle("Skip", for: .normal)
		button.titleLabel?.font = .systemFont(ofSize: Constants.buttonFontSize, weight: .semibold)
		button.setTitleColor(.lightGray, for: .normal)
		button.titleLabel?.textAlignment = .left
		return button
	}()
	
	private let nextButton: UIButton = {
		let button = UIButton()
		button.setTitle("Next", for: .normal)
		button.titleLabel?.font = .systemFont(ofSize: Constants.buttonFontSize, weight: .semibold)
		button.setTitleColor(.white, for: .normal)
		button.titleLabel?.textAlignment = .right
		return button
	}()
	
	
	private let pageControl: UIPageControl = {
		let pager = UIPageControl()
		pager.currentPage = 1
		pager.numberOfPages = 3
		pager.currentPageIndicatorTintColor = .white
		return pager
	}()
	
	// MARK: - Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		
		phoneCollectionView.register(CustomCollectionCell.self, forCellWithReuseIdentifier: CustomCollectionCell.identifier)
		phoneCollectionView.delegate = self
		phoneCollectionView.dataSource = self
		setupViews()
		setupTargets()
	}
	
	// MARK: - Layout
	private func setupViews() {
		view.backgroundColor = .white
		
		
		view.addSubview(phoneCollectionView)
		view.addSubview(phoneImageView)
		
		view.addSubview(baseView)
		
		baseView.addSubview(titleLabel)
		baseView.addSubview(subtitleLabel)
		baseView.addSubview(pageControlHStack)
		
		pageControlHStack.addArrangedSubview(skipButton)
		pageControlHStack.addArrangedSubview(pageControl)
		pageControlHStack.addArrangedSubview(nextButton)
		makeConstraints()
		
		
		
	}
	
	private func makeConstraints() {
		
		
		phoneCollectionView.snp.makeConstraints { make in
			make.top.equalToSuperview().offset(Constants.phoneTopOffset)
			make.height.equalTo(Constants.phoneHeight)
			make.width.equalTo(Constants.phoneWidth)
			make.centerX.equalToSuperview()
		}
		
		phoneImageView.snp.makeConstraints { make in
			
			make.left.right.equalTo(phoneCollectionView).inset(-Constants.phoneWidthInset)
			make.top.bottom.equalTo(phoneCollectionView).inset(-Constants.phoneHeightInset)
			
		}
		
		
		
		
		baseView.snp.makeConstraints { make in
			make.height.equalTo(Constants.subViewHeight)
			make.left.bottom.right.equalToSuperview()
		}
		
		
		titleLabel.snp.makeConstraints { make in
			make.centerX.equalToSuperview()
			make.width.equalToSuperview().multipliedBy(0.95)
			make.top.equalToSuperview().offset(Constants.titleTopOffset)
		}
		
		subtitleLabel.snp.makeConstraints { make in
			make.centerX.equalToSuperview()
			make.width.equalToSuperview().multipliedBy(0.95)
			make.top.equalTo(titleLabel.snp.bottom).offset(Constants.subtitleOffset)
		}
		
		pageControlHStack.snp.makeConstraints { make in
			make.bottom.equalTo(view.safeAreaLayoutGuide)
			make.left.right.equalTo(view.safeAreaLayoutGuide).inset(20)
		}
		
		skipButton.snp.makeConstraints { make in
			make.width.equalTo(view).multipliedBy(0.3)
		}
		
		nextButton.snp.makeConstraints { make in
			make.width.equalTo(view).multipliedBy(0.3)
		}
		
	}
	
	private func setupTargets() {
		nextButton.addTarget(self, action: #selector(nextTapped), for: .touchUpInside)
		
	}
	
	@objc private func skipTapped() {
		
		let windowScene = UIApplication.shared.connectedScenes.first as! UIWindowScene
		guard let window = windowScene.keyWindow else { return }
		
		
		let rootVC = SignupViewController()
		
		UIView.transition(with: window, duration: 0.4, options: .transitionCrossDissolve) {
			window.rootViewController = rootVC
		}
		
		
	}
	
	@objc private func nextTapped() {
		
		currentPage += 1
	
		switch currentPage {
		case 1:
			update(
				label: titleLabel,
				text: "Web Have Modern Events Calendar Feature"
			)
			update(
				label: subtitleLabel,
				text: "Subtitle1"
			)
		case 2:
			update(
				label: titleLabel,
				text: "To Look Up More Events or Activities Nearby By Map"
			)
			update(
				label: subtitleLabel,
				text: "Subtitle2"
			)
			update(button: nextButton, title: "Start")
			update(button: skipButton, title: "")
		default:
			
			
			let windowScene = UIApplication.shared.connectedScenes.first as! UIWindowScene
			guard let window = windowScene.keyWindow else { return }
			
			
			let rootVC = SignupViewController()
			
			UIView.transition(with: window, duration: 0.4, options: .transitionCrossDissolve) {
				window.rootViewController = rootVC
			}
			
		}
		
		pageControl.currentPage = currentPage
		phoneCollectionView.scrollToItem(at: IndexPath(row: currentPage, section: 0), at: .centeredHorizontally, animated: true)
		
		
	}
	
	
	
	private func update(label: UILabel, text: String) {
		UIView.transition(with: label, duration: 0.2, options: .transitionCrossDissolve) {
			label.text = text
		}
	}
	
	private func update(button: UIButton, title: String) {
		UIView.transition(with: button, duration: 0.2, options: .transitionCrossDissolve) {
			button.setTitle(title, for: .normal)
		}
	}
}

// MARK: - Delegate & Datasource
extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		OnboardingScreen.list.count
	}
	
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionCell.identifier, for: indexPath) as! CustomCollectionCell
		
		cell.imageView.image = OnboardingScreen.list[indexPath.row].image
		return cell
	}
	
	
}

// MARK: - Constants
extension OnboardingViewController {
	
	private struct Constants {
		
		static let screenHeight = UIScreen.main.bounds.height
		static let screenWidth = UIScreen.main.bounds.width
		
		static let subViewHeight = screenHeight * 288 / 812
		static let subViewCR = screenHeight * 48 / 812
		
		static let phoneHeight = screenHeight * 538.07 / 812
		static let phoneWidth = screenWidth * 270 / 375
		static let phoneTopOffset = screenHeight * 78.5 / 812
		static let phoneBottomOffset = screenHeight * 195.42 / 812
		static let phoneHeightInset = screenHeight * 17 / 812
		static let phoneWidthInset = screenWidth * 17 / 375
		
		static let titleTopOffset = screenHeight * 36 / 812
		static let titleFontSize = screenHeight * 22 / 812
		
		static let subtitleFontSize = screenHeight * 15 / 812
		static let subtitleOffset = screenHeight * 25 / 812
		
		static let buttonFontSize = screenHeight * 18 / 812
	}
}



@available(iOS 17.0, *)
#Preview {
	return OnboardingViewController()
}
