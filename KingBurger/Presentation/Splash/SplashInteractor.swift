//
//  SplashInteractor.swift
//  KingBurger
//
//  Created by Maxwell Farias on 05/09/23.
//

import Foundation


class SplashInteractor {
    
    private let remote: SplashRemoteDataSource = .shared
    private let local: LocalDataSource = .shared
    
    func login(request: SplashRequest, accessToken: String, completion: @escaping (Bool) -> Void) {
  
        remote.login(request: request, accessToken: accessToken) { response, error in
            
            if let r = response {
                let userAuth = UserAuth(accessToken: r.accessToken,
                                        refreshToken: r.refreshToken,
                                        expiresSeconds: Int(Date().timeIntervalSince1970 + Double(r.expiresSeconds)),
                                        tokenType: r.tokenType)
                
                self.local.insertUserAuth(userAuth: userAuth)
            }
            
            completion(error)
        }
    }
    
}
