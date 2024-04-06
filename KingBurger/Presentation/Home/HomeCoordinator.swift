//
//  HomeCoordinator.swift
//  KingBurger
//
//  Created by Maxwell Farias on 10/08/23.
//

import UIKit

class HomeCoordinator {
    
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
        
        let feedCoordinator = FeedCoordinator(navFeedVC)
        feedCoordinator.parentCoordinator = self
        feedCoordinator.start()
        
        let profileCoodinator = ProfileCoordinator(navProfileVC)
        profileCoodinator.parentCoordinator = self
        profileCoodinator.start()
        
        let couponCoodinator = CouponCoordinator(navCouponVC)
        couponCoodinator.parentCoordinator = self
        couponCoodinator.start()
        
        homeVC.setViewControllers([navFeedVC, navProfileVC, navCouponVC], animated: true)
        
        window?.rootViewController = homeVC
    }
    
    func goToLogin() {
        signInCoordinator = SignInCoordinator(window: window)
        signInCoordinator?.start()
    }
    
}

