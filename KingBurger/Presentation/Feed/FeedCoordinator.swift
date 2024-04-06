//
//  FeedCoordinator.swift
//  KingBurger
//
//  Created by Maxwell Farias on 06/09/23.
//

import UIKit

protocol FeedCoordinatorFlow {
    func start()
    func goToProductDetail(productId: Int)
    func goToLogin()
}

class FeedCoordinator: FeedCoordinatorFlow {
    
    private let navigationController: UINavigationController
    private let parentCoordinator: HomeCoordinatorFlow
    
    init(_ navigationController: UINavigationController, _ parentCoordinator: HomeCoordinatorFlow) {
        self.navigationController = navigationController
        self.parentCoordinator = parentCoordinator
    }
    
    func start() {
        let interactor = FeedInteractor()
        
        let viewModel = FeedViewModel(interactor: interactor)
        viewModel.coordinator = self
        
        let feedVC = FeedViewController()
        feedVC.viewModel = viewModel
        
        navigationController.pushViewController(feedVC, animated: true)
    }
    
    func goToProductDetail(productId: Int) {
        let coordinator = ProductDetailCoordinator(navigationController, id: productId)
        coordinator.parentCoordinator = self
        coordinator.start()
    }
    
    func goToLogin () {
        parentCoordinator.goToLogin()
    }
    
}
