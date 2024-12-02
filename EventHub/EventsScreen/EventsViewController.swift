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
	private var isDataLoaded = false
	
    var upcomingEvents: [Event] = []
    var pastEvents: [Event] = []
	let network = NetworkService()
	
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
        setupSegmentedControl()
        setupCollectionView()
		setupEmptyView()
		setupExploreButton()
		Task {
			try? await loadCollectionData() // Загрузка моковых данных
		}
		
		segmentedControl.change(cornerRadiusPercent: 0.5, segmentInset: 5)
        
        navigationItem.title = "Events"
	}

    
    func setupSegmentedControl() {
        view.addSubview(segmentedControl)
        NSLayoutConstraint.activate([
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            segmentedControl.heightAnchor.constraint(equalToConstant: 45)
])
        segmentedControl.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
    }
    
    @objc private func segmentChanged() {
		print(segmentedControl.selectedSegmentIndex)
			collectionView.reloadData()
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
        let sortedVC = SeeAllEvenetsViewController(with: upcomingEvents)
        navigationController?.pushViewController(sortedVC, animated: true)

            }
    
    private func updateEmptyViewVisibility() {
           let hasData = isShowingUpcomingEvents ? !upcomingEvents.isEmpty : !pastEvents.isEmpty
           emptyView.isHidden = hasData
       }
	private func loadCollectionData() async throws {
		
		async let upcomingEvents = network.getEventsList(type: .nextWeek)
		async let pastEvents = network.getEventsList(type: .pastWeek)
        var past = try await pastEvents
        let actualUntil = Int(Date().timeIntervalSince1970)
        let actualSince = actualUntil - 60 * 60 * 24 * 7
        past = past.filter { event in
            let validDates = event.dates.map{$0.end}.filter({ $0 >= actualSince && $0 <= actualUntil })
            return !validDates.isEmpty
        }.map { event in
            var mutableEvent = event
            mutableEvent.dates = event.dates.filter { $0.end ?? 0 >= actualSince && $0.end ?? 0 <= actualUntil }
            return mutableEvent
        }.sorted { event1, event2 in
            
            let date1 = event1.dates.compactMap({ $0.end }).max() ?? 0
            let date2 = event2.dates.compactMap({ $0.end }).max() ?? 0
            return date1 > date2
        }
		self.upcomingEvents = try await upcomingEvents

        self.pastEvents = past
		
		isDataLoaded = true
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
        collectionView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 10),
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
		print(isShowingUpcomingEvents)
		
		guard isDataLoaded else { return 8 }
		
		return isShowingUpcomingEvents ? upcomingEvents.count : pastEvents.count
	}
	
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EventCollectionViewCell.identifier, for: indexPath) as! EventCollectionViewCell
		
		guard isDataLoaded else { return cell }
		
		let event = isShowingUpcomingEvents ? upcomingEvents[indexPath.item] : pastEvents[indexPath.item]
		
		cell.configure(with: event, isbookmarkHidden: true, isLocationHidden: false)
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		
		guard isDataLoaded else { return }
		let event = isShowingUpcomingEvents ? upcomingEvents[indexPath.item] : pastEvents[indexPath.item]
		
		let vc = DetailsViewController(event: event)
		vc.modalPresentationStyle = .currentContext
		self.navigationController?.pushViewController(vc, animated: true)
		
	}
	
	// MARK: - UICollectionViewDelegateFlowLayout
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: collectionView.bounds.width, height: 140)
	}
	
}


