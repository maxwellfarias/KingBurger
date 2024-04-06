//
//  TextField.swift
//  KingBurger
//
//  Created by Maxwell Farias on 22/08/23.
//

import Foundation
import UIKit

protocol TextFieldDelegate: UITextFieldDelegate {
    func textFieldDidChanged(isValid: Bool, bitmask: Int, text: String)
}

class KBTextField: UIView {
    
    private lazy var tf: UITextField = {
        let tf = UITextField()
        tf.layer.borderWidth = 1
        tf.layer.borderColor = UIColor.systemGray.cgColor
        tf.layer.cornerRadius = 12
        tf.setLeftPaddingPoints(15)
        tf.addTarget(self, action: #selector(textFieldDidChanged), for: .editingChanged)
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    private let errorLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = .systemRed
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    var maskField: Mask?
    
    var bitmask: Int = 0
    
    var text: String {
        get {
            return tf.text!
        }
    }
    
    var placeholder: String? {
        willSet{
            tf.placeholder = newValue
        }
    }
    
    var returnKeyType: UIReturnKeyType = .next {
        willSet{
            tf.returnKeyType = newValue
        }
    }
    
    var keyBoardType: UIKeyboardType = .default {
        willSet {
            if newValue == .emailAddress {
//                Make the first letter lower case
                tf.autocapitalizationType = .none
            }
            tf.keyboardType = newValue
        }
    }
    var isSecureTextEntry: Bool = false {
        willSet {
            tf.isSecureTextEntry = newValue
//            This code is placed to stop a bug that keeps showing a yellow background in the password field.
            tf.textContentType = .oneTimeCode
        }
    }
    
    //    Type: An optional function with no parameters that returns a boolean. This function will receive a rule that will be passed when implementing the form
    var failure: ((String) -> Bool)?
    
    var error: String?
    
    var heightConstraint: NSLayoutConstraint!
    
    var delegate: TextFieldDelegate? {
        willSet{
            tf.delegate = newValue
        }
    }
    
    
    //    The tag outside this class was assigned to the existing tag variable in the UIView. It is necessary to pass this same value to the textField, as the delegate comparison is based on it.
    override var tag: Int {
        willSet {
            super.tag = newValue
            tf.tag = newValue
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        applyViewCode()
  
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func textFieldDidChanged (_ textField: UITextField) {
        
        guard let failure = failure else {return}
        guard let text = textField.text else {return}
        
        if let mask = maskField {
            if let resp = mask.process(value: text) {
                tf.text = resp
            }
           
        }
        
            if failure(text) {
                errorLabel.text = error
                heightConstraint.constant = 70
                delegate?.textFieldDidChanged(isValid: false,  bitmask: bitmask, text: tf.text!)
            } else {
                errorLabel.text = ""
                heightConstraint.constant = 50
                delegate?.textFieldDidChanged(isValid: true,  bitmask: bitmask, text: tf.text!)
            }
        
        layoutIfNeeded()
    }
    
    func gainFocus() {
        tf.becomeFirstResponder()
    }
}

extension KBTextField: ViewCodeProtocol {
    func buildViewHierarchy() {
        addSubview(tf)
        addSubview(errorLabel)
    }
    
    func setupConstraints() {
        let tfConstraints = [
            tf.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tf.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tf.heightAnchor.constraint(equalToConstant: 50)
        ]
        let errorLabelConstraints = [
            errorLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            errorLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            errorLabel.topAnchor.constraint(equalTo: tf.bottomAnchor)
        ]
        heightConstraint = self.heightAnchor.constraint(equalToConstant: 50)
        heightConstraint.isActive = true
        
        NSLayoutConstraint.activate(tfConstraints)
        NSLayoutConstraint.activate(errorLabelConstraints)
    }
    
    
}

