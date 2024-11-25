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

struct FavouriteEvent {
    let id: String
    let title: String
    let imageURL: String
    let place: String
    let date: String
}

let event = FavouriteEvent(id: "100", title: "Jazz music", imageURL: "1", place: "Concert Hall", date: "Fri, Apr 26 • 6:00 PM")


class FavouritesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // MARK: - Property
    
    private let emptyView = EmptyView()
    
    private var events: [FavouriteEvent] = []
    private var collectionView: UICollectionView!
    private let headerHeightWithNoData: CGFloat = 350
    private let headerHeightWithData: CGFloat = 0
    
    private let favouriteEventStore = FavouriteEventStore()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .appGray
        
        //saveEvent(event)
        fetchEvents()
        
        if events.isEmpty {
            setupEmptyView()
        }
        else {
            setupCollectionView()
        }
    }
    
    // MARK: - Core Data Operations
    
    private func fetchEvents() {
        events = favouriteEventStore.fetchAllEvents()
    }
    
    private func saveEvent(_ event: FavouriteEvent) {
        favouriteEventStore.saveEvent(event)
        fetchEvents()
    }
    
    private func deleteEvent(withId id: String) {
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
        }
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 140)
    }
    
}

