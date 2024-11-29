//
//  ProfileViewController.swift
//  EventHub
//
//  Created by Team #1 on 15.11.24.
//

import UIKit


// MARK: - Mock Data

struct Event {
    let image: UIImage
    let date: String
    let title: String
    let location: String
   
}

//let mockEvent: [Event] = [
//    Event(image: UIImage(named: "2")!, date: "Wed, Apr 28 • 5:30 PM", title: "Jo Malone London’s Mother’s Day Presents", location: "Radius Gallery • Santa Cruz, CA"),
//    Event(image: UIImage(named: "1")!, date: "Fri, Apr 26 • 6:00 PM", title: "International Kids Safe Parents Night Out", location: "Lot 13 • Oakland, CA"),
// 
//]

protocol FavouritesViewControllerDelegate: AnyObject {
    func didCloseFavouritesScreen()
}

class FavouritesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // MARK: - Property
    var events: [EventType] = []
    weak var delegate: FavouritesViewControllerDelegate?
    
    private let emptyView = EmptyView()
    
//    private var events = mockEvent
    //private var events: [Event] = []
    private var collectionView: UICollectionView!
    private let headerHeightWithNoData: CGFloat = 350
    private let headerHeightWithData: CGFloat = 0
    
//    init(with events: [EventType]) {
//        super.init(nibName: nil, bundle: nil)
//        self.events = events
//        
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    
    // MARK: - Life Cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .appGray

        
        if events.isEmpty {
            setupEmptyView()
        }
        else {
            setupCollectionView()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        delegate?.didCloseFavouritesScreen()
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: -10, right: 0)
        
        
        collectionView.register(EventCollectionViewCell.self, forCellWithReuseIdentifier: EventCollectionViewCell.identifier)
        
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 104),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EventCollectionViewCell.identifier, for: indexPath) as! EventCollectionViewCell
        
        let event = events[indexPath.item]
        cell.configure(with: event, isbookmarkHidden: false, isLocationHidden: false)
        return cell
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 140)
    }
    
}

