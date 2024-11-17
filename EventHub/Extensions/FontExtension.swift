//
//  ColorExtensiobn.swift
//  EventHub
//
//  Created by Danila Okuneu on 17.11.24.
//

import UIKit

extension UIFont {
	
	
	enum FontWeight {
		case light
		case regular
	}
	
	static func cerealFont(ofSize size: CGFloat, weight: FontWeight = .regular) -> UIFont {
		
		let fontName: String
		switch weight {
		case .light:
			fontName = "AirbnbCereal_W_Lt"
		case .regular:
			fontName = "AirbnbCereal_W_Bk"
		}

		guard let font = UIFont(name: fontName, size: size) else {
			fatalError("Failed to load font: \(fontName)")
		}

		return font
	}
}
