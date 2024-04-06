//
//  SignInCoordinator.swift
//  KingBurger
//
//  Created by Maxwell Farias on 08/08/23.
//

import Foundation
import UIKit

protocol SignInCoordinatorFlow {
    func signUp()
    func home()
    func start()
}

class SignInCoordinator: SignInCoordinatorFlow {
    private let window: UIWindow?
    private let navigationController: UINavigationController
    
    init (window: UIWindow?) {
        self.window = window
        navigationController = UINavigationController()
    }
    
    func start() {
        let interactor = SignInInteractor()
        let viewModel = SignInViewModel(coordinate: self, interactor: interactor)
        let signInVC = SignInViewController(viewModel)
        


        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        navigationController.pushViewController(signInVC, animated: true)
    }
    
    func signUp() {
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
