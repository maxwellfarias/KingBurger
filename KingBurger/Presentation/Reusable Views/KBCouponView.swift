//
//  CouponView.swift
//  KingBurger
//
//  Created by Maxwell Farias on 18/09/23.
//


import UIKit
import SDWebImage


class KBCouponView: UIView {
    
    //    MARK: Views
    private let couponContainer: UIView = {
        let v = UIView()
        v.backgroundColor = .clear
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
        
    private let couponLeftImg: UIImageView = {
       let img = UIImageView()
        img.image = UIImage(named: "validCouponLeft")
      
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    private let couponRightImg: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "validCouponRight")
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    private let backgroundTopView: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        v.setContentCompressionResistancePriority(.required, for: .horizontal)
        v.setContentHuggingPriority(.defaultLow, for: .horizontal)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    private let backgroundBottomView: UIView = {
        let v = UIView()
        v.backgroundColor = KingBurgerColor.couponBackgroundBottomView
        v.setContentCompressionResistancePriority(.required, for: .horizontal)
        v.setContentHuggingPriority(.defaultLow, for: .horizontal)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    private let productNameLb: UILabel = {
       let lb = UILabel()
        lb.text = "Combo KB Angra".uppercased()
        lb.textAlignment = .center
        lb.numberOfLines = 2
        lb.lineBreakMode = .byClipping
        lb.adjustsFontSizeToFitWidth = true
        lb.minimumScaleFactor = 0.5
        lb.transform =  CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
        lb.textColor = UIColor(named: "productName")
        lb.font = UIFont.systemFont(ofSize: 20, weight: .black)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private let dateTitleLb: UILabel = {
        let lb = UILabel()
        lb.textColor = .black
        lb.text = "VALID UNTIL: "
        lb.textAlignment = .center
        lb.transform =  CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
        lb.font = UIFont.systemFont(ofSize: 8, weight: .light)
        lb.numberOfLines = 0
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private let dateLb: UILabel = {
        let lb = UILabel()
        lb.textColor = .black
        lb.text = "12/12/2000"
        lb.textAlignment = .center
        lb.transform =  CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
        lb.font = UIFont.systemFont(ofSize: 8, weight: .heavy)
        lb.numberOfLines = 0
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private let couponLb: UILabel = {
        let lb = UILabel()
        lb.text = "XBNGST"
        lb.textAlignment = .center
        lb.textColor = KingBurgerColor.productName
        lb.font = UIFont.systemFont(ofSize: 30, weight: .black)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private let priceLb: UILabel = {
        let lb = UILabel()
        lb.textColor = .black
        lb.text = "R$ 10,00".uppercased()
        lb.textAlignment = .center
        lb.font = UIFont.systemFont(ofSize: 20, weight: .black)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    let productImg: UIImageView = {
       let img = UIImageView()
        img.image = UIImage(named: "example2")
        img.layer.zPosition = 2
        img.contentMode = .scaleAspectFill
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    private let opaqueView: UIView = {
       let v = UIView()
        v.backgroundColor = .white
        v.alpha = 0.3
        v.layer.zPosition = 1
        v.isHidden = true
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    
    private let invalidCouponLb: UILabel = {
       let lb = UILabel()
        lb.textColor = .white
        lb.textAlignment = .center
        lb.text = "Expired coupon".uppercased()
        lb.backgroundColor = KingBurgerColor.invalidCouponLb
        lb.layer.zPosition = 3
        lb.transform =  CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
        lb.font = UIFont.systemFont(ofSize: 14, weight: .heavy)
        lb.isHidden = true
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
//    MARK: Properties
    

    var isExpired: Bool = false {
        willSet{
            if newValue {
                invalidCouponLb.isHidden = false
                opaqueView.isHidden =  false
            } else {
                invalidCouponLb.isHidden = true
                opaqueView.isHidden =  true
            }
        }
    }
    
    
    var productName: String = "" {
        willSet{
            productNameLb.text = newValue
        }
    }
    var date: String = "" {
        willSet{
            dateLb.text = newValue
        }
    }
    var couponName: String = "" {
        willSet{
            couponLb.text = newValue
        }
    }
    var price: String = "" {
        willSet{
            priceLb.text = newValue
        }
    }
    
    var imageAspectRatio: CGFloat = 1.0

    
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        applyViewCode()
        isExpired = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
        if let img = productImg.image {
            imageAspectRatio =  img.size.width / img.size.height
        }
        
        
    }
    
    
}

extension KBCouponView: ViewCodeProtocol {
    func buildViewHierarchy() {
        self.addSubview(couponContainer)
        couponContainer.addSubview(couponRightImg)
        couponContainer.addSubview(backgroundTopView)
        couponContainer.addSubview(couponLeftImg)
        couponContainer.addSubview(backgroundBottomView)
        couponContainer.addSubview(productNameLb)
        couponContainer.addSubview(dateTitleLb)
        couponContainer.addSubview(dateLb)
        couponContainer.addSubview(opaqueView)
        couponContainer.addSubview(productImg)
        couponContainer.addSubview(invalidCouponLb)
        backgroundBottomView.addSubview(couponLb)
        backgroundBottomView.addSubview(priceLb)
   
        
    }
    
    func setupConstraints() {
        
       
        NSLayoutConstraint.activate([
            couponContainer.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            couponContainer.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            couponContainer.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            couponContainer.heightAnchor.constraint(equalToConstant:  150)
        ])
        

        NSLayoutConstraint.activate([
            couponLeftImg.leadingAnchor.constraint(equalTo: couponContainer.leadingAnchor),
            couponLeftImg.topAnchor.constraint(equalTo: couponContainer.topAnchor),
            couponLeftImg.heightAnchor.constraint(equalTo: couponContainer.heightAnchor),
            couponLeftImg.widthAnchor.constraint(equalTo: couponLeftImg.heightAnchor, multiplier: 0.654)
            
        ])
        
        NSLayoutConstraint.activate([
            couponRightImg.trailingAnchor.constraint(equalTo: couponContainer.trailingAnchor),
            couponRightImg.topAnchor.constraint(equalTo: couponContainer.topAnchor),
            couponRightImg.heightAnchor.constraint(equalTo: couponContainer.heightAnchor),
            couponRightImg.widthAnchor.constraint(equalTo: couponRightImg.heightAnchor, multiplier: 0.56)
            
        ])
        
        NSLayoutConstraint.activate([
            backgroundTopView.topAnchor.constraint(equalTo: couponContainer.topAnchor),
            backgroundTopView.leadingAnchor.constraint(equalTo: couponLeftImg.trailingAnchor),
            backgroundTopView.trailingAnchor.constraint(equalTo: couponContainer.trailingAnchor, constant: -10),
            backgroundTopView.heightAnchor.constraint(equalTo: couponContainer.heightAnchor, multiplier: 0.57)
        ])
        
        NSLayoutConstraint.activate([
            backgroundBottomView.topAnchor.constraint(equalTo: backgroundTopView.bottomAnchor),
            backgroundBottomView.bottomAnchor.constraint(equalTo: couponContainer.bottomAnchor),
            backgroundBottomView.leadingAnchor.constraint(equalTo: couponLeftImg.trailingAnchor),
            backgroundBottomView.trailingAnchor.constraint(equalTo: couponRightImg.leadingAnchor),
        ])
        
        NSLayoutConstraint.activate([
            productNameLb.centerXAnchor.constraint(equalTo: couponLeftImg.centerXAnchor),
            productNameLb.centerYAnchor.constraint(equalTo: couponLeftImg.centerYAnchor),
            productNameLb.widthAnchor.constraint(equalTo: couponLeftImg.heightAnchor)
            
        ])
        
        NSLayoutConstraint.activate([
            dateTitleLb.centerYAnchor.constraint(equalTo: productNameLb.centerYAnchor, constant: 25),
            dateTitleLb.trailingAnchor.constraint(equalTo: productNameLb.trailingAnchor, constant: -15),
            
            dateLb.centerXAnchor.constraint(equalTo: dateTitleLb.centerXAnchor),
            dateLb.centerYAnchor.constraint(equalTo: dateTitleLb.centerYAnchor, constant: -54.7),
        ])
        
        
        NSLayoutConstraint.activate([
            couponLb.topAnchor.constraint(equalTo: backgroundBottomView.topAnchor),
            couponLb.leadingAnchor.constraint(equalTo: backgroundBottomView.leadingAnchor),
            couponLb.trailingAnchor.constraint(equalTo: backgroundBottomView.trailingAnchor),
            
            priceLb.topAnchor.constraint(equalTo: couponLb.bottomAnchor),
            priceLb.leadingAnchor.constraint(equalTo: backgroundBottomView.leadingAnchor),
            priceLb.trailingAnchor.constraint(equalTo: backgroundBottomView.trailingAnchor)
        ])
   
        NSLayoutConstraint.activate([
            productImg.centerYAnchor.constraint(equalTo: backgroundTopView.centerYAnchor, constant: -25),
            productImg.centerXAnchor.constraint(equalTo: backgroundTopView.centerXAnchor),
            productImg.heightAnchor.constraint(equalTo: backgroundTopView.heightAnchor, constant: 120),
            productImg.widthAnchor.constraint(equalTo: productImg.heightAnchor, multiplier: imageAspectRatio)
        ])
        
        NSLayoutConstraint.activate([
            opaqueView.topAnchor.constraint(equalTo: couponContainer.topAnchor),
            opaqueView.bottomAnchor.constraint(equalTo: couponContainer.bottomAnchor),
            opaqueView.trailingAnchor.constraint(equalTo: couponContainer.trailingAnchor, constant: -10),
            opaqueView.leadingAnchor.constraint(equalTo: couponContainer.leadingAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            invalidCouponLb.widthAnchor.constraint(equalTo: couponContainer.heightAnchor),
            invalidCouponLb.heightAnchor.constraint(equalToConstant: 50),
            invalidCouponLb.centerYAnchor.constraint(equalTo: couponContainer.centerYAnchor),
            invalidCouponLb.trailingAnchor.constraint(equalTo: couponRightImg.leadingAnchor, constant: 103),
            
        ])
    }
    
    
}

