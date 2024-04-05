//
//  FeedCollectionViewCell.swift
//  KingBurger
//
//  Created by Maxwell Farias on 22/08/23.
//

import UIKit

class FeedCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "FeedCollectionViewCell"
    var imgSize: CGSize?
    var product: ProductResponse! {
        willSet {
            if let url = URL(string: newValue.pictureUrl) {
                imageView.sd_setImage(with: url) { image, _, _, _ in
                    if let img = image {
                        let maxWidth: CGFloat = 120.0
                        let aspectRatio = img.size.height / img.size.width
                        self.imageView.widthAnchor.constraint(equalToConstant: maxWidth).isActive = true
                        self.imageView.heightAnchor.constraint(equalTo: self.imageView.widthAnchor, constant: aspectRatio).isActive = true
                    }
                }
            }
            nameLabel.text = newValue.name
            let formatter = NumberFormatter()
            formatter.numberStyle = .currency
            formatter.locale = Locale(identifier: "PT-BR")
            priceLabel.text = formatter.string(from: newValue.price as NSNumber)
        }
    }
    
    let mainContainer: UIView = {
        let v = UIView()
        v.backgroundColor = KingBurgerColor.secondaryBackground
        v.layer.cornerRadius = 14
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let nameLabel: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .center
        lb.textColor = .label
        lb.numberOfLines = 2
        lb.lineBreakMode = .byClipping
        lb.adjustsFontSizeToFitWidth = true
        lb.font = .systemFont(ofSize: 14, weight: .medium)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    let priceView: UIView = {
        let v = UIView()
        v.backgroundColor = .clear
        v.translatesAutoresizingMaskIntoConstraints = false
        v.layer.masksToBounds = true
        v.layer.cornerRadius = 12
        return v
    }()
    
    let priceLabel: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .center
        lb.textColor = .white
        lb.backgroundColor = .clear
        lb.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        applyViewCode()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addGradient()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            KingBurgerColor.degradePriceBtn1?.cgColor ?? UIColor.clear.cgColor,
            KingBurgerColor.degradePriceBtn2?.cgColor ?? UIColor.clear.cgColor
        ]
        gradientLayer.frame = priceView.bounds
        priceView.layer.addSublayer(gradientLayer)
    }
}

extension FeedCollectionViewCell: ViewCodeProtocol {
    func buildViewHierarchy() {
        self.addSubview(mainContainer)
        mainContainer.addSubview(imageView)
        mainContainer.addSubview(nameLabel)
        mainContainer.addSubview(priceView)
        mainContainer.addSubview(priceLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            mainContainer.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            mainContainer.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            mainContainer.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            mainContainer.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: mainContainer.topAnchor, constant: -40),
            imageView.centerXAnchor.constraint(equalTo: mainContainer.centerXAnchor),
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -25),
            nameLabel.trailingAnchor.constraint(equalTo: mainContainer.trailingAnchor, constant: -10),
            nameLabel.leadingAnchor.constraint(equalTo: mainContainer.leadingAnchor, constant: 10),
            nameLabel.bottomAnchor.constraint(equalTo: priceView.topAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            priceView.trailingAnchor.constraint(equalTo: mainContainer.trailingAnchor, constant: -4),
            priceView.leadingAnchor.constraint(equalTo: mainContainer.leadingAnchor, constant: 4),
            priceView.bottomAnchor.constraint(equalTo: mainContainer.bottomAnchor, constant: -5),
            priceView.heightAnchor.constraint(equalToConstant: 35),
            
            priceLabel.centerXAnchor.constraint(equalTo: priceView.centerXAnchor),
            priceLabel.centerYAnchor.constraint(equalTo: priceView.centerYAnchor)
        ])
     
    }
}
