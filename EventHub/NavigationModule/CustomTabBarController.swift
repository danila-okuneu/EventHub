//
//  CustomTabBarController.swift
//  EventHub
//
//  Created by Vika on 18.11.24.
//

import UIKit

class CustomTabBarController: UITabBarController, CustomTabBarDelegate, UINavigationControllerDelegate {
    
    private let customTabBar = CustomTabBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setValue(customTabBar, forKey: "tabBar")
        customTabBar.customDelegate = self
        
        setupTabItems()
    }
    
    private func setupTabItems() {
        let exploreVC = UINavigationController(rootViewController: ExploreViewController())
        exploreVC.tabBarItem.title = "Explore"
        exploreVC.tabBarItem.image = UIImage(named: "explore")
        
        let eventsVC = UINavigationController(rootViewController: EventsViewController())
        eventsVC.tabBarItem.title = "Events"
        eventsVC.tabBarItem.image = UIImage(named: "calendar")
        
        let emptyVC = UINavigationController(rootViewController:UIViewController())
        emptyVC.tabBarItem.title = " "
        emptyVC.tabBarItem.image = nil
        
        let mapVC = UINavigationController(rootViewController:MapViewController())
        mapVC.tabBarItem.title = "Map"
        mapVC.tabBarItem.image = UIImage(named: "Location")
        
        let profileVC = UINavigationController(rootViewController:ProfileViewController())
        profileVC.tabBarItem.title = "Profile"
        profileVC.tabBarItem.image = UIImage(named: "Profile")
        
        setViewControllers([ exploreVC,
                            eventsVC,
                            emptyVC,
                            mapVC,
                            profileVC],
                            animated: false)
    }
    
    func didTapFavoriteButton() {
        


        let favouritesVC = UINavigationController(rootViewController:FavouritesViewController())
        favouritesVC.tabBarItem.title = ""
        favouritesVC.tabBarItem.image = UIImage(named: "favorites")
        favouritesVC.delegate = self
        

        var controllers = viewControllers ?? []
        controllers[2] = favouritesVC
        setViewControllers(controllers, animated: true)
        selectedIndex = 2
        
        customTabBar.updateFavoriteButtonColor(to: .appRed)
    }
}

extension CustomTabBarController: FavouritesViewControllerDelegate {
    func didCloseFavouritesScreen() {
        customTabBar.updateFavoriteButtonColor(to: .accent)
    }
}
