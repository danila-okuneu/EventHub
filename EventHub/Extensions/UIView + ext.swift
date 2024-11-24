//
//  UIView + ext.swift
//  EventHub
//
//  Created by Igor Guryan on 17.11.2024.
//

import UIKit.UIView

extension UIView {
    func addSomeSubviews(_ views: UIView...) {
        views.forEach {
            self.addSubview($0)
        }
    }
    
    func disableChildrenTAMIC() {
        subviews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
}
