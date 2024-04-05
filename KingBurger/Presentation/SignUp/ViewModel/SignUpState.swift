//
//  SignUpState.swift
//  KingBurger
//
//  Created by Maxwell Farias on 09/08/23.
//

import Foundation

enum SignUpState {
    case none
    case loading
    case goToLogin
    case error (String)
}
