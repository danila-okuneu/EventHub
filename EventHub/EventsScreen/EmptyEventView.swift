//
//  EmptyEventView.swift
//  EventHub
//
//  Created by Надежда Капацина on 20.11.2024.
//

import UIKit

class EmptyEventView: UIView {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "No Upcoming Event"
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let secondLabel: UILabel = {
        let label = UILabel()
        label.text = "Lorem ipsum dolor sit amet, \n consestur"
        label.font = UIFont.cerealFont(ofSize: 16, weight: .light)
        label.textAlignment = .center
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let emptyEventImage: UIImageView = {
        var imageV = UIImageView(image: .schedule)
        imageV.translatesAutoresizingMaskIntoConstraints = false
        imageV.layer.cornerRadius = 50
        imageV.clipsToBounds = true
        imageV.contentMode = .scaleAspectFill
        return imageV
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .appGray

        addSubview(titleLabel)
        addSubview(emptyEventImage)
        addSubview(secondLabel)
        

        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo:  emptyEventImage.bottomAnchor, constant: 20),
            
            secondLabel.topAnchor.constraint(greaterThanOrEqualTo: titleLabel.bottomAnchor, constant: 10),
            secondLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            
            emptyEventImage.heightAnchor.constraint(equalToConstant: 202),
            emptyEventImage.widthAnchor.constraint(equalToConstant: 202),
            emptyEventImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            emptyEventImage.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -50),
        ])
    }
    

    
   
}
