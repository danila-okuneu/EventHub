//
//  DetailComponentView.swift
//  EventHub
//
//  Created by Danila Okuneu on 30.11.24.
//

import UIKit
import SnapKit

final class DetailComponentView: UIView {
	
	// MARK: - UI Components
	private let imageView: UIImageView = {
		let imageView = UIImageView()
		imageView.contentMode = .scaleAspectFill
		return imageView
	}()
	
	private let infoStackView: UIStackView = {
		let stack = UIStackView()
		stack.axis = .vertical
		stack.distribution = .fillProportionally
		stack.spacing = 5
		return stack
	}()
	
	private let titleLabel: UILabel = {
		let label = UILabel()
		label.textColor = .detailsText
		label.numberOfLines = 1
		label.minimumScaleFactor = 0.8
		label.adjustsFontSizeToFitWidth = true
		label.font = .systemFont(ofSize: 16, weight: .semibold)
		return label
	}()
	
	private let subtitleLabel: UILabel = {
		let label = UILabel()
		label.textColor = .detailsTextGray
		label.font = .cerealFont(ofSize: 12, weight: .light)
		return label
	}()
	
	// MARK: - Initializers
	init(with title: String, and subtitle: String, image: UIImage?) {
		super.init(frame: .zero)
		
		imageView.image = image
		titleLabel.text = title
		subtitleLabel.text = subtitle
		setupViews()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Layout
	private func setupViews() {
		
		addSubview(imageView)
		addSubview(infoStackView)
		infoStackView.addArrangedSubview(titleLabel)
		infoStackView.addArrangedSubview(subtitleLabel)
		
		makeConstraints()
	}
	
	private func makeConstraints() {
		
		imageView.snp.makeConstraints { make in
			make.height.width.equalTo(self.snp.height)
			make.left.equalToSuperview()
		}
		
		infoStackView.snp.makeConstraints { make in
			make.centerY.equalTo(imageView.snp.centerY)
			make.left.equalTo(imageView.snp.right).offset(10)
			make.right.equalToSuperview()
		}
	}
	
	// MARK: - Methods
	func updateTitle(with title: String) {
		titleLabel.text = title
	}
	
	func updateSubtitle(with subtitle: String) {
		subtitleLabel.text = subtitle
	}
}
