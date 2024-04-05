//
//  FeedCoordinator.swift
//  KingBurger
//
//  Created by Maxwell Farias on 06/09/23.
//

import UIKit

class FeedCoordinator {
    
    private let navigationController: UINavigationController
    
    var parentCoordinator: HomeCoordinator?
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
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
        parentCoordinator?.goToLogin()
    }
    
}
