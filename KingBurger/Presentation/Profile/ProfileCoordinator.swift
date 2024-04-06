//
//  ProfileCoordinator.swift
//  KingBurger
//
//  Created by Maxwell Farias on 07/09/23.
//

import UIKit

protocol ProfileCoordinatorFlow {
    func start()
}

class ProfileCoordinator: ProfileCoordinatorFlow {
    
    private let navigationController: UINavigationController
    private let parentCoordinator: HomeCoordinatorFlow
    
    init(_ navigationController: UINavigationController, _ parentCoordinator: HomeCoordinatorFlow) {
        self.navigationController = navigationController
        self.parentCoordinator = parentCoordinator
    }
    
    func start() {
        let interactor = ProfileInteractor()
        let viewModel = ProfileViewModel(interactor: interactor)
        viewModel.coordinator = self
        
        let profileVC = ProfileViewController()
        profileVC.viewModel = viewModel
    
        navigationController.pushViewController(profileVC, animated: true)
    }
}
