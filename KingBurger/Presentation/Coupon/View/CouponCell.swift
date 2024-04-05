//
//  CouponTableViewCell.swift
//  KingBurger
//
//  Created by Maxwell Farias on 12/09/23.
//

import UIKit

class CouponCell: UITableViewCell {
    
    static let identifier = "CouponCell"
    
    private let couponContainer: UIView = {
        let v = UIView()
        v.backgroundColor = .clear
        v.layer.shadowColor = UIColor.gray.cgColor
        v.layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        v.layer.shadowRadius = 8.0
        v.layer.shadowOpacity = 0.5
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
    
    private let creationDataTitleLb: UILabel = {
       let lb = UILabel()
        lb.text = "CREATED IN"
        lb.textAlignment = .center
        lb.numberOfLines = 2
        lb.lineBreakMode = .byClipping
        lb.adjustsFontSizeToFitWidth = true
        lb.minimumScaleFactor = 0.5
        lb.transform =  CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
        lb.textColor = KingBurgerColor.productName
        lb.font = UIFont.systemFont(ofSize: 11, weight: .black)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private let createDateLb: UILabel = {
        let lb = UILabel()
        lb.textColor = .black
        lb.text = "12/12/2000"
        lb.textAlignment = .center
        lb.transform =  CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
        lb.font = UIFont.systemFont(ofSize: 9, weight: .heavy)
        lb.numberOfLines = 0
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private let couponLb: UILabel = {
        let lb = UILabel()
        lb.addCharactersSpacing(spacing: 7, txt: "XBNGST")
        lb.textAlignment = .center
        lb.textColor = KingBurgerColor.productName
        lb.font = UIFont.systemFont(ofSize: 30, weight: .black)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private let expirationDateTitleLb: UILabel = {
        let lb = UILabel()
        lb.textColor = .black
        lb.text = "VALID UNTIL"
        lb.textAlignment = .center
        lb.font = UIFont.systemFont(ofSize: 9, weight: .black)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private let expirationDateLb: UILabel = {
        let lb = UILabel()
    
        lb.textColor = KingBurgerColor.productName
        lb.addCharactersSpacing(spacing: 2, txt: "20/11/2033")
        lb.textAlignment = .center
        lb.font = UIFont.systemFont(ofSize: 12, weight: .heavy)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private let opaqueView: UIView = {
       let v = UIView()
        v.backgroundColor = .white
        v.alpha = 0.4
        v.layer.zPosition = 1
        v.isHidden = true
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    private let invalidCouponLb: UILabel = {
       let lb = UILabel()
        lb.textColor = .white
        lb.textAlignment = .center
        lb.text = "EXPIRED COUPON"
        lb.backgroundColor = KingBurgerColor.invalidCouponLb
        lb.layer.zPosition = 3
        lb.transform =  CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
        lb.font = UIFont.systemFont(ofSize: 7, weight: .black)
        lb.isHidden = true
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
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
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: CouponCell.identifier)
        
        applyViewCode()
        self.backgroundColor = .clear
        self.selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    func prepareViews (coupon: Coupon) {
        createDateLb.text = String(coupon.createdDate.prefix(10)).toDate(dateFormat: "yyyy/MM/dd")?.toString(dateFormat: "dd/MM/yyyy")
        expirationDateLb.text = String(coupon.expiresDate.prefix(10)).toDate(dateFormat: "yyyy/MM/dd")?.toString(dateFormat: "dd/MM/yyyy")
        couponLb.text = coupon.coupon
        
       
        if let expiresDate = coupon.expiresDate.toDate(dateFormat: "yyyy-MM-dd'T'HH:mm:ss") {
            if expiresDate.timeIntervalSince1970 < Date().timeIntervalSince1970 {
                isExpired = true
            } else {
                isExpired = false
            }
        }
    }
    
}


extension CouponCell: ViewCodeProtocol {
    
    func buildViewHierarchy() {
        self.addSubview(couponContainer)
        couponContainer.addSubview(couponRightImg)
        couponContainer.addSubview(backgroundTopView)
        couponContainer.addSubview(couponLeftImg)
        couponContainer.addSubview(backgroundBottomView)
        couponContainer.addSubview(creationDataTitleLb)
        couponContainer.addSubview(createDateLb)
        couponContainer.addSubview(opaqueView)
        couponContainer.addSubview(invalidCouponLb)
        backgroundTopView.addSubview(couponLb)
        backgroundBottomView.addSubview(expirationDateTitleLb)
        backgroundBottomView.addSubview(expirationDateLb)
        
        
    }
    
    func setupConstraints() {
        
        
        NSLayoutConstraint.activate([
            couponContainer.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            couponContainer.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            couponContainer.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            couponContainer.heightAnchor.constraint(equalToConstant:  80)
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
            creationDataTitleLb.centerXAnchor.constraint(equalTo: couponLeftImg.centerXAnchor),
            creationDataTitleLb.centerYAnchor.constraint(equalTo: couponLeftImg.centerYAnchor, constant: 0),
            creationDataTitleLb.widthAnchor.constraint(equalTo: couponLeftImg.heightAnchor),
            
            
            createDateLb.centerYAnchor.constraint(equalTo: creationDataTitleLb.centerYAnchor),
            createDateLb.trailingAnchor.constraint(equalTo: creationDataTitleLb.trailingAnchor)
            
        ])
        
  
        NSLayoutConstraint.activate([
            couponLb.centerYAnchor.constraint(equalTo: backgroundTopView.centerYAnchor),
            couponLb.leadingAnchor.constraint(equalTo: backgroundTopView.leadingAnchor),
            couponLb.trailingAnchor.constraint(equalTo: backgroundTopView.trailingAnchor),
     
        ])
        
        NSLayoutConstraint.activate([
            
            expirationDateTitleLb.topAnchor.constraint(equalTo: backgroundTopView.bottomAnchor, constant: 3),
            expirationDateTitleLb.centerXAnchor.constraint(equalTo: backgroundBottomView.centerXAnchor),
            
            
            expirationDateLb.topAnchor.constraint(equalTo: expirationDateTitleLb.bottomAnchor, constant: 2),
            expirationDateLb.centerXAnchor.constraint(equalTo: backgroundBottomView.centerXAnchor)
     
        ])
      
        
        NSLayoutConstraint.activate([
            opaqueView.topAnchor.constraint(equalTo: couponContainer.topAnchor),
            opaqueView.bottomAnchor.constraint(equalTo: couponContainer.bottomAnchor),
            opaqueView.trailingAnchor.constraint(equalTo: couponContainer.trailingAnchor, constant: -10),
            opaqueView.leadingAnchor.constraint(equalTo: couponContainer.leadingAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            opaqueView.topAnchor.constraint(equalTo: couponContainer.topAnchor),
            opaqueView.bottomAnchor.constraint(equalTo: couponContainer.bottomAnchor),
            opaqueView.trailingAnchor.constraint(equalTo: couponContainer.trailingAnchor, constant: -10),
            opaqueView.leadingAnchor.constraint(equalTo: couponContainer.leadingAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            invalidCouponLb.widthAnchor.constraint(equalTo: couponContainer.heightAnchor),
            invalidCouponLb.heightAnchor.constraint(equalToConstant: 25),
            invalidCouponLb.centerYAnchor.constraint(equalTo: couponContainer.centerYAnchor),
            invalidCouponLb.trailingAnchor.constraint(equalTo: couponRightImg.leadingAnchor, constant: 20),
            
        ])
        

    }
}
