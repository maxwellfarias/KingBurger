//
//  SignInViewModel.swift
//  KingBurger
//
//  Created by Maxwell Farias on 08/08/23.
//

import Foundation
import UIKit

protocol SignInViewModelDelegate: AnyObject {
    func viewModelDidChanged (state: SignInState)
}

class SignInViewModel {
    weak var delegate: SignInViewModelDelegate?
    var coordinate: SignInCoordinator?
    var username = ""
    var password = ""
    
    private let interactor: SignInInteractor
    init (interactor: SignInInteractor){
        self.interactor = interactor
    }
    
    
    var state: SignInState = .none {
        didSet {
            delegate?.viewModelDidChanged(state: state)
        }
    }
    
    func send () {
        state = .loading
        interactor.login(request: SignInRequest(username: username, password: password)) { error in
            
            DispatchQueue.main.async {
                // MAIN-THREAD
                if let errorMessage = error {
                    self.state = .error(errorMessage)
                } else  {
                    self.state = .goTohome
                }
            }
        }
        
    }
    
    func goToSignUp(){
        coordinate?.signUp()
    }
    
    func goToHome() {
        coordinate?.home()
    }
    
    
    
}
