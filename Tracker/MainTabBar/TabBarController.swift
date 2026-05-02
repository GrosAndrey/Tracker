//
//  TabBarController.swift
//  Tracker
//
//  Created by Андрей Грошев on 28.04.2026.
//

import UIKit

final class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    private func configure() {
        let trackerViewController = TrackersViewController()
        let statisticsViewController = StatisticsViewController()
        
        let trackerNav = UINavigationController(rootViewController: trackerViewController)
        let statisticsNav = UINavigationController(rootViewController: statisticsViewController)
        
        trackerNav.tabBarItem = UITabBarItem(
            title: "",
            image: UIImage(resource: .tabTrackerActive),
            tag: 0
        )
        
        statisticsNav.tabBarItem = UITabBarItem(
            title: "",
            image: UIImage(resource: .tabStatActive),
            tag: 1
        )
        
        viewControllers = [trackerNav, statisticsNav]
    }
}
