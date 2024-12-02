//
//  FavEventCell.swift
//  EventHub
//
//  Created by Надежда Капацина on 18.11.2024.
//

import UIKit
import Kingfisher
import SkeletonView

class EventCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "EventCollectionViewCell"
    
    private let eventImageView = UIImageView()
    private let dateLabel = UILabel()
    private let titleLabel = UILabel()

    private let locationImageView = UIImageView()
    private let locationLabel = UILabel()

    private let bookmarkButton = UIButton(type: .system)
    
    private var isBookmarked = true

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
		setupSkeletons()
		
		self.contentView.showAnimatedGradientSkeleton()
		self.locationLabel.showAnimatedGradientSkeleton()
	
    }
	
	override func prepareForReuse() {
		super.prepareForReuse()
		
		eventImageView.image = nil
		contentView.showAnimatedGradientSkeleton()
		titleLabel.showAnimatedGradientSkeleton()
		locationLabel.showAnimatedGradientSkeleton()
	}
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 10
        
        eventImageView.contentMode = .scaleAspectFill
        eventImageView.clipsToBounds = true
        eventImageView.layer.cornerRadius = 10
        
        
        dateLabel.font = UIFont.cerealFont(ofSize: 13, weight: .light)
        dateLabel.textColor = .accent
		dateLabel.numberOfLines = 1
        
        titleLabel.font = UIFont.boldSystemFont(ofSize: 15)
        titleLabel.numberOfLines = 3
        
        locationLabel.font = UIFont.cerealFont(ofSize: 13)
        locationLabel.textColor = .appGrayTabbar
        locationLabel.numberOfLines = 1
		locationLabel.isSkeletonable = true
        locationImageView.image = .location
		
        
        bookmarkButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
        bookmarkButton.tintColor = UIColor.appRed
		bookmarkButton.isHidden = true

        bookmarkButton.addTarget(self, action: #selector(bookmarkTapped), for: .touchUpInside)
        
        
        
        let locationStackView = UIStackView(arrangedSubviews: [locationImageView, locationLabel])
        
        locationStackView.axis = .horizontal
        locationStackView.spacing = 4
        
        contentView.addSubview(eventImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(locationStackView)
        contentView.addSubview(bookmarkButton)
        
        eventImageView.translatesAutoresizingMaskIntoConstraints = false
        locationStackView.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        locationImageView.translatesAutoresizingMaskIntoConstraints = false
        bookmarkButton.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            eventImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            eventImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
			eventImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            eventImageView.widthAnchor.constraint(equalToConstant: 100),

            
            dateLabel.topAnchor.constraint(equalTo: eventImageView.topAnchor, constant: 5),
            dateLabel.leadingAnchor.constraint(equalTo: eventImageView.trailingAnchor, constant: 10),
			dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            titleLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: dateLabel.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
			titleLabel.bottomAnchor.constraint(equalTo: locationImageView.topAnchor, constant: -10),
            
            bookmarkButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            bookmarkButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            bookmarkButton.widthAnchor.constraint(equalToConstant: 20),
            bookmarkButton.heightAnchor.constraint(equalToConstant: 20),

            
            locationImageView.widthAnchor.constraint(equalToConstant: 14),
            locationImageView.heightAnchor.constraint(equalToConstant: 14),
            locationStackView.bottomAnchor.constraint(equalTo: eventImageView.bottomAnchor, constant: -5),
            locationStackView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor, constant: 5),
            locationStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
 
        ])
    }
    
    @objc private func bookmarkTapped() {
        isBookmarked.toggle()
        bookmarkButton.tintColor = isBookmarked ? .red : .blue
    }
    
	func configure(with event: Event, isbookmarkHidden: Bool, isLocationHidden: Bool) {
		
		hideSkeletons()
		print(event.actualDate)
		dateLabel.text = event.actualDate.formatTo(.eventPreview)
        titleLabel.text = event.title
        
        if let eventPlace = event.place {
            if eventPlace.address != "" {
                locationLabel.text = eventPlace.address
            } else if eventPlace.title != "" {
                locationLabel.text = eventPlace.title
            }
        } else {
            locationLabel.text = "Adress not provided"
        }

        if let imageUrlString = event.images.first?.image, let imageUrl = URL(string: imageUrlString) {
            eventImageView.kf.setImage(with: imageUrl, placeholder: nil, options: nil) { [weak self] result in
                self?.eventImageView.hideSkeleton(transition: .crossDissolve(0.2))
            }
        } else {
            
            eventImageView.hideSkeleton()
            eventImageView.image = UIImage(named: "hands")
        }
		
		
		
//		eventImageView.image = ._1
        bookmarkButton.isHidden = isbookmarkHidden
        locationLabel.isHidden = isLocationHidden
        locationImageView.isHidden = isLocationHidden

    }
}


// MARK: - Skeletons
extension EventCollectionViewCell {
	
	func setupSkeletons() {
		
		contentView.isSkeletonable = true
		eventImageView.isSkeletonable = true
		dateLabel.isSkeletonable = true
		locationLabel.isSkeletonable = true
		titleLabel.isSkeletonable = true
	}
	
	func hideSkeletons() {
		
		contentView.hideSkeleton()
		dateLabel.hideSkeleton()
		locationLabel.hideSkeleton()
		titleLabel.hideSkeleton()
	}
}
