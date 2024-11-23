//
//  CollectionViewCell.swift
//  EventHub
//
//  Created by Danila Okuneu on 16.11.24.
//

import UIKit
import SnapKit

final class CustomCollectionCell: UICollectionViewCell {
	
	static let identifier = "CustomCell"
	
	let imageView: UIImageView = {
		let image = UIImageView()
		image.contentMode = .scaleAspectFill
		return image
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		contentView.clipsToBounds = true
		contentView.addSubview(imageView)
		imageView.snp.makeConstraints { make in
			make.edges.equalToSuperview()
		}
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	
	
	
	
	
}
