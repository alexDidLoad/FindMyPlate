//
//  FYPTabBar.swift
//  FindMyPlate
//
//  Created by Alexander Ha on 1/30/21.
//

import UIKit

class FYPTabBar: UITabBarController {
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    //MARK: - Helpers
    
    private func createHomeNC() -> UINavigationController {
        let homeVC              = FYPHomeVC()
        homeVC.title            = "Find My Plate"
        homeVC.tabBarItem       = UITabBarItem(title: "Home", image: SFSymbols.home, tag: 0)
        
        return UINavigationController(rootViewController: homeVC)
    }
    
    
    private func createFavoritesNC() -> UINavigationController {
        let favoritesVC             = FYPFavoritesVC()
        favoritesVC.title           = "Favorites"
        favoritesVC.tabBarItem      = UITabBarItem(title: "Favorites", image: SFSymbols.heart, tag: 1)
        
        return UINavigationController(rootViewController: favoritesVC)
    }
    
    
    private func configureUI() {
        
        UITabBar.appearance().tintColor = .systemRed
        viewControllers                 = [createHomeNC(), createFavoritesNC()]
    }
    
}
