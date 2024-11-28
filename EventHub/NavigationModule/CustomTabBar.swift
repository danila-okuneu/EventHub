//
//  CustomTabBar.swift
//  EventHub
//
//  Created by Vika on 18.11.24.
//

import UIKit

protocol CustomTabBarDelegate: AnyObject {
    func didTapFavoriteButton()
}

final class CustomTabBar: UITabBar {
    
    weak var customDelegate: CustomTabBarDelegate?
    
    private let favoriteButton = FavoriteButton(type: .system)
    private let shadowLayer = CALayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupTabBar()
        setupFavoriteButton()
        addShadow()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTabBar() {
        frame.size.height = 88
        tintColor = .accent
        unselectedItemTintColor = .appGrayTabbar
    }
    
    private func addShadow() {
        shadowLayer.shadowColor = UIColor.lightGray.cgColor
        shadowLayer.shadowOpacity = 0.3
        shadowLayer.shadowOffset = CGSize(width: 0, height: -3)
        shadowLayer.shadowRadius = 6
        shadowLayer.backgroundColor = UIColor.white.cgColor
        shadowLayer.frame = bounds
        shadowLayer.cornerRadius = 0
        
        layer.insertSublayer(shadowLayer, at: 0)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        shadowLayer.frame = bounds
    }
    
    private func setupFavoriteButton() {
        addSubview(favoriteButton)
        NSLayoutConstraint.activate([
            favoriteButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            favoriteButton.centerYAnchor.constraint(equalTo: topAnchor),
            favoriteButton.heightAnchor.constraint(equalToConstant: 46),
            favoriteButton.widthAnchor.constraint(equalToConstant: 46)
        ])
        
        favoriteButton.addTarget(self, action: #selector(didTapFavoriteButton), for: .touchUpInside)
    }
    
    @objc private func didTapFavoriteButton() {
        customDelegate?.didTapFavoriteButton()
    }
    
    func updateFavoriteButtonColor(to color: UIColor) {
        favoriteButton.backgroundColor = color
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        favoriteButton.frame.contains(point) ? favoriteButton : super.hitTest(point, with: event)
    }
}

