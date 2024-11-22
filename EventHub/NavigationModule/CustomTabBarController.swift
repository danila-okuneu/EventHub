//
//  CustomTabBarController.swift
//  EventHub
//
//  Created by Vika on 18.11.24.
//

import UIKit

class CustomTabBarController: UITabBarController, CustomTabBarDelegate {
    
    private let customTabBar = CustomTabBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        customTabBar.delegate = self
        setValue(customTabBar, forKey: "tabBar")
        setupTabItems()
    }
    
    // MARK: - Настройка вкладок
    
    private func setupTabItems() {
        
        let exploreVC = ExploreViewController()  // Передаем первый элемент массива
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
        
        // Оборачиваем все view controllers в UINavigationController
        let exploreNav = UINavigationController(rootViewController: exploreVC)
        let eventsNav = UINavigationController(rootViewController: eventsVC)
        let mapNav = UINavigationController(rootViewController: mapVC)
        let profileNav = UINavigationController(rootViewController: profileVC)
        
        setViewControllers([exploreNav, eventsNav, emptyVC, mapNav, profileNav], animated: false)
    }
    
    // MARK: - Go to favorites
    
    func didTapFavoriteButton() {
        print("didTapFavoriteButton called!") // Проверяем вызов метода
        print("Current controllers count: \(self.viewControllers?.count ?? 0)")

        // Создаем контроллер "Избранное"
        let favoritesVC = FavouritesViewController()
        let favoritesNav = UINavigationController(rootViewController: favoritesVC)
        
        // Получаем текущие контроллеры
        guard var controllers = self.viewControllers, controllers.count > 2 else {
            print("Error: Not enough view controllers!")
            return
        }
        
        // Проверяем, что мы заменяем центральный контроллер
        controllers[2] = favoritesNav
        self.viewControllers = controllers
        
        // Устанавливаем центральный индекс
        self.selectedIndex = 2
        
        print("Switched to Favorites tab.")
    }

}
