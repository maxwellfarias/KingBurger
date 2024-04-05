//
//  ProfileState.swift
//  KingBurger
//
//  Created by Maxwell Farias on 07/09/23.
//

import Foundation

enum ProfileState: Equatable {
    static func == (lhs: ProfileState, rhs: ProfileState) -> Bool {
        switch(lhs, rhs) {
            case (.loading, .loading):
                return true
            default:
                return false
        }
    }
    
    case loading
    case success(UserResponse)
    case error(String)
}
