//
//  FavoriteButton.swift
//  EventHub
//
//  Created by Vika on 18.11.24.
//

import UIKit

final class FavoriteButton: UIButton {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = frame.width / 2
        addShadow()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        setImage(UIImage(named: "favoriteIcon"), for: .normal)
        backgroundColor = .accent
        tintColor = .white
        translatesAutoresizingMaskIntoConstraints = false
    }
    
// MARK: - тень под кнопкой

    private func addShadow() {
        layer.shadowColor = UIColor.accent.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize(width: 0, height: 8)
        layer.shadowRadius = 8
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: frame.width / 2).cgPath
        layer.masksToBounds = false
    }
}
