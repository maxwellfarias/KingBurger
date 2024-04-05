//
//  SignInInteractor.swift
//  KingBurger
//
//  Created by Maxwell Farias on 04/09/23.
//

import Foundation
//this class has the function of dividing the logic to make calls to the remote server and to make local calls.
class SignInInteractor {
    let remote: SignInRemoteDataSource = .shared
    
    func login (request: SignInRequest, completion: @escaping (String?) -> Void) {
        remote.login(request: request){ response, error in
            if let r = response {
                let userAuth = UserAuth(accessToken: r.accessToken,
                                        refreshToken: r.refreshToken,
                                        expiresSeconds: Int(Date().timeIntervalSince1970 + Double(r.expiresSeconds)),
                                        tokenType: r.tokenType)
                
                LocalDataSource.shared.insertUserAuth(userAuth: userAuth)
            }
            
            completion(error)
        }
    }
}
