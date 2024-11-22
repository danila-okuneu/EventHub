//
//  RecNewCollectionViewCell.swift
//  WorldNewsApp
//
//  Created by Igor Guryan on 25.10.2024.
//

import UIKit
import Kingfisher
import SnapKit

class EventCell: UICollectionViewCell {
    static let identifier = String(describing: EventCell.self)
    private let imageView = UIImageView()
    private var eventDate = UILabel()
    private let friendsView = UIView()
    
    private lazy var eventLocation: UIView = {
        let view = UIView()
        let imageView = UIImageView(image: .mappin)
        var label = UILabel()
        label.textColor = UIColor(red: 0.167, green: 0.157, blue: 0.287, alpha: 1)
        label.font = .cerealFont(ofSize: 13)
        label.text = "36 Guild Street London, UK"
        view.addSomeSubviews(imageView, label)
        label.snp.makeConstraints { make in
            make.leading.equalTo(imageView.snp.trailing).offset(5)
        }
        return view
    }()
    
    private lazy var eventName: UILabel = {
        var view = UILabel()
        view.textColor = .black
        view.font = .systemFont(ofSize: 18, weight: .medium)
        view.text = "International Band Music Concert"
        return view
    }()
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        contentView.layer.cornerRadius = 15
        contentView.layer.masksToBounds = true
        contentView.backgroundColor = .white
        
    
        contentView.addSomeSubviews(imageView, eventName,eventLocation)
        setupImageView()
        setupFriendsStack()
        
        setupLayout()
        contentView.disableChildrenTAMIC()
        
        eventName.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(14)
            make.top.equalTo(imageView.snp.bottom).offset(14)
        }
        eventLocation.snp.makeConstraints { make in
            make.top.equalTo(friendsView.snp.bottom).offset(34)
            make.leading.equalToSuperview().offset(16)
        }
        
    }
    
    //    func configure(with new: New) {
    //        categoryNameLabel.text = new.category
    //        newNameLabel.text = new.name
    //        newImageView.image = UIImage(named: String(new.imageID))
    //    }
    
    private func setupImageView() {
        imageView.image = UIImage(named: "hands")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 15
        
        
        let bluredViewForDate = UIView()
        bluredViewForDate.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.7).cgColor
        bluredViewForDate.layer.cornerRadius = 10
        
        imageView.addSubview(bluredViewForDate)
        bluredViewForDate.addSubview(eventDate)
        
        eventDate.textColor = UIColor(red: 0.941, green: 0.39, blue: 0.354, alpha: 1)
        if #available(iOS 16.0, *) {
            eventDate.font = .systemFont(ofSize: 12, weight: .ultraLight, width: .compressed)
        } else {
            eventDate.font = .systemFont(ofSize: 12, weight: .ultraLight)
        }
        eventDate.numberOfLines = 0
        eventDate.textAlignment = .center
        eventDate.text = "10\nJune"
        
        let bluredViewForBookmark = UIButton()
        bluredViewForBookmark.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.7).cgColor
        bluredViewForBookmark.setImage(.bookmarkFill, for: .normal)
        bluredViewForBookmark.layer.cornerRadius = 10
        
        imageView.addSubview(bluredViewForBookmark)
        
        bluredViewForDate.snp.makeConstraints { make in
            make.width.height.equalTo(45)
            make.leading.top.equalToSuperview().inset(8)
        }
        eventDate.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        bluredViewForBookmark.snp.makeConstraints { make in
            make.width.height.equalTo(30)
            make.trailing.top.equalToSuperview().inset(8)
        }
    }
    
    private func setupFriendsStack() {
        
        friendsView.backgroundColor = .clear
        let friendOneImageView = UIImageView(image: .friend1)
        let friendTwoImageView = UIImageView(image: .friend2)
        let friendThreeImageView = UIImageView(image: .friend3)
        let aboutGoingLabel = UILabel()
        aboutGoingLabel.text = "+20 Going"
        aboutGoingLabel.font = .systemFont(ofSize: 12, weight: .medium)
        aboutGoingLabel.textColor =  UIColor(red: 0.247, green: 0.22, blue: 0.867, alpha: 1)
        friendsView.addSomeSubviews(friendOneImageView,friendTwoImageView,friendThreeImageView, aboutGoingLabel)
        
        contentView.addSubview(friendsView)
        friendsView.snp.makeConstraints { make in
            make.top.equalTo(eventName.snp.bottom).offset(10)
            make.leading.equalToSuperview().inset(16)
        }
        friendTwoImageView.snp.makeConstraints { make in
            make.leading.equalTo(friendThreeImageView).offset(16)
        }
        friendOneImageView.snp.makeConstraints { make in
            make.leading.equalTo(friendTwoImageView).offset(16)
        }
        aboutGoingLabel.snp.makeConstraints { make in
            make.leading.equalTo(friendOneImageView.snp.trailing).offset(10)
            make.top.equalToSuperview().offset(5)
        }
        
    }
    
    private func setupLayout() {
        
        imageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(9)
            make.height.equalTo(contentView.snp.height).dividedBy(2)
        }
    }
    
    //    func configureCell(image: URL?, topic: String, news: String/*, newsData: News*/) {
    //        categoryNameLabel.text = topic
    //        newNameLabel.text = news
    //        
    //        if let image = image {
    //            newImageView.kf.setImage(with: image)
    //        } else {
    //            newImageView.image = UIImage(named: "berlin")
    //        }
    //    }}
}
@available(iOS 17.0, *)
#Preview {ExploreViewController()
}
