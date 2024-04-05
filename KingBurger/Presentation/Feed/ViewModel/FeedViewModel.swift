//
//  FeedViewModel.swift
//  KingBurger
//
//  Created by Maxwell Farias on 05/09/23.
//

import Foundation

protocol FeedViewModelDelegate {
    func viewModelDidChanged(state: FeedState)
}

class FeedViewModel {
    
    var coordinator: FeedCoordinator?
    
    var delegate: FeedViewModelDelegate?
    
    var state: FeedState = .loading {
        didSet {
            delegate?.viewModelDidChanged(state: state)
        }
    }
    
    private let interactor: FeedInteractor
    
    init(interactor: FeedInteractor) {
        self.interactor = interactor
    }
    
    func fetch() {
        state = .loading
        interactor.fetch() { response, error in
            DispatchQueue.main.async {
                if let errorMessage = error {
                    self.state = .error(errorMessage)
                } else {
                    if let response = response{
                        self.state = .success(response.categories)
                    }


                }
            }
        }
    }
    
    func fetchHighlight() {
        interactor.fetchHighlight() { response, error in
            DispatchQueue.main.async {
                if let errorMessage = error {
                    self.state = .error(errorMessage)
                } else if let response = response {
                    self.state = .successHighlight(response)
                }
            }
        }
        
    }
    
    func logout () {
        interactor.logout()
        coordinator?.goToLogin()
    }
    
    func goToProductDetail(id: Int) {
        coordinator?.goToProductDetail(productId: id)
    }    
}
