//
//  ProfileViewModel.swift
//  KingBurger
//
//  Created by Maxwell Farias on 07/09/23.
//

import Foundation


protocol ProfileViewModelDelegate {
    func viewModelDidChanged(state: ProfileState)
}

class ProfileViewModel {
    
    var delegate: ProfileViewModelDelegate?
    var coordinator: ProfileCoordinator?
    
    var state: ProfileState = .loading {
        didSet {
            delegate?.viewModelDidChanged(state: state)
        }
    }
    
    private let interactor: ProfileInteractor
    
    init(interactor: ProfileInteractor) {
        self.interactor = interactor
    }
    
    func fetch() {
        self.state = .loading
        interactor.fetch() { response, error in
            DispatchQueue.main.async {
                if let errorMessage = error {
                    self.state = .error(errorMessage)
                } else if let response = response {
                    self.state = .success(response)
                }
            }
        }
    }
       
}
