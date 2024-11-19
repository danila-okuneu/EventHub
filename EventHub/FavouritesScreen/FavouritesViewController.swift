//
//  ProfileViewController.swift
//  EventHub
//
//  Created by Team #1 on 15.11.24.
//

import UIKit


// моковые данные

struct Event {
    let image: UIImage
    let date: String
    let title: String
    let location: String

}




let mockEvent: [Event] = [
    Event(image: UIImage(named: "1")!, date: "2023-11-01T19:00:00Z", title: "", location: "")
]


class FavouritesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

        private var events = mockEvent
            private var collectionView: UICollectionView!

            override func viewDidLoad() {
                super.viewDidLoad()
                view.backgroundColor = .blue
                setupCollectionView()
            }
            
            private func setupCollectionView() {
                let layout = UICollectionViewFlowLayout()
                layout.scrollDirection = .vertical
                
                collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
                collectionView.backgroundColor = .red
                collectionView.dataSource = self
                collectionView.delegate = self
                
                collectionView.register(EventCollectionViewCell.self, forCellWithReuseIdentifier: EventCollectionViewCell.identifier)
                
                view.addSubview(collectionView)
            }
            
            // MARK: - UICollectionViewDataSource
            
            func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
                return events.count
            }
            
            func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EventCollectionViewCell.identifier, for: indexPath) as! EventCollectionViewCell
                
                let event = events[indexPath.item]
                cell.configure(with: event)
                
                return cell
            }
            
            // MARK: - UICollectionViewDelegateFlowLayout
            
            func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
                return CGSize(width: collectionView.bounds.width, height: 120)
            }
            
            }

