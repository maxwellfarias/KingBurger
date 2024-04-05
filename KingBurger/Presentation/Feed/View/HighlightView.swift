//
//  HighlightView.swift
//  KingBurger
//
//  Created by Maxwell Farias on 21/08/23.
//

import Foundation
import UIKit

protocol HighlightViewDelegate {
    func highlightDidSelected (id: Int)
}

class HighlightView: UIView {
    
    let imageView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "highlight"))
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        return iv
    }()
    
    private lazy var getCouponBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Get coupon", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        btn.backgroundColor = .clear
        btn.layer.cornerRadius = 20
        btn.contentEdgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        btn.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.shadowColor = UIColor.systemGray6.cgColor
        btn.layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        btn.layer.shadowRadius = 8.0
        btn.layer.shadowOpacity = 0.3
        return btn
    }()
    
    var id: Int!
    var delegate: HighlightViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        applyViewCode()
    }
    
    @objc func buttonTapped() {
        delegate?.highlightDidSelected(id: self.id)
    }
    
    private func addGradient() {
        let gradientLayerBtn = CAGradientLayer()
        gradientLayerBtn.colors = [
            KingBurgerColor.degradePriceBtn1?.cgColor ?? UIColor.clear.cgColor,
            KingBurgerColor.degradePriceBtn2?.cgColor ?? UIColor.clear.cgColor,
        ]
        gradientLayerBtn.cornerRadius = 20
        gradientLayerBtn.frame = getCouponBtn.bounds
        getCouponBtn.layer.insertSublayer(gradientLayerBtn, at: 0)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = bounds
        addGradient()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HighlightView: ViewCodeProtocol {
    func buildViewHierarchy() {
        addSubview(imageView)
        addSubview(getCouponBtn)
    }
    
    func setupConstraints() {
        let moreButtonConstraint = [
            getCouponBtn.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            getCouponBtn.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -30)
        ]
        NSLayoutConstraint.activate(moreButtonConstraint)
    }
}
