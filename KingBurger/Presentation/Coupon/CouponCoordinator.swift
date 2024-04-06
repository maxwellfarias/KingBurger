//
//  CouponCoordinator.swift
//  KingBurger
//
//  Created by Maxwell Farias on 11/09/23.
//

import UIKit

protocol CouponCoordinatorFlow {
    func start()
}

class CouponCoordinator: CouponCoordinatorFlow {
    
    private let navigationController: UINavigationController
    var parentCoordinator: HomeCoordinatorFlow
    
    init(_ navigationController: UINavigationController, _ parentCoordinator: HomeCoordinatorFlow) {
        self.navigationController = navigationController
        self.parentCoordinator = parentCoordinator
    }
    
    func start() {
                let interactor = CouponInteractor()
                let viewModel = CouponViewModel(interactor: interactor)
                viewModel.coordinator = self
        
        let CouponVC = CouponViewController(style: .plain)
            CouponVC.viewModel = viewModel
        
        navigationController.pushViewController(CouponVC, animated: true)
    }
    
}
