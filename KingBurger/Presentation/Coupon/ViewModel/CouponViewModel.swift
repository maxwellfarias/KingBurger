//
//  CouponViewModel.swift
//  KingBurger
//
//  Created by Maxwell Farias on 12/09/23.
//

import Foundation

protocol CouponViewModelDelegate {
    func viewModelDidChanged(state: CouponState)
}
enum CouponTypeListForUrl: String {
    case expirated = "&expired=1"
    case activated = "&expired=0"
    case all = ""
}

class CouponViewModel {
    
    var coordinator: CouponCoordinator?
    
    var delegate: CouponViewModelDelegate?
    
    var state: CouponState = .loading {
        didSet {
            delegate?.viewModelDidChanged(state: state)
        }
    }
    
    private let interactor: CouponInteractor
    
    init(interactor: CouponInteractor) {
        self.interactor = interactor
    }
    
    func fetch(currentPage: Int, listType: CouponTypeListForUrl) {
        interactor.fetch(currentPage: currentPage, listType: listType) { response, error in
            DispatchQueue.main.async {
                if let errorMessage = error {
                    self.state = .error(errorMessage)
                } else {
                    if let response = response{
                        self.state = .success(response)
                    }


                }
            }
        }
    }
    
    func fetchProductDetail(id: Int, _ indexOfTheSelectedCell: Int) {
        self.state = .loading
        interactor.fetchProductDetail(id: id) { response, error in
            DispatchQueue.main.async {
                if let errorMessage = error {
                    self.state = .error(errorMessage)
                } else if let response = response {
                    self.state = .successProductDetail(response, indexOfTheSelectedCell)
                }
            }
        }
    }
    
    

    
}
