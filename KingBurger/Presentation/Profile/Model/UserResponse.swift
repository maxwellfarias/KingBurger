//
//  UserResponse.swift
//  KingBurger
//
//  Created by Maxwell Farias on 07/09/23.
//

import Foundation

struct UserResponse: Decodable {
    
    let id: Int
    let name: String
    let email: String
    let document: String
    let birthday: String
   
}
