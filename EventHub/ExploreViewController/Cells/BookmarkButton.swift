//
//  BookmarkButton.swift
//  EventHub
//
//  Created by Danila Okuneu on 29.11.24.
//

import UIKit

final class BookmarkButton: RoundedButton {
	
	var isBookmarked: Bool {
		didSet {
			UIView.transition(with: self, duration: 0.15, options: [.transitionCrossDissolve, .curveEaseOut]) {
				self.setImage(self.isBookmarked ? .bookmarkFill : .bookmarkEmpty, for: .normal)
			}
		}
	}
	
	init(colors: (tint: UIColor, background: UIColor), isBookmarked: Bool = false) {
		self.isBookmarked = isBookmarked
		super.init(image: isBookmarked ? .bookmarkFill : .bookmarkEmpty, colors: colors)

	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}


class RoundedButton: UIButton {
	
	init(image: UIImage?, colors: (tint: UIColor, background: UIColor)) {
		super.init(frame: .zero)
		
		layer.backgroundColor = colors.background.cgColor
		setImage(image?.withRenderingMode(.alwaysTemplate), for: .normal)
		tintColor = colors.tint
		
		
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
		
	override func layoutSubviews() {
		super.layoutSubviews()
		
		
		layer.cornerRadius = bounds.width / 4
		
		
		let pading = self.bounds.width * 0.25
		let imageSide = self.bounds.width - pading * 2
		
		imageView?.frame = CGRect(x: pading, y: pading, width: imageSide, height: imageSide)
	}
	
	
	func change(colors: (tint: UIColor, background: UIColor)) {
		
		UIView.animate(withDuration: 0.3, delay:  0.0, options: .curveEaseOut) {
			self.backgroundColor = colors.background
			self.tintColor = colors.tint
		}
	}
}
