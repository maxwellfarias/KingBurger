//
//  CoordinatorTest.swift
//  KingBurger
//
//  Created by Maxwell Farias on 21/09/23.
//

import UIKit


class TestCoordinator {
    private let window: UIWindow?
    private let navigationController: UINavigationController
    
    init (window: UIWindow?) {
        self.window = window
        navigationController = UINavigationController()
    }
    
    func start () {
        window?.rootViewController = navigationController
        let TestVC = TestViewController()
        navigationController.pushViewController(TestVC, animated: true)
    }
}
