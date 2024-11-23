//
//  OnboardingCollectionView.swift
//  EventHub
//
//  Created by Danila Okuneu on 18.11.24.
//

import UIKit

final class PhoneCollectionView: UICollectionView {
	
	// MARK: - UI Components
	
	
	// MARK: - Initializers
	override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
		super.init(frame: frame, collectionViewLayout: layout)
		allowsSelection = false
		isPagingEnabled = true
		showsHorizontalScrollIndicator = false
		layer.cornerRadius = 15
		layer.masksToBounds = true
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Methods
	
	
	
}
