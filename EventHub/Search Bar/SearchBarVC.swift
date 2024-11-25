//
//  SearchBarVC.swift
//  EventHub
//
//  Created by Надежда Капацина on 24.11.2024.
//

import UIKit

class CustomSearchBar: UIView {
    
    let textField = UITextField()
    private let searchButton = UIButton()
    
    var filterButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 15
        button.backgroundColor = .accent
        button.setImage(UIImage(named: "filter-circle"), for: .normal)
        button.setTitle(" Filters", for: .normal)
        button.titleLabel?.font = .cerealFont(ofSize: 12)
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
        
        searchButton.setImage(UIImage(named: "search"), for: .normal)
        let stroke = UIImageView(image: UIImage(named: "stroke"))
        
        textField.placeholder = "Search..."
        textField.attributedPlaceholder = NSAttributedString(string: "Search...", attributes: [.foregroundColor: UIColor(red: 1, green: 1, blue: 1, alpha: 0.3)])
        textField.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        textField.font = .cerealFont(ofSize: 20.3)
        
        
    }
    
    
    
    private func setupConstraints() {
        //        searchButton.snp.makeConstraints { make in
        //                make.leading.equalToSuperview()
        //            }
        //            stroke.snp.makeConstraints { make in
        //                make.leading.equalTo(searchButton.snp.trailing).offset(10)
        //                make.top.equalToSuperview().offset(2)
        //            }
        //            textField.snp.makeConstraints { make in
        //                make.leading.equalTo(stroke.snp.trailing).offset(7)
        //                make.top.equalTo(stroke).offset(-5)
        //            }
        //
        //            filterButton.snp.makeConstraints { make in
        //                make.trailing.equalToSuperview().inset(46)
        //                make.top.equalToSuperview().inset(-5)
        //                make.size.equalTo(CGSize(width: 75, height: 32))
        //            }
        //    }
        
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


