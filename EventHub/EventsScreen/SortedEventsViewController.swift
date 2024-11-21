//
//  SortedEventsViewController.swift
//  EventHub
//
//  Created by Надежда Капацина on 21.11.2024.
//

import UIKit
final class SortedEventsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Property
    
    var sortedEvents: [Event] = []

    var collectionView: UICollectionView = {
           let layout = UICollectionViewFlowLayout()
           let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
           cv.translatesAutoresizingMaskIntoConstraints = false
           cv.backgroundColor = .white
           return cv
       }()
  
    
    // MARK: - Life Cicle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = .appGray
                setupCollectionView()
                loadMockData() // Загрузка моковых данных
            }

    private func loadMockData() {

        sortedEvents = [Event(image: UIImage(named: "2")!, date: "Wed, Apr 28 • 5:30 PM", title: "Jo Malone London’s Mother’s Day Presents", location: "Radius Gallery • Santa Cruz, CA"),
               Event(image: UIImage(named: "1")!, date: "Fri, Apr 26 • 6:00 PM", title: "International Kids Safe Parents Night Out", location: "Lot 13 • Oakland, CA")]
           
           collectionView.reloadData()
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
        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])

}


    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        sortedEvents.count
            }


func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EventCollectionViewCell.identifier, for: indexPath) as! EventCollectionViewCell
        
        let event = sortedEvents[indexPath.item]
         cell.configure(with: event, isbookmarkHidden: true)
        return cell
    }

// MARK: - UICollectionViewDelegateFlowLayout

func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: collectionView.bounds.width, height: 140)
}

}

