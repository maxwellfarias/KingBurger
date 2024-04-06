//
//  Views.swift
//  KingBurger
//
//  Created by Maxwell Farias on 11/09/23.
//

import UIKit

extension UIView {
    func findViewByTag(tag: Int) -> UIView? {
        for subview in subviews {
            if subview.tag == tag {
                return subview
            }
        }
        return nil
    }
}
