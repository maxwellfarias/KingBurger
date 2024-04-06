//
//  LoadingButton.swift
//  KingBurger
//
//  Created by Maxwell Farias on 16/08/23.
//

import Foundation
import UIKit

class KBLoadingButton: UIView {
    
    lazy var button: UIButton = {
        let btn = UIButton()
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 12
        return btn
    }()
    
    let progress: UIActivityIndicatorView = {
        let p = UIActivityIndicatorView()
        p.translatesAutoresizingMaskIntoConstraints = false
        p.color = .white
        return p
    }()
    
    
    var title: String? {
        willSet {
            button.setTitle(newValue, for: .normal)
        }
    }
    
    var titleColor: UIColor? {
        willSet {
            button.setTitleColor(newValue, for: .normal)
        }
    }
    
    override var backgroundColor: UIColor? {
        willSet {
            button.backgroundColor = newValue
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 12
        applyViewCode()
    }
    //    This function is used by the SB so that it can create an object and store it in bytes. As the SB is not being used because it is being done programmatically, it is mandatory to implement it and give a fatal error to anyone trying to use it in the SB.
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addTarget(_ target: Any?, action: Selector) {
        button.addTarget(target, action: action, for: .touchUpInside)
    }
    
    func startLoading (_ loading: Bool) {
        button.isEnabled = !loading
        if loading {
            button.setTitle("", for: .normal)
            progress.startAnimating()
            alpha = 0.5
        } else {
            button.setTitle(title, for: .normal)
            progress.stopAnimating()
            alpha = 1
        }
    }
    
    func enabledButton (isEnabled: Bool) {
        button.isEnabled = isEnabled
        if isEnabled {
            button.alpha = 1
        } else {
            button.alpha = 0.5
        }
    }
}


extension KBLoadingButton: ViewCodeProtocol {
    func buildViewHierarchy() {
        addSubview(button)
        addSubview(progress)
        
    }
    
    func setupConstraints() {
        
        self.heightAnchor.constraint(equalToConstant: 50).isActive = true

        let btnConstraints = [
                    button.leadingAnchor.constraint(equalTo: leadingAnchor),
                    button.trailingAnchor.constraint(equalTo: trailingAnchor),
                    button.heightAnchor.constraint(equalTo: heightAnchor)
                ]
                
                let progressConstraints = [
                    progress.topAnchor.constraint(equalTo: topAnchor),
                    progress.bottomAnchor.constraint(equalTo: bottomAnchor),
                    progress.leadingAnchor.constraint(equalTo: leadingAnchor),
                    progress.trailingAnchor.constraint(equalTo: trailingAnchor)
                ]
                
                NSLayoutConstraint.activate(btnConstraints)
                NSLayoutConstraint.activate(progressConstraints)
    
    }
    
}
