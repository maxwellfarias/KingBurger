//
//  Checkbox.swift
//  KingBurger
//
//  Created by Maxwell Farias on 27/09/23.
//

import UIKit

class Checkbox: UIButton {
    // Images
    let checkedImage = UIImage(systemName: "checkmark.square")!
    let uncheckedImage = UIImage(systemName: "square")!
    
    // Bool property
    var isChecked: Bool = false {
        didSet {
            if isChecked == true {
                self.setImage(checkedImage, for: UIControl.State.normal)
            } else {
                self.setImage(uncheckedImage, for: UIControl.State.normal)
            }
        }
    }
  
    
    override func awakeFromNib() {
        self.addTarget(self, action:#selector(buttonClicked(sender:)), for: UIControl.Event.touchUpInside)
        self.isChecked = false
    }
        
    @objc func buttonClicked(sender: UIButton) {
        if sender == self {
            isChecked = !isChecked
        }
    }
}
