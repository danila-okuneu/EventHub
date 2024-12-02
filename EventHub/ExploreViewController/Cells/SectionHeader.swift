//
//  SectionHeader.swift
//  EventHub
//
//  Created by Igor Guryan on 17.11.2024.
//

import UIKit

class SectionHeaderView: UICollectionReusableView {
    
    static let identifier = String(describing: SectionHeaderView.self)
    
    var buttonEvent: (() -> Void)?
    
    lazy var maintitle: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 18, weight: .medium)
        view.textAlignment = .left
        view.text = "Section title"
        return view
    }()
    
    lazy var button: UIButton = {
        let view = UIButton()
        view.titleLabel?.font = .cerealFont(ofSize: 14)
        view.setTitleColor(UIColor(red: 0.456, green: 0.464, blue: 0.534, alpha: 1), for: .normal)
        view.titleLabel?.textAlignment = .right
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(maintitle)
        addSubview(button)
        disableChildrenTAMIC()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            maintitle.topAnchor.constraint(equalTo: topAnchor),
            maintitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 6),
            maintitle.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            button.trailingAnchor.constraint(equalTo: trailingAnchor),
            button.bottomAnchor.constraint(equalTo: bottomAnchor),
            button.topAnchor.constraint(equalTo: topAnchor),
            button.leadingAnchor.constraint(equalTo: maintitle.trailingAnchor, constant: -6)
        ])
        
    }
    
    func configure(with title: String,
//                   titleFont: Font,
                   isButtonHidden: Bool = true,
                   buttonTitle: String?,
                   tapAction: @escaping () -> Void) {
        maintitle.text = title
        maintitle.textColor = .black
        button.setTitle(buttonTitle, for: .normal)
        buttonEvent = tapAction
        button.isHidden = isButtonHidden
    }
    
  	
    
}
