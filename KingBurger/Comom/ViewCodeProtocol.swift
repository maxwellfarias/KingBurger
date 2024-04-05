//
//  ViewCodeProtocol.swift
//  KingBurger
//
//  Created by Maxwell Farias on 08/08/23.
//

import Foundation

public protocol ViewCodeProtocol {
    func buildViewHierarchy ()
    func setupConstraints ()
    func configureViews ()
}

public extension ViewCodeProtocol {
    func applyViewCode () {
        buildViewHierarchy()
        setupConstraints()
        configureViews()
    }
//    make this method optional
    func configureViews () {}
}
