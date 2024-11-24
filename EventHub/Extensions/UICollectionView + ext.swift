//
//  UICollectionView + ext.swift
//  EventHub
//
//  Created by Igor Guryan on 17.11.2024.
//

import UIKit.UICollectionView

extension UICollectionView {
    static func createCollectionView(with layout: UICollectionViewLayout) -> UICollectionView {
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .systemBackground
        view.showsVerticalScrollIndicator = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
}
