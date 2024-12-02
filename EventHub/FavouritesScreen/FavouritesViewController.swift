//
//  ProfileViewController.swift
//  EventHub
//
//  Created by Team #1 on 15.11.24.
//

import UIKit


protocol FavouritesViewControllerDelegate: AnyObject {
    func didCloseFavouritesScreen()
}

class FavouritesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // MARK: - Property
    weak var delegate: FavouritesViewControllerDelegate?
    private let favouriteEventStore = FavouriteEventStore()
    
    private let emptyView = EmptyView()
    
	private var events: [Event] = []
    
    private var collectionView: UICollectionView!
    private let headerHeightWithNoData: CGFloat = 350
    private let headerHeightWithData: CGFloat = 0
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .appGray
        
        fetchEvents()
        checkForEmpty()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavBar()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        delegate?.didCloseFavouritesScreen()
    }
    
    // MARK: - Core Data Operations
    private func fetchEvents() {
        events = favouriteEventStore.fetchAllEvents()
    }
    
	private func saveEvent(_ event: Event) {
        favouriteEventStore.saveEvent(event)
        fetchEvents()
    }
    
	private func deleteEvent(withId id: Int) {
        favouriteEventStore.deleteEvent(withId: id)
        fetchEvents()
        collectionView.reloadData()
    }
    
    // MARK: - Setup Views
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: -10, right: 0)
        
        
        collectionView.register(EventCollectionViewCell.self, forCellWithReuseIdentifier: EventCollectionViewCell.identifier)
        collectionView.register(FavouriteEventCollectionViewCell.self, forCellWithReuseIdentifier: FavouriteEventCollectionViewCell.identifier)
        
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 104),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
    }
    
    private func checkForEmpty() {
        if events.isEmpty {
            setupEmptyView()
        }
        else {
            setupCollectionView()
        }
    }
    
    private func setupEmptyView() {
        view.addSubview(emptyView)
        emptyView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emptyView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            emptyView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            emptyView.topAnchor.constraint(equalTo: view.topAnchor),
            emptyView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return events.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavouriteEventCollectionViewCell.identifier, for: indexPath) as! FavouriteEventCollectionViewCell
        
        let event = events[indexPath.item]
        cell.configure(with: event, isbookmarkHidden: false)
        
        cell.onDelete = { [weak self] in
            guard let self = self else { return }
            self.deleteEvent(withId: event.id)
            checkForEmpty()
            
        }
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 140)
    }
	
	    
    // MARK: - setupNavBar
        private func setupNavBar() {
            guard let navBar = self.navigationController?.navigationBar else { return }
            navBar.tintColor = .black
            
            navBar.standardAppearance.titleTextAttributes = [.foregroundColor: UIColor.black, .font: UIFont.systemFont(ofSize: 22, weight: .semibold)]
            navBar.standardAppearance.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 0)
            navBar.scrollEdgeAppearance?.titleTextAttributes = [.foregroundColor: UIColor.black, .font: UIFont.systemFont(ofSize: 22, weight: .semibold)]
            navBar.scrollEdgeAppearance?.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 0)
            
            
            
            navigationItem.title = "Favorites"
            navigationController?.navigationBar.tintColor = .black
            navigationItem.titleView?.tintColor = .black
            
        let searchButton = UIButton(type: .system)
            searchButton.setImage(UIImage(named: "searchBlue"), for: .normal)
            searchButton.tintColor = .black
            searchButton.addTarget(self, action: #selector(searchButtonAction), for: .touchUpInside)

            searchButton.semanticContentAttribute = .forceRightToLeft
            navigationItem.rightBarButtonItem = UIBarButtonItem(customView: searchButton)
            
            
            
            
            
    }
        
        
        @objc private func searchButtonAction() {
            
            let searchVC = SearchBarVC()
            navigationController?.pushViewController(searchVC, animated: true)
        }
}


extension FavouritesViewController: UICollectionViewDelegate {
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		
	
		let event = FavouriteEventStore().fetchAllEvents()
		
		guard event.count > indexPath.row else { return }
		
		let vc = DetailsViewController(event: event[indexPath.row])
		vc.modalPresentationStyle = .overCurrentContext
		self.navigationController?.pushViewController(vc, animated: true)
		self.navigationController?.navigationBar.isHidden = false
		
		
	}
	
}
