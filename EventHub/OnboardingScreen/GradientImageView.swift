//
//  GradientImageView.swift
//  EventHub
//
//  Created by Danila Okuneu on 15.11.24.
//

import UIKit

final class GradientImageView: UIImageView {
	override func layoutSubviews() {
		super.layoutSubviews()
		
		let gradientLayer = CAGradientLayer()
		
		gradientLayer.frame = bounds
		
		gradientLayer.colors = [
			UIColor.appGray.cgColor,
			UIColor.appGray.withAlphaComponent(0.001).cgColor
		]
		
		gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.6)
		gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.85)
		
		layer.mask = gradientLayer
	}
}
