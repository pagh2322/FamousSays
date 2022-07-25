//
//  RootTabBarViewController.swift
//  FamousSaying
//
//  Created by peo on 2022/07/22.
//

import UIKit

final class RootTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabber()
    }

    private func setupTabber() {
        let homeTab = UINavigationController(rootViewController: HomeViewController())
        homeTab.title = "Home"
        let favoriteTab = UINavigationController(rootViewController: FavoriteViewController())
        favoriteTab.title = "Favorites"
        let settingTab = UINavigationController(rootViewController: SettingViewController())
        settingTab.title = "Setting"
        
        let tabs = NSArray(objects: homeTab, favoriteTab, settingTab)
        self.setViewControllers(tabs as? [UIViewController], animated: false)
        
        guard let items = self.tabBar.items else { return }
        
        let images = ["house.fill", "star.fill", "gearshape.fill"]
        
        for index in 0..<3 {
            items[index].image = UIImage(systemName: images[index])
        }
    }
}

