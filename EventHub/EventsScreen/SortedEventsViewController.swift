//
//  SortedEventsViewController.swift
//  EventHub
//
//  Created by Надежда Капацина on 21.11.2024.
//

import UIKit
final class SortedEventsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Property
    
	var sortedEvents: [EventType] = []

   lazy var collectionView: UICollectionView = {
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
		
		sortedEvents = [
			EventType(
				id: 1,
				dates: [DateElement(start: -12321321, end: 132312312)],
				title: "Jo Malone London’s Mother’s Day Presents",
				place: Place(id: 1234, address: "sdsdsd", title: "fsfd"),
				bodyText: "Body mock 1",
				images: [],
				favoritesCount: 1,
				shortTitle: "Short title mock 1"
			),
			EventType(
				id: 2,
				dates: [DateElement(start: -12321321, end: 132312312)],
				title: "Jo Malone London’s Mother’s Day Presents",
				place: Place(id: 5678, address: "sdsdsd", title: "fsfd"),
				bodyText: "Body mock 1",
				images: [],
				favoritesCount: 1,
				shortTitle: "Short title mock 2"
			)
		]
		
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
    cell.configure(with: event, isbookmarkHidden: true, isLocationHidden: false)
        return cell
    }

// MARK: - UICollectionViewDelegateFlowLayout

func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: collectionView.bounds.width, height: 140)
}

}

class SegmentedControl: UISegmentedControl {
    override func layoutSubviews() {
      super.layoutSubviews()
      layer.cornerRadius = self.bounds.size.height / 2.0
      layer.borderColor = UIColor(red: 170.0/255.0, green: 170.0/255.0, blue: 170.0/255.0, alpha: 1.0).cgColor
      layer.borderWidth = 1.0
      layer.masksToBounds = true
      clipsToBounds = true

   }
}
