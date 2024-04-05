//
//  SignUpCoordinator.swift
//  KingBurger
//
//  Created by Maxwell Farias on 08/08/23.
//

import Foundation
import UIKit

class SignUpCoordinator {
    let navigationController: UINavigationController
    var parentCoodinator: SignInCoordinator?
    
    init (navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start () {
        let interactor = SignUpInteractor()
        
        let viewModel = SignUpViewModel(interactor: interactor)
        viewModel.coordinator = self
        
        let signUpVC = SignUpViewController()
        signUpVC.viewModel = viewModel
        
        navigationController.pushViewController(signUpVC, animated: true)
    }
    
    func login() {
        navigationController.popViewController(animated: true)
    }
    
}
