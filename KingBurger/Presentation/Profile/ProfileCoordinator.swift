//
//  ProfileCoordinator.swift
//  KingBurger
//
//  Created by Maxwell Farias on 07/09/23.
//

import UIKit

class ProfileCoordinator {
    
    private let navigationController: UINavigationController
    
    var parentCoordinator: HomeCoordinator?
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let interactor = ProfileInteractor()
        let viewModel = ProfileViewModel(interactor: interactor)
        viewModel.coordinator = self
        
        let profileVC = ProfileViewController()
        profileVC.viewModel = viewModel
        
        
//        TIRAR DAQUI  O CODUGO E COLOCAR NO VIEWCONTROLLER
        
        navigationController.tabBarItem.image = UIImage(systemName: "person.circle")
        navigationController.tabBarItem.title = "Profile"
        
        navigationController.pushViewController(profileVC, animated: true)
    }
    
}
