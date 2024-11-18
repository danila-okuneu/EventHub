//
//  FavEventCell.swift
//  EventHub
//
//  Created by Надежда Капацина on 18.11.2024.
//

import UIKit

class FavEventCollectionViewCell: UICollectionViewCell {

    let eventNamelabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = .black
        label.font = .cerealFont(ofSize: 15)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        eventNamelabel.text = "hello"
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        contentView.addSubview(eventNamelabel)

        NSLayoutConstraint.activate([
            eventNamelabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            eventNamelabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            eventNamelabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            eventNamelabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
}
