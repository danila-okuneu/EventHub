//
//  EventDetailsView.swift
//  EventHub
//
//  Created by Vika on 22.11.24.
//

import UIKit

class EventDetailsView: UIView {

    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    // MARK: - UI Elements
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "mockOrchestra")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let eventLabel: UILabel = {
        let label = UILabel()
        label.text = "Event Details"
        label.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        label.textColor = .white
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var shareButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "shareIcon"), for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var bookmarkButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "bookmarkWhiteIcon"), for: .normal)
        button.tintColor = .systemBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let eventTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "International Band Music Concert"
        label.font = UIFont.cerealFont(ofSize: 35, weight: .regular)
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    private let infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 21
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let aboutEventTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "About Event"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let aboutEventDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "International Band Music Concert is a free and open-source music festival that takes place in the heart of the city. The festival features a wide range of musical performances from around the world, including classical, jazz, and rock music. The festival also features a variety of food and drinks, as well as a variety of other activities for the entire family."
        label.font = UIFont.cerealFont(ofSize: 16)
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.backgroundColor = .white
        
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.isScrollEnabled = true
        scrollView.alwaysBounceVertical = true
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        UIKit.NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
        
        addSubview(backgroundImageView)
        addSubview(eventLabel)
        addSubview(backButton)
        addSubview(shareButton)
        addSubview(bookmarkButton)
        addSubview(eventTitleLabel)
        addSubview(infoStackView)
        addSubview(aboutEventTitleLabel)
        addSubview(aboutEventDescriptionLabel)
        
        // Add reusable components to the stack view
        let dateView = InfoCellView(
            icon: UIImage(named: "stackDateIcon"),
            title: "14 December, 2021",
            subtitle: "Tuesday, 4:00 PM - 9:00 PM"
        )
        let locationView = InfoCellView(
            icon: UIImage(named: "stackLocationIcon"),
            title: "Gala Convention Center",
            subtitle: "36 Guild Street London, UK"
        )
        let organizerView = InfoCellView(
            icon: UIImage(named: "stackImageIcon"),
            title: "Ashfak Sayem",
            subtitle: "Organizer"
        )
        
        infoStackView.addArrangedSubview(dateView)
        infoStackView.addArrangedSubview(locationView)
        infoStackView.addArrangedSubview(organizerView)
        
        
        // Размещение элементов на экране
        NSLayoutConstraint.activate([
            // Background image
            backgroundImageView.topAnchor.constraint(equalTo: self.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            backgroundImageView.heightAnchor.constraint(equalToConstant: 220),
            
            // Back button
            backButton.topAnchor.constraint(equalTo: backgroundImageView.topAnchor, constant: 50),
            backButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            backButton.widthAnchor.constraint(equalToConstant: 22),
            backButton.heightAnchor.constraint(equalToConstant: 22),
            
            eventLabel.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
            eventLabel.leadingAnchor.constraint(equalTo: backButton.trailingAnchor, constant: 13),
            
            // bookmark Button
            bookmarkButton.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
            bookmarkButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            bookmarkButton.widthAnchor.constraint(equalToConstant: 36),
            bookmarkButton.heightAnchor.constraint(equalToConstant: 36),
            
            // Share button
            shareButton.bottomAnchor.constraint(equalTo: backgroundImageView.bottomAnchor, constant: 0),
            shareButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            shareButton.widthAnchor.constraint(equalToConstant: 36),
            shareButton.heightAnchor.constraint(equalToConstant: 36),
            
            // Event title
            eventTitleLabel.topAnchor.constraint(equalTo: backgroundImageView.bottomAnchor, constant: 50),
            eventTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            eventTitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            
            // Info stack view
            infoStackView.topAnchor.constraint(equalTo: eventTitleLabel.bottomAnchor, constant: 18),
            infoStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            infoStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            
            // About event title
            aboutEventTitleLabel.topAnchor.constraint(equalTo: infoStackView.bottomAnchor, constant: 21),
            aboutEventTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            
            // About event description
            aboutEventDescriptionLabel.topAnchor.constraint(equalTo: aboutEventTitleLabel.bottomAnchor, constant: 8),
            aboutEventDescriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            aboutEventDescriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            
            contentView.bottomAnchor.constraint(equalTo: aboutEventDescriptionLabel.bottomAnchor)
        ])
    }
    
    func configure(with event: EventModel) {
        if let firstImageName = event.images?.first?.image {
            backgroundImageView.image = UIImage(named: firstImageName)
        }
        
        eventTitleLabel.text = event.title
        
        aboutEventDescriptionLabel.text = event.bodyText
                
        if let firstDate = event.dates.first {
            (infoStackView.arrangedSubviews[0] as? InfoCellView)?.configure(
                icon: UIImage(named: "stackDateIcon"),
                title: firstDate.startDate!,
                subtitle: firstDate.startTime
            )
        }
        
        if let place = event.place {
            (infoStackView.arrangedSubviews[1] as? InfoCellView)?.configure(
                icon: UIImage(named: "stackLocationIcon"),
                title: place.title,
                subtitle: place.address
            )
        }
        
        if let firstParticipant = event.participants?.first {
            (infoStackView.arrangedSubviews[2] as? InfoCellView)?.configure(
                icon: UIImage(named: "stackImageIcon"),
                title: firstParticipant.title,
                subtitle: firstParticipant.ctype
            )
        }
    }
}

@available(iOS 17.0, *)
#Preview {
    EventDetailsView()
}
