//
//  CouponCoordinator.swift
//  KingBurger
//
//  Created by Maxwell Farias on 11/09/23.
//

import UIKit

class CouponCoordinator {
    
    private let navigationController: UINavigationController
    
    var parentCoordinator: HomeCoordinator?
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
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
