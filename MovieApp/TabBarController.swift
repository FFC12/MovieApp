//
//  TabBarController.swift
//  MovieApp
//
//  Created by Furkan Fatih Cetindil on 13.05.2024.
//

import UIKit

class TabBarController: UITabBarController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.viewControllers = [HomeTabBar, SearchTabBar, ProfileTabBar]
    }
    
    lazy public var HomeTabBar: UIViewController = {
        let vc = HomeViewController()
        vc.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        return vc
    }()
    
    lazy public var SearchTabBar: UIViewController = {
        let vc = SearchViewController()
        vc.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 1)
        return vc
    }()
    
    lazy public var ProfileTabBar: UIViewController = {
        let vc = ProfileViewController()
        vc.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), tag: 2)
        return vc
    }()
}

extension TabBarController: UITabBarControllerDelegate {
     func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return true
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        print("Selected item: \(item.title ?? "")")
    }
}
