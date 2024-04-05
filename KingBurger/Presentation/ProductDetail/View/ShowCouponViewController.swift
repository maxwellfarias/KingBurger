//
//  TestViewController.swift
//  KingBurger
//
//  Created by Maxwell Farias on 16/09/23.
//

import UIKit
import SwiftUI

class ShowCouponViewController: UIViewController {
    
    
    let mainContainer: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let couponView: CouponView = {
        let v = CouponView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    lazy var closeBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "closeIcon"), for: .normal)
        btn.addTarget(self, action: #selector(couponTapped), for: .touchUpInside)
        return btn
    }()

    
    let blurredEffectView = UIVisualEffectView(effect:  UIBlurEffect(style: .regular))

    override func viewDidLoad() {
        super.viewDidLoad()
      applyViewCode()
        navigationItem.rightBarButtonItem =  UIBarButtonItem(customView: closeBtn)

        
     
    }
    
    @objc func couponTapped() {
        dismiss(animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        blurredEffectView.frame = view.bounds
    }


}

extension ShowCouponViewController: ViewCodeProtocol {
    func buildViewHierarchy() {
        view.addSubview(blurredEffectView)
        view.addSubview(mainContainer)
        mainContainer.addSubview(couponView)
    }
    
    func setupConstraints() {
        

        NSLayoutConstraint.activate([
            mainContainer.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            mainContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            couponView.topAnchor.constraint(equalTo: mainContainer.topAnchor),
            couponView.leadingAnchor.constraint(equalTo: mainContainer.leadingAnchor),
            couponView.trailingAnchor.constraint(equalTo: mainContainer.trailingAnchor)
        ])
    }
    
    
}



