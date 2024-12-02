//
//  ProfileViewController.swift
//  EventHub
//
//  Created by Team #1 on 15.11.24.
//

import UIKit
import SnapKit


final class ExploreViewController: UIViewController {
	
    
    private let favouriteEventStore = FavouriteEventStore()
    
    private let networkService = NetworkService()
    private var upcommingEvents: [Event] = []
	private var nearbyEvents: [Event] = [ ]
	private var categories: [Category] = DefaultsManager.categories
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
    

    override func viewDidLoad() {
        view.backgroundColor = .white
		configureCollectionView()
        getUpcommingEvents()
	}
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        scrollView.frame = view.bounds
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
		self.navigationController?.navigationBar.isHidden = true
		self.collectionView.reloadData()
    }
    
    private func getEventsWithCategory(category: String) {
        Task {
            do {
                let events = try await networkService.getEventsList(type: .eventsList, categories: category)
                self.upcommingEvents = events
				self.collectionView.reloadData()
            }
            catch {
                self.showErrorAlert(with: error as! NetworkError)
            }
        }
    }
    
    private func getUpcommingEvents() {
        Task {
            do {
                let events = try await networkService.getEventsList(type: .eventsList, eventsCount: 40)
                self.upcommingEvents = events
				self.nearbyEvents = events.shuffled()
                self.collectionView.reloadData()
            }
            catch {
                self.showErrorAlert(with: error as! NetworkError)
            }
        }
    }
    
    
    
    private func showErrorAlert(with: NetworkError) {
        let allert = UIAlertController(title: "Ошибка", message: with.errorText, preferredStyle: .alert)
        allert.addAction(UIAlertAction(title: "OK", style: .default))
        present(allert, animated: true)
    }
	
    
    private func configureCollectionView() {
        view.addSubview(scrollView)
		
		
		scrollView.addSubview(contentView)
		contentView.addSubview(blueView)
		contentView.addSubview(collectionView)
		
		
		collectionView.snp.makeConstraints{ make in
			make.top.equalTo(contentView.snp.top)
			make.leading.trailing.equalTo(contentView)
			make.bottom.equalTo(contentView.snp.bottom)
		}
		
		blueView.snp.makeConstraints{ make in
			make.top.equalTo(contentView.snp.top).offset(-300)
			make.width.equalToSuperview()
			make.height.equalTo(470)
		}
		
		collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = UIColor(red: 0.312, green: 0.334, blue: 0.534, alpha: 0.0001)
		collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.identifier)
        collectionView.register(EventCell.self , forCellWithReuseIdentifier: EventCell.identifier)
        collectionView.register(SectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeaderView.identifier)
        collectionView.register(SearchCell.self, forCellWithReuseIdentifier: SearchCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
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
			return upcommingEvents.isEmpty ? 8 : upcommingEvents.count
        case .nearby:
			return upcommingEvents.isEmpty ? 8 : nearbyEvents.count
        }
    }
	
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = sections[indexPath.section]
        switch section {
        case .search:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCell.identifier, for: indexPath) as! SearchCell
            cell.textField.delegate = self
			cell.delegate = self
            return cell
        case .categories:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.identifier, for: indexPath) as! CategoryCell
            cell.configureCell(with: categories[indexPath.row])
            return cell
        case .upcoming, .nearby:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EventCell.identifier, for: indexPath) as! EventCell
			
			if !upcommingEvents.isEmpty {
				
				Task {
					await cell.hideSkeletons()
					cell.configureCell(with: section == .upcoming ? self.upcommingEvents[indexPath.row] : self.nearbyEvents[indexPath.row])
					cell.delegate = self
				}
				
			} else {
				DispatchQueue.main.async {
					cell.contentView.showAnimatedGradientSkeleton()
				}
				
			}
			
            return cell
        }
    }
	
	
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let section = sections[indexPath.section]
        switch section {
        case .categories:
            getEventsWithCategory(category: categories[indexPath.row].slug)
		case .upcoming, .nearby:
			guard !upcommingEvents.isEmpty else { return }
			let event = upcommingEvents[indexPath.row]
			
			let vc = DetailsViewController(event: event)
			vc.modalPresentationStyle = .currentContext
			self.navigationController?.pushViewController(vc, animated: true)
			self.navigationController?.navigationBar.isHidden = false
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
        let vc = SeeAllEvenetsViewController(with: upcommingEvents)
		self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func didTapSeeAllNearby() {
        let vc = SeeAllEvenetsViewController(with: nearbyEvents)
		self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
    

extension ExploreViewController: EventCellDelegate {
	func didTapBookmark(for event: Event) -> Bool {
		
		let events = favouriteEventStore.fetchAllEvents()
		if events.contains(where: { $0.id == event.id }) {
			favouriteEventStore.deleteEvent(withId: event.id)
			return false
		} else {
			favouriteEventStore.saveEvent(event)
			return true
		}
	}
}


extension ExploreViewController: CityCheckerDelegate {
    func didChangeCity() {
        getUpcommingEvents()
    }
}

extension ExploreViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        let vc = SearchBarVC()
        vc.searchText = textField.text
        navigationController?.pushViewController(vc, animated: true)
        return true
    }
}
//@available(iOS 17.0, *)
//#Preview {ExploreViewController()
//}
