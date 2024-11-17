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
//        view.font = .systemFont(ofSize: 20, weight: .bold)
        view.textAlignment = .left
        view.text = "Section title"
        return view
    }()
    
    lazy var button: UIButton = {
        let view = UIButton()
        view.titleLabel?.font = .systemFont(ofSize: 14)
        view.setTitleColor(UIColor(red: 0.49, green: 0.51, blue: 0.63, alpha: 1), for: .normal)
        view.titleLabel?.textAlignment = .right
        view.addTarget(self, action: #selector(Self.buttonTapped), for: .touchUpInside)
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
                   titleFont: Font,
                   isButtonHidden: Bool = true,
                   buttonTitle: String?,
                   tapAction: @escaping () -> Void) {
        maintitle.text = title
        maintitle.textColor = titleFont.fontColour
        maintitle.font = titleFont.font
        button.setTitle(buttonTitle, for: .normal)
        buttonEvent = tapAction
        button.isHidden = isButtonHidden
    }
    
    @objc func buttonTapped() {
        buttonEvent?()
    }
    
}
