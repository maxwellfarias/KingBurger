//
//  TextViewForm.swift
//  KingBurger
//
//  Created by Maxwell Farias on 17/08/23.
//

import Foundation
import UIKit

class TextFieldForm: UITextField {
    
    unowned var scrollView: UIScrollView
    
    required init (_ scrollView: UIScrollView) {
        self.scrollView = scrollView
        super.init(frame: .zero)
        setup ()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup () {
        layer.borderWidth = 1
        layer.borderColor = UIColor.systemBlue.cgColor
        layer.cornerRadius = 12
        setLeftPaddingPoints(15)
        translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(onKeyBoardNotification), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onKeyBoardNotification), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
//        dismissKeyboard
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        scrollView.superview!.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard(_ view: UITapGestureRecognizer) {
        scrollView.superview!.endEditing(true)
    }
    
    //    The function is triggered with the keyboard event and extracts the keyboard frame in order to add it later to the ScrollView content, giving the effect that the content rises when the keyboard appears.
    @objc func onKeyBoardNotification (_ notification: Notification) {
        let visible = notification.name == UIResponder.keyboardWillShowNotification
        let keyboardFrame = visible ? UIResponder.keyboardFrameEndUserInfoKey : UIResponder.keyboardFrameBeginUserInfoKey
        if let keyboardSize = (notification.userInfo?[keyboardFrame] as? NSValue)?.cgRectValue{
            onKeyBoardChanged (visible, height: keyboardSize.height)
        }
        
    }
    //    Adds or removes the keyboard frame to the scrollView's content.
    func  onKeyBoardChanged (_ visible: Bool, height: CGFloat) {
        if (!visible) {
            scrollView.contentInset = .zero
            scrollView.scrollIndicatorInsets = .zero
//Apparently when adjusting the size, the scrollbar goes all the way down, making the content fit just above the keyboard.
            scrollView.contentSize = scrollView.superview!.frame.size
        } else {
            scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: height + 40, right: 0)
            scrollView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: height + 40, right: 0)
            let aRect = scrollView.superview!.frame
            scrollView.contentSize = aRect.size
        }
    }
    
    
    
    
}

