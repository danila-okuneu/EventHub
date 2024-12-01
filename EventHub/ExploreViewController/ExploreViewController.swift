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
    private var upcommingEvents: [Event] = []
    private var categoriesAll: [Category] = []
    private var selectedCategory: Int?
    
    private let collectionView: UICollectionView = .createCollectionView(with: .eventsLayout())
    private var sections: [ExploreSection] = ExploreSection.allCases
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
    
//    init(categoriesAll: [Category], selectedCategory: Int? = 1) {
//        super.init(nibName: nil, bundle: nil)
//        self.categoriesAll = categoriesAll
//    }
    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        
        
        
        configureCollectionView()
//        getUpcommingEvents()
        Task {
            await getCategories()
            await getEvents()
        }
	}
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        scrollView.frame = view.bounds
    }
    
    private func getCategories() async  {
        let categories = await CategoryProvider.shared.fetchCategoriesFromAPI()
        self.categoriesAll = categories
        self.collectionView.reloadSections(IndexSet(integer: 1))
    }
    
    private func getEvents(category : String = "") async {
        let events = await EventProvider.shared.fetchEventsFromAPI(category: category)
        self.upcommingEvents = events
        self.collectionView.reloadData()
    }
    
//    private func getEventsWithCategory(category: String) {
//        Task {
//            do {
//                let events = try await networkService.getEventsList(type: .eventsList, categories: category)
//                self.upcommingEvents = events
//                print(upcommingEvents)
//                self.collectionView.reloadData()
//            }
//            catch {
//                self.shwoErrorAllertWith(error: error as! NetworkError)
//            }
//        }
//    }
    
//    private func getUpcommingEvents() {
//        Task {
//            do {
//                let events = try await networkService.getEventsList(type: .eventsList, eventsCount: 40)
//                self.upcommingEvents = events
//                print(upcommingEvents)
//                self.collectionView.reloadData()
//            }
//            catch {
//                self.shwoErrorAllertWith(error: error as! NetworkError)
//            }
//        }
//    }
    
    
    
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
            return categoriesAll.count
        case .upcoming:
            return upcommingEvents.count
        case .nearby:
            return upcommingEvents.count
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
            cell.configureCell(with: categoriesAll[indexPath.row])
            return cell
        case .upcoming, .nearby:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EventCell.identifier, for: indexPath) as! EventCell
            if upcommingEvents.count > 0 {
                cell.configureCell(with: upcommingEvents[indexPath.row])
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let section = sections[indexPath.section]
        switch section {
        case .categories:
            Task {
                await getEvents(category: categoriesAll[indexPath.row].slug)
            }
        case .upcoming:
            break
        case .nearby:
            break
        default:
            break
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeaderView.identifier, for: indexPath) as! SectionHeaderView
        if sections[indexPath.section] == .upcoming {
            header.configure(with: "Upcomming events", isButtonHidden: false, buttonTitle: "See All", tapAction: didTapSeeAllUpcomming)
            return header
        } else if sections[indexPath.section] == .nearby {
            header.configure(with: "Nearby you", isButtonHidden: false, buttonTitle: "See All", tapAction: didTapSeeAllNearby)
            return header
        }
        return header
    }
    
    @objc func didTapSeeAllUpcomming() {
//        let vc = SortedEventsViewController(with: upcommingEvents)
//        self.navigationController?.modalPresentationStyle = .fullScreen
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @objc func didTapSeeAllNearby() {
        
    }
}
    


@available(iOS 17.0, *)
#Preview {ExploreViewController()
}
