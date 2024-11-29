//
//  SearchBarVC.swift
//  EventHub
//
//  Created by Надежда Капацина on 24.11.2024.
//

import UIKit

protocol SearchViewControllerDelegate: AnyObject {
    func startTyping()
    func endTyping()
}

class SearchBarVC: UIViewController {
    
    // MARK: - Properties
    
    var sortedEvents: [EventType] = [EventType(id: 1, dates: [DateElement(start: 1, end: 1)], title: "Событие", place: Place(id: 1, address: "адрес", title: "название"), bodyText: "Какое-то текст", images: [Image(image: "https://media.kudago.com/thumbs/640x384/images/event/ae/00/ae00ceb74547eee173d2cfc5f74d93b2.jpg", source: Source(name: "Имя", link: "Ссылка"))], favoritesCount: 30, shortTitle: "Короткое название")]
    var allEvents: [Event] = []
    var events: [EventType] = [EventType(id: 1, dates: [DateElement(start: 1, end: 1)], title: "Событие", place: Place(id: 1, address: "адрес", title: "название"), bodyText: "Какое-то текст", images: [Image(image: "https://media.kudago.com/thumbs/640x384/images/event/ae/00/ae00ceb74547eee173d2cfc5f74d93b2.jpg", source: Source(name: "Имя", link: "Ссылка"))], favoritesCount: 30, shortTitle: "Короткое название")]

    private var collectionView: UICollectionView!
    
    private var gestureRecognizer = UITapGestureRecognizer()
    let searchBar = CustomSearchBar()
    
    let errorLabel: UILabel = {
        let element = UILabel()
        element.text = "NO RESULTS"
        element.textColor = .black
        element.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        element.textAlignment = .center
        element.isHidden = true
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupLayout()
        setupGestureRecognizer()
    }
    
    // MARK: - Setup
    
    private func setupUI() {
        view.backgroundColor = .appGray
        searchBar.delegate = self
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: -10, right: 0)
        collectionView.register(EventCollectionViewCell.self, forCellWithReuseIdentifier: EventCollectionViewCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupLayout() {
        view.addSubview(searchBar)
        view.addSubview(errorLabel)
        view.addSubview(collectionView)
         
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 110),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            searchBar.heightAnchor.constraint(equalToConstant: 40),
            
            errorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            errorLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 20),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupGestureRecognizer() {
        gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(endTyping))
        gestureRecognizer.isEnabled = false
        view.addGestureRecognizer(gestureRecognizer)
    }


private func filterEvents(for searchText: String) {
       if searchText.isEmpty {
           events = sortedEvents
       } else {
           events = sortedEvents.filter { event in
               return event.title.lowercased().contains(searchText.lowercased())
           }
       }
       collectionView.reloadData()
   }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
extension SearchBarVC:  UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = events.count
        errorLabel.isHidden = count > 0
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EventCollectionViewCell.identifier, for: indexPath) as? EventCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let event = events[indexPath.item]
        cell.configure(with: event, isbookmarkHidden: true, isLocationHidden: true)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 140)
    }
    
}

extension SearchBarVC: SearchViewControllerDelegate {
    
    func startTyping() {
        gestureRecognizer.isEnabled = true
    }
    
    @objc func endTyping() {
        gestureRecognizer.isEnabled = false
        _ = searchBar.resignFirstResponder()
        guard let text = searchBar.textField.text else { return }
        filterEvents(for: text)
    }
    
    @objc func searchButtonTapped() {
        endTyping()
        guard let text = searchBar.textField.text else { return }
        filterEvents(for: text)
       
    }

}

