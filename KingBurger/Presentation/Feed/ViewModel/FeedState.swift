//
//  FeedState.swift
//  KingBurger
//
//  Created by Maxwell Farias on 05/09/23.
//

import Foundation

enum FeedState {
    case loading
    case success ([CategoryResponse])
    case successHighlight(HighlightResponse)
    case error(String)
}
