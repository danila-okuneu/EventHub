//
//  CustomButton.swift
//  EventHub
//
//  Created by Vika on 20.11.24.
//

import UIKit

class CustomButton: UIButton {
    
    private var icon: UIImage?
    private var hasBorder: Bool
    private var borderColor: UIColor
    private var textColor: UIColor
    private var iconTintColor: UIColor
    private static let defaultFont = UIFont.cerealFont(ofSize: 16, weight: .regular)

    init(
        title: String,
        icon: UIImage?,
        hasBorder: Bool = false,
        borderColor: UIColor = .accent,
        textColor: UIColor = .accent,
        iconTintColor: UIColor = .accent
    ) {
        self.icon = icon
        self.hasBorder = hasBorder
        self.borderColor = borderColor
        self.textColor = textColor
        self.iconTintColor = iconTintColor
        super.init(frame: .zero)
        configure(with: title, image: icon)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        self.icon = nil
        self.hasBorder = false
        self.borderColor = .black
        self.textColor = .black
        self.iconTintColor = .black
        super.init(coder: coder)
        configure(with: "", image: nil)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configure(with title: String, image: UIImage?) {
        
        // button text
        var config = UIButton.Configuration.plain()
        
        let attributedTitle = AttributedString(
            title,
            attributes: AttributeContainer([
                .font: CustomButton.defaultFont, 
                .foregroundColor: textColor
            ])
        )
        
        config.attributedTitle = attributedTitle
        
        // button icon
        config.image = image?.withRenderingMode(.alwaysTemplate)
        config.imagePadding = 16
        config.imagePlacement = .leading
        config.contentInsets = NSDirectionalEdgeInsets(top: 13, leading: 20, bottom: 13, trailing: 20)
        
        // button border
        if hasBorder {
            self.layer.borderColor = borderColor.cgColor
            self.layer.borderWidth = 1.5
            self.layer.cornerRadius = 10
        } else {
            self.layer.borderWidth = 0
        }
        
        self.configuration = config
        self.tintColor = iconTintColor
    }
}
