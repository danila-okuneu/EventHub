//
//  categorieCollectionViewCell.swift
//  WorldNewsApp
//
//  Created by Igor Guryan on 20.11.2024.
//

import UIKit

final class CategoryCell: UICollectionViewCell {
    static let identifier = String(describing: Category.self)
    
    private let titleLabel = UILabel()
    private let imageView = UIImageView(image: UIImage(systemName: "basketball.fill")?.withTintColor(.white).withRenderingMode(.alwaysOriginal))

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        contentView.layer.cornerRadius = 20
        contentView.layer.masksToBounds = true
        contentView.addSomeSubviews(imageView, titleLabel)
        setupLabel()
        contentView.disableChildrenTAMIC()

        
        imageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
            make.size.equalTo(CGSize(width: 18, height: 18))
        }
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(imageView.snp.trailing).offset(8)
			make.trailing.equalToSuperview().offset(-10)
        }
        
    }
    
    private func setupLabel() {
        
        contentView.backgroundColor = .appRed
        titleLabel.font = .cerealFont(ofSize: 15)
        titleLabel.textColor = .white
		titleLabel.adjustsFontSizeToFitWidth = true
		titleLabel.minimumScaleFactor = 0.5
    }
    
    private func setupImageView(imageName: String) {
        imageView.image = UIImage(systemName: imageName)?.withTintColor(.white).withRenderingMode(.alwaysOriginal)
    }
    
    func configureCell(with category: Category) {
        titleLabel.text = category.name
        setupImageView(imageName: category.sfSymbol)
        contentView.backgroundColor = category.color
        
//        switch category {
//        case "Sports":
//            setupImageView(imageName: "basketball.fill")
//            contentView.backgroundColor = .appRed
//        case "Music":
//            setupImageView(imageName: "music.note")
//            contentView.backgroundColor = .appOrange
//        case "Food":
//            setupImageView(imageName: "fork.knife")
//            contentView.backgroundColor = .appGreen
//        case "Art":
//            setupImageView(imageName: "paintbrush.pointed.fill")
//            contentView.backgroundColor = .appCyan
//        default:
//            break
//        }
    }
}
//"Sports", "Music", "Food", "Art"

@available(iOS 17.0, *)
#Preview {ExploreViewController()
}
