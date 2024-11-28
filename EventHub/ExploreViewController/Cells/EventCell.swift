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
    private let pinImageView = UIImageView(image: .mappin)
    
    private var eventAdrress: UILabel = {
        var label = UILabel()
        label.textColor = UIColor(red: 0.167, green: 0.157, blue: 0.287, alpha: 1)
        label.font = .cerealFont(ofSize: 13)
        label.text = "Адрес"
        return label
    }()
    
    private lazy var eventName: UILabel = {
        var view = UILabel()
        view.textColor = .black
        view.font = .systemFont(ofSize: 18, weight: .medium)
        view.text = "International Band Music Concert"
        return view
    }()
    
    let bookmarkButton: UIButton = {
        let button = UIButton()
        button.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.7).cgColor
        button.setImage(.bookmarkFill, for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(didTap), for: .touchUpInside)
        return button
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
        
        
        contentView.addSomeSubviews(imageView,bookmarkButton, eventName, pinImageView, eventAdrress)
        setupImageView()
        setupFriendsStack()
        
        setupLayout()
        contentView.disableChildrenTAMIC()
        
        eventName.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(14)
            make.top.equalTo(imageView.snp.bottom).offset(14)
        }
    }
        
        private func setupImageView() {
            imageView.image = UIImage(named: "hands")
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.layer.cornerRadius = 15
            imageView.disableChildrenTAMIC()
            
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
            
            
            
            //        imageView.addSubview(bluredViewForBookmark)
            
            bluredViewForDate.snp.makeConstraints { make in
                make.width.height.equalTo(45)
                make.leading.top.equalToSuperview().inset(8)
            }
            eventDate.snp.makeConstraints { make in
                make.center.equalToSuperview()
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
    
    @objc func didTap() {
        print("bookmark tapped")
    }
    
    private func setupLayout() {
        
        imageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(9)
            make.height.equalTo(contentView.snp.height).dividedBy(2)
//            make.width.equalTo(contentView.snp.width).inset(9)
        }
        
        bookmarkButton.snp.makeConstraints { make in
            make.width.height.equalTo(30)
            make.trailing.top.equalToSuperview().inset(16)
        }
        
        pinImageView.snp.makeConstraints { make in
            make.top.equalTo(friendsView.snp.bottom).offset(36)
            make.leading.equalToSuperview().offset(16)
            
        }
        
        eventAdrress.snp.makeConstraints { make in
            make.top.equalTo(friendsView.snp.bottom).offset(34)
            make.leading.equalTo(pinImageView).inset(20)
            make.trailing.equalToSuperview().inset(16)
            
        }
        
    }
    
    func configureCell(with data: EventType) {
        
        if  data.shortTitle != "" {
            eventName.text = data.shortTitle
        } else {
            eventName.text = data.title
        }
        
        
        eventDate.text = "30 марта"
        if  data.place?.address != "" {
            eventAdrress.text = data.place?.address
        } else {
            eventAdrress.text = data.place?.title
        }
        
        if let image = data.images.first?.image {
            imageView.kf.setImage(with: URL(string: image))
            } else {
                imageView.image = UIImage(named: "hands")
            }
        }
}
@available(iOS 17.0, *)
#Preview {ExploreViewController()
}
