//
//  Untitled.swift
//  WorldNewsApp
//
//  Created by Igor Guryan on 29.10.2024.
//

import UIKit


protocol CityCheckerDelegate: AnyObject {
    func didChangeCity()
}

final class SearchCell: UICollectionViewCell, UITextFieldDelegate {
    static let identifier = String(describing: SearchCell.self)
    
    weak var delegate: CityCheckerDelegate?
    
    var notificationButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "bell"), for: .normal)
//        button.addTarget(SearchCell.self, action: #selector (notificationButtonTapped), for: .touchUpInside)
        return button
    }()
    
    var selectLocationButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "vector"), for: .normal)
        button.setTitleColor(UIColor(red: 1, green: 1, blue: 1, alpha: 0.7), for: .normal)
        button.setTitle("Current Location  ", for: .normal)
        button.semanticContentAttribute = .forceRightToLeft
        button.titleLabel?.font = .systemFont(ofSize: 12)
        return button
    }()
    
    private var selectedLoacationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 13)
        return label
    }()
    
    var textField = UITextField()
    var searchView = UIView()
    var filterButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 15
        button.backgroundColor = .accent
        button.setImage(UIImage(named: "filter-circle"), for: .normal)
        button.setTitle(" Filters", for: .normal)
        button.titleLabel?.font = .cerealFont(ofSize: 12)
        return button
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
        setupSearchView()
        setupCurrentCity()
        selectLocationButton.menu = setupLocationMenu()
        selectLocationButton.showsMenuAsPrimaryAction = true
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
	
    private func setupLocationMenu() -> UIMenu {
        let cities = City.allCases
        var menuItems: [UIAction] = []
        
        for city in cities {
            menuItems.append(UIAction(title: city.cityName) { action in
                DefaultsManager.citySlug = city.rawValue
                self.setupCurrentCity()
                self.delegate?.didChangeCity()
            }
            )}
        var demoMenu: UIMenu {
            return UIMenu(title: "Выбирите город", image: nil, identifier: nil, options: [], children: menuItems)
        }
        return demoMenu
        
        
    }
    
    private func setupCurrentCity() {
        let city = DefaultsManager.citySlug
        selectedLoacationLabel.text = City.allCases.first(where: { $0.rawValue == city })?.cityName
    }
    
    private func setupSearchView() {
        let glassButton = UIButton()
        glassButton.setImage(UIImage(named: "search"), for: .normal)
        let stroke = UIImageView(image: UIImage(named: "stroke"))
//        textField.text = "Search"
        textField.placeholder = "Search..."
        textField.attributedPlaceholder = NSAttributedString(string: "Search...", attributes: [.foregroundColor: UIColor(red: 1, green: 1, blue: 1, alpha: 0.3)])
        textField.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        textField.font = .cerealFont(ofSize: 20.3)
        
        searchView.addSomeSubviews(glassButton, stroke, textField, filterButton)
        
        searchView.disableChildrenTAMIC()
        
        glassButton.snp.makeConstraints { make in
            make.leading.equalToSuperview()
        }
        stroke.snp.makeConstraints { make in
            make.leading.equalTo(glassButton.snp.trailing).offset(10)
            make.top.equalToSuperview().offset(2)
        }
        textField.snp.makeConstraints { make in
            make.leading.equalTo(stroke.snp.trailing).offset(7)
            make.top.equalTo(stroke).offset(-5)
        }
        
        filterButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(46)
            make.top.equalToSuperview().inset(-5)
            make.size.equalTo(CGSize(width: 75, height: 32))
        }
        
    }
    
//    @objc func notificationButtonTapped() {
//        print("Notification Button Tapped")
//    }
    
    private func setupCell() {
        contentView.addSomeSubviews(selectLocationButton,selectedLoacationLabel, notificationButton, searchView)
        contentView.disableChildrenTAMIC()
        
        selectLocationButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(28)
            make.topMargin.equalToSuperview().offset(16)
        }
        selectedLoacationLabel.snp.makeConstraints { make in
            make.top.equalTo(selectLocationButton.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(29)
        }
        notificationButton.snp.makeConstraints { make in
            make.topMargin.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-22)
        }
        searchView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(28)
            make.trailing.equalToSuperview().offset(-22)
            make.top.equalTo(selectedLoacationLabel.snp.bottom).offset(30)
            make.width.equalToSuperview()
            make.height.equalTo(40)
        }
    }
	
	@objc private func selectLocationButtonTapped() {
		
	}
}

@available(iOS 17.0, *)
#Preview {ExploreViewController()
}
