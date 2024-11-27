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

class SearchBarVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    // MARK: - Properties
    
    var sortedEvents: [Event] = mockEvent
    var allEvents: [Event] = []
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
        setupCollectionView()
        setupView()
        setupGestureRecognizer()
    }
    
    // MARK: - Setup
    
    private func setupView() {
        view.addSubview(searchBar)
        view.addSubview(errorLabel)
        view.backgroundColor = .appGray
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 110),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            searchBar.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            errorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            errorLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
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
            collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 20),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupGestureRecognizer() {
        gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(endTyping))
        gestureRecognizer.isEnabled = false
        view.addGestureRecognizer(gestureRecognizer)
    }
    
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = sortedEvents.count
        errorLabel.isHidden = count > 0
        return count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EventCollectionViewCell.identifier, for: indexPath) as? EventCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let event = sortedEvents[indexPath.item]
        cell.configure(with: event, isbookmarkHidden: true)
        return cell
    }


// MARK: - UICollectionViewDelegateFlowLayout

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
    }
    
    @objc func searchButtonTapped() {
        endTyping()
        guard let text = searchBar.textField.text else { return }
        if text != "" {

        }
    }
}
