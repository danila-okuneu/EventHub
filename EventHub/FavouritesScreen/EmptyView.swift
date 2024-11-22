//
//  EmptyView.swift
//  EventHub
//
//  Created by Надежда Капацина on 20.11.2024.
//

import UIKit

class EmptyView: UIView {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "NO FAVORITES"
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let emptyFavImage: UIImageView = {
        var imageV = UIImageView(image: .favorite)
        imageV.translatesAutoresizingMaskIntoConstraints = false
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
        addSubview(emptyFavImage)
        

        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: emptyFavImage.topAnchor, constant: -50),
            
            emptyFavImage.heightAnchor.constraint(equalToConstant: 145),
            emptyFavImage.widthAnchor.constraint(equalToConstant: 137),
            emptyFavImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            emptyFavImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }
    

    
   
}
