//
//  GradientImage.swift
//  EventHub
//
//  Created by Danila Okuneu on 1.12.24.
//

import UIKit

extension UIImage {
	static func gradientImage(with colors: [UIColor], size: CGSize, locations: [NSNumber]? = nil) -> UIImage? {
		
		
		let gradientLayer = CAGradientLayer()
		gradientLayer.colors = colors.map { $0.cgColor }
		gradientLayer.startPoint = CGPoint(x: 0.5, y: -0.2)
		gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
		gradientLayer.frame = CGRect(origin: .zero, size: size)
		
		UIGraphicsBeginImageContextWithOptions(gradientLayer.bounds.size, false, 0.0)
		defer { UIGraphicsEndImageContext() }
		
		guard let context = UIGraphicsGetCurrentContext() else { return nil }
		gradientLayer.render(in: context)
		return UIGraphicsGetImageFromCurrentImageContext()
	}
}
