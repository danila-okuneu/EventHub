//
//  ProfileViewController.swift
//  EventHub
//
//  Created by Team #1 on 15.11.24.
//

import UIKit
import SnapKit


final class ExploreViewController: UIViewController, UITextFieldDelegate {
	
    private let networkService = NetworkService()
    private var upcommingEvents: [EventType] = []
    
    private let collectionView: UICollectionView = .createCollectionView(with: .eventsLayout())
    private var sections: [ExploreSection] = ExploreSection.allCases
    private let categories: [String] = ["Sports", "Music", "Food", "Art"]
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.frame = view.bounds
        scrollView.contentSize = contentSize
        return scrollView
    }()
    
    private var contentSize: CGSize {
        CGSize(width: view.frame.width, height: view.frame.height + 10)
    }
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = .white
        contentView.frame.size = contentSize
        return contentView
    }()
    
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
        getUpcommingEvents()
	}
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        scrollView.frame = view.bounds
    }
    
    private func getUpcommingEvents() {
        networkService.getEventsList {[weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let events):
                    self?.upcommingEvents = events
                    self?.collectionView.reloadData()
                case.failure(let error):
                    self?.shwoErrorAllertWith(error: error)
                    
                }
            }
        }
    }
    
    private func shwoErrorAllertWith(error: NetworkError) {
        let allert = UIAlertController(title: "Ошибка", message: error.errorText, preferredStyle: .alert)
        allert.addAction(UIAlertAction(title: "OK", style: .default))
        present(allert, animated: true)
    }
	
    
    private func configureCollectionView() {
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(blueView)
        contentView.addSubview(collectionView)
        collectionView.backgroundColor = UIColor(red: 0.312, green: 0.334, blue: 0.534, alpha: 0.06)
        collectionView.register(CategorieCell.self, forCellWithReuseIdentifier: CategorieCell.identifier)
        collectionView.register(EventCell.self , forCellWithReuseIdentifier: EventCell.identifier)
        collectionView.register(SectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeaderView.identifier)
        collectionView.register(SearchCell.self, forCellWithReuseIdentifier: SearchCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        
//        scrollView.snp.makeConstraints{ make in
//            make.edges.equalTo(view)
//        }
//        contentView.snp.makeConstraints{ make in
//            make.top.leading.trailing.equalTo(scrollView)
//            make.width.equalTo(scrollView)
//            make.height.equalTo(1500)
//        }
        
        blueView.snp.makeConstraints{ make in
            make.top.equalTo(contentView.snp.top).offset(-300)
            make.width.equalToSuperview()
            make.height.equalTo(470)
        }
        collectionView.snp.makeConstraints{ make in
            make.top.equalTo(contentView.snp.top)
            make.leading.trailing.equalTo(contentView)
            make.bottom.equalTo(contentView.snp.bottom)
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
            if upcommingEvents.count > 0 {
                cell.configureCell(with: upcommingEvents[indexPath.row])
            }
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
