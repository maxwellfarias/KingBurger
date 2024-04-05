//
//  SignInCoordinator.swift
//  KingBurger
//
//  Created by Maxwell Farias on 08/08/23.
//

import Foundation
import UIKit


class SignInCoordinator {
    private let window: UIWindow?
    private let navigationController: UINavigationController
    
    init (window: UIWindow?) {
        self.window = window
        navigationController = UINavigationController()
    }
    
    func start () {
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        let interactor = SignInInteractor()
        let signInVC = SignInViewController()
        let viewModel = SignInViewModel(interactor: interactor)
        viewModel.coordinate = self
        signInVC.viewModel = viewModel
        
        
        navigationController.pushViewController(signInVC, animated: true)
    }
    
    func signUp () {
        let signUpCoordinator = SignUpCoordinator (navigationController: navigationController)
        signUpCoordinator.parentCoodinator = self
        signUpCoordinator.start()
    }
    
    func home() {
        let homeCoordinator = HomeCoordinator(window: window)
        homeCoordinator.signInCoordinator = self 
        homeCoordinator.start()
    }
}
