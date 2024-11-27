//
//  ProfileViewController.swift
//  EventHub
//
//  Created by Team #1 on 15.11.24.
//

import UIKit
import WWRoundedSegmentedControl

final class EventsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Property
    
    private let emptyView = EmptyEventView()
    
    var upcomingEvents: [Event] = []
    var pastEvents: [Event] = []

    private var isShowingUpcomingEvents: Bool {
        return segmentedControl.selectedSegmentIndex == 0
    }
    
    lazy var segmentedControl: CustomSegmentedControl = {
           let sc = CustomSegmentedControl(items: ["UPCOMING", "PAST EVENTS"])
           sc.selectedSegmentIndex = 0
           sc.selectedSegmentTintColor = .white
        sc.setTitleTextAttributes([.foregroundColor: UIColor.appPurple, .font: UIFont.cerealFont(ofSize: 16, weight: .light)], for: .selected)
            sc.setTitleTextAttributes([.foregroundColor: UIColor.gray, .font: UIFont.cerealFont(ofSize: 16, weight: .light)], for: .normal)




           sc.translatesAutoresizingMaskIntoConstraints = false
                   return sc
               }()

       
    var collectionView: UICollectionView = {
           let layout = UICollectionViewFlowLayout()
           let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
           cv.translatesAutoresizingMaskIntoConstraints = false
           cv.backgroundColor = .white
          cv.clipsToBounds = true
           return cv
       }()
       
    var exploreButtons = UIButton.createButton(icon: "right", title: "EXPLORE EVENTS")
    
    
    
    // MARK: - Life Cicle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = .appGray
                setupCollectionView()
                setupEmptyView()
                setupSegmentedControl()
                setupExploreButton()
                loadMockData() // Загрузка моковых данных
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [unowned self] in
            segmentedControl.change(cornerRadiusPercent: 0.5, segmentInset: 5)
        }
            }

    
    func setupSegmentedControl() {
        view.addSubview(segmentedControl)
        NSLayoutConstraint.activate([
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            segmentedControl.heightAnchor.constraint(equalToConstant: 45)
])
        segmentedControl.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
    }
    
    @objc private func segmentChanged() {
            if segmentedControl.selectedSegmentIndex == 0 {
                print("Selected Upcoming Events")
                loadMockData()
            } else {
                print("Selected Past Events")
                loadMockData()
            }
        }
    private func setupExploreButton() {
        view.addSubview(exploreButtons)
        
        exploreButtons.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            exploreButtons.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60),
            exploreButtons.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60),
            exploreButtons.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50)
])
        exploreButtons.addTarget(self, action: #selector(exploreButtonTapped), for: .touchUpInside)
            }

    @objc private func exploreButtonTapped() {

            }
    
    private func updateEmptyViewVisibility() {
           let hasData = isShowingUpcomingEvents ? !upcomingEvents.isEmpty : !pastEvents.isEmpty
           emptyView.isHidden = hasData
       }
    private func loadMockData() {
//           upcomingEvents = [
//            Event(image: UIImage(named: "2")!, date: "Wed, Apr 28 • 5:30 PM", title: "Jo Malone London’s Mother’s Day Presents", location: "Radius Gallery • Santa Cruz, CA"),
//            Event(image: UIImage(named: "1")!, date: "Fri, Apr 26 • 6:00 PM", title: "International Kids Safe Parents Night Out", location: "Lot 13 • Oakland, CA"),
//        ]
        upcomingEvents = []
           pastEvents = [Event(image: UIImage(named: "2")!, date: "Wed, Apr 28 • 5:30 PM", title: "Jo Malone London’s Mother’s Day Presents", location: "Radius Gallery • Santa Cruz, CA"),
               Event(image: UIImage(named: "1")!, date: "Fri, Apr 26 • 6:00 PM", title: "International Kids Safe Parents Night Out", location: "Lot 13 • Oakland, CA")]
           
           collectionView.reloadData()
           updateEmptyViewVisibility()
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
        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 170),
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
    emptyView.isHidden = true
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
        isShowingUpcomingEvents ? upcomingEvents.count : pastEvents.count
            }


func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EventCollectionViewCell.identifier, for: indexPath) as! EventCollectionViewCell
        
        let event = isShowingUpcomingEvents ? upcomingEvents[indexPath.item] : pastEvents[indexPath.item]
    cell.configure(with: event, isbookmarkHidden: true, isLocationHidden: false)
        return cell
    }

// MARK: - UICollectionViewDelegateFlowLayout

func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: collectionView.bounds.width, height: 140)
}

}


