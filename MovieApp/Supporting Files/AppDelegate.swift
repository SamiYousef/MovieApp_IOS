//
//  AppDelegate.swift
//  MovieApp
//
//  Created by Sami Youssef on 8/18/18.
//  Copyright © 2018 Sami Youssef. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let movieListController = MovieListController(collectionViewLayout: UICollectionViewFlowLayout())
        let navigationController = UINavigationController(rootViewController: movieListController)
        navigationController.view.backgroundColor = .white
        window = UIWindow()
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        return true
    }

}

