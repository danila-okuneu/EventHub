//
//  ProfileViewController.swift
//  EventHub
//
//  Created by Team #1 on 15.11.24.
//

import UIKit

final class EventsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Property
    
    private let emptyView = EmptyEventView()
    
    var upcomingEvents: [Event] = []
    var pastEvents: [Event] = []
    var displayedEvents: [Event] {
           return isShowingUpcoming ? upcomingEvents : pastEvents
       }
       
    var isShowingUpcoming = true
       
       let segmentedControl: UISegmentedControl = {
           let sc = UISegmentedControl(items: ["UPCOMING", "PAST EVENTS"])
           sc.selectedSegmentIndex = 0
           sc.translatesAutoresizingMaskIntoConstraints = false
           return sc
       }()
       
    var collectionView: UICollectionView = {
           let layout = UICollectionViewFlowLayout()
           let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
           cv.translatesAutoresizingMaskIntoConstraints = false
           cv.backgroundColor = .white
           return cv
       }()
       

    
    
    
    // MARK: - Life Cicle
    override func viewDidLoad() {
        
        if upcomingEvents.isEmpty {
            setupEmptyView()
        }
        else {
            setupCollectionView()
        }
    }
        

private func setupCollectionView() {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    
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
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EventCollectionViewCell.identifier, for: indexPath) as! EventCollectionViewCell
        
        let event = upcomingEvents[indexPath.item]
        cell.configure(with: event)
        
        return cell
    }
}
