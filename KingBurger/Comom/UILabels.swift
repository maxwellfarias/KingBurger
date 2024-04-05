//
//  UILabels.swift
//  KingBurger
//
//  Created by Maxwell Farias on 25/09/23.
//

import UIKit

extension UILabel {
    func addCharactersSpacing(spacing: CGFloat, txt: String) {
        let attributedString = NSMutableAttributedString(string: txt)
        attributedString.addAttribute(NSAttributedString.Key.kern, value: spacing, range: NSRange(location: 0, length: txt.count))
        self.attributedText = attributedString
    }
}
