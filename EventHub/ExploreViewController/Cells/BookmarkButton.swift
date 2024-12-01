//
//  BookmarkButton.swift
//  EventHub
//
//  Created by Danila Okuneu on 29.11.24.
//

import UIKit

final class BookmarkButton: UIButton {
	
    var isBookmarked: Bool
	
	init(isBookmarked: Bool = false) {
		self.isBookmarked = isBookmarked
		super.init(frame: .zero)
		
		layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.7).cgColor
		setImage(isBookmarked ? .bookmarkFill : .bookmarkEmpty, for: .normal)
		layer.cornerRadius = 10

	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func toggleState() {
		isBookmarked.toggle()
		UIView.transition(with: self, duration: 0.15, options: [.transitionCrossDissolve, .curveEaseOut]) {
			self.setImage(self.isBookmarked ? .bookmarkFill : .bookmarkEmpty, for: .normal)
		}
		
	}
}
