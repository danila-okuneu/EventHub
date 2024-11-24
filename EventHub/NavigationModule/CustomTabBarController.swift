//
//  CustomTabBarController.swift
//  EventHub
//
//  Created by Vika on 18.11.24.
//

import UIKit

class CustomTabBarController: UITabBarController {
    
    private let customTabBar = CustomTabBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setValue(customTabBar, forKey: "tabBar")
        setupTabItems()
    }
    
    // MARK: - Настройка вкладок
    
    private func setupTabItems() {

        let exploreVC = ExploreViewController()
        exploreVC.tabBarItem.title = "Explore"
        exploreVC.tabBarItem.image = UIImage(named: "explore")
        
        let eventsVC = EventsViewController()
        eventsVC.tabBarItem.title = "Events"
        eventsVC.tabBarItem.image = UIImage(named: "calendar")
        
        let emptyVC = UIViewController()
        emptyVC.tabBarItem.title = " "
        emptyVC.tabBarItem.image = nil
        
        let mapVC = MapViewController()
        mapVC.tabBarItem.title = "Map"
        mapVC.tabBarItem.image = UIImage(named: "Location")
        
        let profileVC = ProfileViewController()
        profileVC.tabBarItem.title = "Profile"
        profileVC.tabBarItem.image = UIImage(named: "Profile")
        
        
        setViewControllers([exploreVC, eventsVC, emptyVC, mapVC, profileVC], animated: false)
    }
}
