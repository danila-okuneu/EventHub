//
//  Search Bar.swift
//  EventHub
//
//  Created by Надежда Капацина on 25.11.2024.
//


import UIKit

class CustomSearchBar: UIView {
    
    let textField = UITextField()
    private let searchButton = UIButton()
    
    var filterButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 15
        button.backgroundColor = .accent
        button.setImage(UIImage(systemName: "line.3.horizontal.decrease.circle.fill"), for: .normal)
        button.setTitle(" Filters ", for: .normal)
        button.titleLabel?.font = .cerealFont(ofSize: 12)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
        
    }()
    
    //var delegate: SearchViewControllerDelegate?
    
    
    
    init() {
        super.init(frame: .null)
        configureUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func addTarget(_ target: Any?, action: Selector, for controlEvents: UIControl.Event) {
        searchButton.addTarget(target, action: action, for: controlEvents)
    }
    
    @objc private func clearTextField() {
        textField.text = ""
    }
    
    override func resignFirstResponder() -> Bool {
        textField.resignFirstResponder()
    }
    
    
    
    private func configureUI() {
        
        self.backgroundColor = .appGray
        self.layer.cornerRadius = 5
        self.clipsToBounds = true
        
        searchButton.tintColor = .blue
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        searchButton.setImage(UIImage(named: "searchBlue"), for: .normal)
        let stroke = UIImageView(image: UIImage(named: "stroke"))
        

        textField.attributedPlaceholder = NSAttributedString(string: "   Search...", attributes: [.foregroundColor: UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)])
        textField.returnKeyType = .search
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.font = .cerealFont(ofSize: 20.3)
        textField.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        textField.leftView = stroke
        textField.leftViewMode = .always
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        filterButton.tintColor = .white
    }

    
    private func setupConstraints() {
        self.addSubview(textField)
        self.addSubview(searchButton)
        self.addSomeSubviews(filterButton)
        NSLayoutConstraint.activate([
            //searchButton.topAnchor.constraint(equalTo: self.topAnchor),
            searchButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            searchButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            
            textField.leadingAnchor.constraint(equalTo: searchButton.trailingAnchor, constant: 5),
            textField.topAnchor.constraint(equalTo: searchButton.topAnchor, constant: -5),
            textField.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            
            filterButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            filterButton.topAnchor.constraint(equalTo: textField.topAnchor, constant: 2),
            filterButton.heightAnchor.constraint(equalToConstant: 32),
            filterButton.widthAnchor.constraint(equalToConstant: 75)
        ])
    }
}
    extension CustomSearchBar: UITextFieldDelegate {
        
        func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
            // delegate?.startTyping()
            return true
        }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            searchButton.sendActions(for: .touchUpInside)
            return true
        }
        
    }

@available(iOS 17.0, *)
#Preview {CustomSearchBar()
}


