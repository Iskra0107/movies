//
//  TabBarViewController.swift
//  Movies
//
//  Created by Iskra Gjorgjievska on 26.4.23.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        UITabBar.appearance().barTintColor = .black
        tabBar.tintColor = .white
        tabBar.isTranslucent = true
        setupVC()
    }
    
    func setupVC(){
        viewControllers = [
            createNavController(for: HomeViewController(),
                                image: UIImage(named: "home-icon")!),
            createNavController(for: SearchBarViewController(),
                                image: UIImage(named:"search")!),
            createNavController(for: FavouriteMovieViewController(),
                                image: UIImage(named: "heartTabBar")!),
        ]
    }
    
    private func createNavController(for rootViewController: UIViewController,image: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.image = image
        navController.navigationBar.prefersLargeTitles = false
        return navController
    }
}
