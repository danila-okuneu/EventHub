//
//  ProfileViewController.swift
//  EventHub
//
//  Created by Team #1 on 15.11.24.
//

import UIKit
import SnapKit


final class ExploreViewController: UIViewController, UITextFieldDelegate {
	
    private let collectionView: UICollectionView = .createCollectionView(with: .eventsLayout())
    private var sections: [ExploreSection] = ExploreSection.allCases
    private let categories: [String] = ["Sports", "Music", "Food", "Art"]
    
    lazy var blueView: UIView = {
        let view = UIView()
        view.backgroundColor = .appPurpleDark
        view.layer.cornerRadius = 40
        view.clipsToBounds = true
        return view
    }()
    
	override func viewDidLoad() {
        view.backgroundColor = .white
        configureCollectionView()
	}
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
	
    
    private func configureCollectionView() {
        
        view.addSubview(blueView)
        view.addSubview(collectionView)
        collectionView.backgroundColor = UIColor(red: 0.312, green: 0.334, blue: 0.534, alpha: 0.06)
        collectionView.register(CategorieCell.self, forCellWithReuseIdentifier: CategorieCell.identifier)
        collectionView.register(EventCell.self , forCellWithReuseIdentifier: EventCell.identifier)
        collectionView.register(SectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeaderView.identifier)
        collectionView.register(SearchCell.self, forCellWithReuseIdentifier: SearchCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        blueView.snp.makeConstraints{ make in
            make.top.equalTo(view.snp.top).offset(-100)
            make.width.equalTo(view)
            make.height.equalTo(330)
        }
    }
    
}


extension ExploreViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch sections[section] {
        case .search:
            return 1
        case .categories:
            return categories.count
        case .upcoming:
            return 10
        case .nearby:
            return 10
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = sections[indexPath.section]
        switch section {
        case .search:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCell.identifier, for: indexPath) as! SearchCell
            cell.textField.delegate = self
            return cell
        case .categories:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategorieCell.identifier, for: indexPath) as! CategorieCell
            cell.configureCell(with: categories[indexPath.row])
            return cell
        case .upcoming, .nearby:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EventCell.identifier, for: indexPath) as! EventCell
            return cell
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeaderView.identifier, for: indexPath) as! SectionHeaderView
        if sections[indexPath.section] == .upcoming {
            header.configure(with: "Upcomming events", isButtonHidden: false, buttonTitle: "See All", tapAction: didTapSeeAll)
            return header
        } else if sections[indexPath.section] == .nearby {
            header.configure(with: "Nearby you", isButtonHidden: false, buttonTitle: "See All", tapAction: didTapSeeAll)
            return header
        }
        return header
    }
    
    @objc func didTapSeeAll() {
        //Нажатие кнопки seeAll
    }
}

@available(iOS 17.0, *)
#Preview {ExploreViewController()
}
