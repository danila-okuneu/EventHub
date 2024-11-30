//
//  DetailsViewController.swift
//  EventHub
//
//  Created by Danila Okuneu on 29.11.24.
//

import UIKit
import SnapKit
import SkeletonView


final class DetailsViewController: UIViewController {
	
	// MARK: - UI Components
	private let scrollView: UIScrollView = {
		let scrollView = UIScrollView()
		scrollView.showsVerticalScrollIndicator = false
		scrollView.bounces = false
		scrollView.contentInsetAdjustmentBehavior = .never
		scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0)
		return scrollView
	}()
	
	private let contentView = UIView()
	
	private let infoStackView: UIStackView = {
		let stack = UIStackView()
		stack.axis = .vertical
		stack.distribution = .fillProportionally
		stack.spacing = 18
		return stack
	}()
	
	private let headerImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.contentMode = .scaleAspectFill
		imageView.backgroundColor = .appGray
		imageView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
		imageView.layer.cornerRadius = 25
		imageView.layer.masksToBounds = true
		return imageView
	}()

	private let titleLabel: UILabel = {
		let label = UILabel()
		label.font = .cerealFont(ofSize: Constants.titleFontSize)
		label.textColor = .detailsText
		label.numberOfLines = 3
		label.adjustsFontSizeToFitWidth = true
		label.minimumScaleFactor = 0.01
		label.text = "Mock title Mock title Mock title Mock title Mock title Mock title Mock title "
		return label
	}()
	
	private let dateComponentView = DetailComponentView(
		with: "Title",
		and: "Subtitle",
		image: .detailsDate
	)
	
	private let placeComponentView = DetailComponentView(
		with: "Adress",
		and: "Place",
		image: .detailsLocation
	)
	
	private let aboutTitleLabel: UILabel = {
		let label = UILabel()
		label.text = "About Event"
		label.textColor = .detailsText
		label.font = .systemFont(ofSize: Constants.aboutFontSize)
		return label
	}()
	
	private let eventBodyLabel: UILabel = {
		let label = UILabel()
		label.numberOfLines = 0
		label.lineBreakMode = .byWordWrapping
		label.font = .cerealFont(ofSize: Constants.bodyFontSize, weight: .light)
		label.textColor = .detailsText
		label.text = "body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body body "
		return label
	}()
	
	

	// MARK: - Initializers
	init(event: EventType) {
		super.init(nibName: nil, bundle: nil)
		configure(with: event)
	}
	
	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	// MARK: - Life cycle
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupViews()
	}
	
	// MARK: - Layout
	private func setupViews() {
		
		view.backgroundColor = .white
		
		setupScrollView()
		
		contentView.addSubview(headerImageView)
		contentView.addSubview(infoStackView)
		infoStackView.addArrangedSubview(titleLabel)
		infoStackView.addArrangedSubview(dateComponentView)
		infoStackView.addArrangedSubview(placeComponentView)
		infoStackView.addArrangedSubview(aboutTitleLabel)
		infoStackView.addArrangedSubview(eventBodyLabel)
		
		infoStackView.setCustomSpacing(40, after: placeComponentView)
		setupConstraints()
	}
	
	
	private func setupConstraints() {
		
		headerImageView.snp.makeConstraints { make in
			make.top.left.right.equalToSuperview()
			make.height.equalTo(Constants.headerImageHeight)
		}
		
		infoStackView.snp.makeConstraints { make in
			make.top.equalTo(headerImageView.snp.bottom).offset(54)
			make.left.right.equalToSuperview().inset(Constants.padding)
			make.bottom.equalTo(contentView)
		}
		
		dateComponentView.snp.makeConstraints { make in
			make.height.equalTo(Constants.detailElementHeight)
		}
		
		placeComponentView.snp.makeConstraints { make in
			make.height.equalTo(Constants.detailElementHeight)
		}

	}
	
	private func setupScrollView() {
		
		view.addSubview(scrollView)
		
		scrollView.snp.makeConstraints { make in
			make.edges.equalToSuperview()
		}
		
		scrollView.addSubview(contentView)
		
		contentView.snp.makeConstraints { make in
			make.centerX.equalToSuperview()
			make.top.equalToSuperview()
			make.width.equalToSuperview()
			make.bottom.equalToSuperview()
		}
	}

	// MARK: - Methods
	func configure(with event: EventType) {
		
		titleLabel.text = event.title.capitalized
		
		if let urlString = event.images.first?.image, let url = URL(string: urlString) {
			headerImageView.kf.setImage(with: url)
		}
		
	
		if !event.dates.isEmpty {
			let date = event.dates[0].end
			dateComponentView.updateTitle(with: date.formatTo(.detailsHeaderDate))
			dateComponentView.updateSubtitle(with: date.formatTo(.detailsDayTime))
		} else {
			dateComponentView.updateTitle(with: "Date not provided")
			dateComponentView.updateSubtitle(with: "")
		}
		
		if let place = event.place {
			if place.address != "" {
				placeComponentView.updateTitle(with: place.address)
			} else {
				placeComponentView.updateTitle(with: place.title)
			}
			
		} else {
			placeComponentView.updateTitle(with: "Adress not provided")
		}
		
		if let data = event.bodyText.data(using: .utf8) {
			do {
				let attributedString = try NSMutableAttributedString(
					data: data,
					options: [.documentType: NSAttributedString.DocumentType.html,
							  .characterEncoding: String.Encoding.utf8.rawValue],
					documentAttributes: nil)
				
				let standardFont = UIFont.systemFont(ofSize: UIFont.systemFontSize)
				
				// Scale Ratio
				let scalingFactor: CGFloat = 1.3
				
				attributedString.enumerateAttribute(.font, in: NSRange(location: 0, length: attributedString.length), options: []) { (value, range, stop) in
					if let font = value as? UIFont {
						let newFontDescriptor = standardFont.fontDescriptor.withSymbolicTraits(font.fontDescriptor.symbolicTraits) ?? standardFont.fontDescriptor
						let scaledFontSize = font.pointSize * scalingFactor
						let newFont = UIFont(descriptor: newFontDescriptor, size: scaledFontSize)
						attributedString.addAttribute(.font, value: newFont, range: range)
					}
				}
				
				let textColor = UIColor.detailsText
				attributedString.addAttribute(.foregroundColor, value: textColor, range: NSRange(location: 0, length: attributedString.length))
				
				let paragraphStyle = NSMutableParagraphStyle()
				paragraphStyle.lineSpacing = 4
				attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedString.length))
				
				eventBodyLabel.attributedText = attributedString
			} catch {
				print("Ошибка преобразования HTML в атрибутированную строку: \(error)")
			}
		}
		
		
	}
}

// MARK: - Constants
extension DetailsViewController {
	
	private struct Constants {
		
		static let screenHeight = UIScreen.main.bounds.height
		static let screenWidth = UIScreen.main.bounds.width
		
		static let headerImageHeight = screenHeight * 221 / 812
		
		static let padding = screenWidth * 24 / 375
		
		static let detailElementHeight = screenHeight * 48 / 812
		
		static let titleFontSize = screenHeight * 35 / 812
		static let aboutFontSize = screenHeight * 18 / 812
		static let bodyFontSize = screenHeight * 16 / 812
		
	}
	
	
}