//
//  FavEventCell.swift
//  EventHub
//
//  Created by Надежда Капацина on 18.11.2024.
//

import UIKit

class EventCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "EventCollectionViewCell"
    
    private let eventImageView = UIImageView()
    private let dateLabel = UILabel()
    private let titleLabel = UILabel()
    private let placeLabel = UILabel()
    private let bookmarkButton = UIButton(type: .system)
    
    private var isBookmarked = false

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        eventImageView.contentMode = .scaleAspectFill
        eventImageView.clipsToBounds = true
        
        dateLabel.font = UIFont.systemFont(ofSize: 14)
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        placeLabel.font = UIFont.systemFont(ofSize: 14)
        
        bookmarkButton.setTitle("⭐️", for: .normal)
        bookmarkButton.addTarget(self, action: #selector(bookmarkTapped), for: .touchUpInside)
        
        let stackView = UIStackView(arrangedSubviews: [dateLabel, titleLabel, placeLabel])
        stackView.axis = .vertical
        stackView.spacing = 4
        
        contentView.addSubview(eventImageView)
        contentView.addSubview(stackView)
        contentView.addSubview(bookmarkButton)
        
        eventImageView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        bookmarkButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            eventImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            eventImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            eventImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            eventImageView.widthAnchor.constraint(equalToConstant: 100),
            
            stackView.leadingAnchor.constraint(equalTo: eventImageView.trailingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: bookmarkButton.leadingAnchor, constant: -8),
            stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            bookmarkButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            bookmarkButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    @objc private func bookmarkTapped() {
        isBookmarked.toggle()
        bookmarkButton.tintColor = isBookmarked ? .red : .systemBlue
    }
    
    func configure(with event: Event) {
        dateLabel.text = event.date
        titleLabel.text = event.title
        placeLabel.text = event.location
        eventImageView.image = event.image
        
        // Здесь нужно загрузить изображение мероприятия (например, из URL)
        // eventImageView.image = ...
    }
}
