//
//  HomeCoordinator.swift
//  KingBurger
//
//  Created by Maxwell Farias on 10/08/23.
//

import UIKit

protocol HomeCoordinatorFlow {
    func start()
    func goToLogin()
}

class HomeCoordinator: HomeCoordinatorFlow {
    
    private let window: UIWindow?
    
    let navFeedVC = UINavigationController()
    let navProfileVC = UINavigationController()
    let navCouponVC = UINavigationController()
    var signInCoordinator: SignInCoordinator?
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    func start() {
        let homeVC = HomeViewController()
        
        let feedCoordinator: FeedCoordinatorFlow = FeedCoordinator(navFeedVC, self)
        feedCoordinator.start()
        
        let profileCoodinator = ProfileCoordinator(navProfileVC, self)
        profileCoodinator.start()
        
        let couponCoodinator = CouponCoordinator(navCouponVC, self)
        couponCoodinator.start()
        
        homeVC.setViewControllers([navFeedVC, navProfileVC, navCouponVC], animated: true)
        window?.rootViewController = homeVC
    }
    
    func goToLogin() {
        signInCoordinator = SignInCoordinator(window: window)
        signInCoordinator?.start()
    }
}

