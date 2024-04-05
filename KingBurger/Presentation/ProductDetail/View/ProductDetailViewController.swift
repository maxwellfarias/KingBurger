//
//  ProductDetailViewController.swift
//  KingBurguer
//
//  Created by Maxwell Farias on 06/09/23.
//

import UIKit
import SwiftUI
import SDWebImage
class ProductDetailViewController: UIViewController {
    
    var id: Int!
    
    let progress: UIActivityIndicatorView = {
        let v = UIActivityIndicatorView()
        v.backgroundColor = .clear
        v.backgroundColor = .systemBackground
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    private let btnProgress: UIActivityIndicatorView = {
        let v = UIActivityIndicatorView()
        v.backgroundColor = .clear
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let scroll: UIScrollView = {
        let sc = UIScrollView()
        sc.translatesAutoresizingMaskIntoConstraints = false
        return sc
    }()
    
    let container: UIView = {
        let v = UIView()
        v.backgroundColor = .clear
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let containerDescription: UIView = {
        let v = UIView()
        v.backgroundColor = KingBurgerColor.secondaryBackground
        v.translatesAutoresizingMaskIntoConstraints = false
        v.layer.cornerRadius = 14
        return v
    }()
    
    let backgroundDesignImg: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "backgroundVegetable")
        img.layer.cornerRadius = 100
        img.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        img.clipsToBounds = true
        img.contentMode = .scaleAspectFill
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    let productImg: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let descriptionTitleLb: UILabel = {
        let lb = UILabel()
        lb.text = "Description"
        lb.textColor = .label
        lb.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        lb.textAlignment = .left
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    let getCouponView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .orange
        v.layer.cornerRadius = 30
        v.clipsToBounds = true
        return v
    }()
    
    let priceTitleLbl: UILabel = {
        let lb = UILabel()
        lb.text = "Price"
        lb.textColor = .white
        lb.font = .systemFont(ofSize: 14.0, weight: .regular)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    let priceLbl: UILabel = {
        let lb = UILabel()
        lb.textColor = .white
        lb.font = .systemFont(ofSize: 18.0, weight: .bold)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    lazy var getCouponBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Get coupon", for: .normal)
        btn.backgroundColor = .black
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        btn.layer.cornerRadius = 25
        btn.contentEdgeInsets = UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 25)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(couponTapped), for: .touchUpInside)
        return btn
    }()
    
    let descriptionLb: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .justified
        lb.textColor = .label 
        lb.font = UIFont.systemFont(ofSize: 16, weight: .light)
        lb.numberOfLines = 0
        lb.sizeToFit()
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    let showCouponViewController = ShowCouponViewController()
    lazy var showCouponNavigationController = UINavigationController(rootViewController: showCouponViewController)
    
    var viewModel: ProductDetailViewModel? {
        didSet {
            viewModel?.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = KingBurgerColor.background
        prepareNavigationBarStyle()
        viewModel?.fetch(id: id)
        applyViewCode()
    }
    
    func prepareNavigationBarStyle () {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        UINavigationBar.appearance().standardAppearance = appearance
        
        navigationController?.navigationBar.titleTextAttributes = [
            .font: UIFont.systemFont(ofSize: 25 , weight: .bold)
        ]
    }
    
    
    
    
    
    @objc func couponTapped() {
        viewModel?.createCoupon(id: id)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        showCouponNavigationController.dismiss(animated: true)
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        UINavigationBar.appearance().standardAppearance = appearance        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
    }
}
extension ProductDetailViewController: ViewCodeProtocol {
    func buildViewHierarchy() {
        
        view.addSubview(scroll)
        view.addSubview(getCouponView)
        view.addSubview(progress)
        scroll.addSubview(container)
        container.addSubview(backgroundDesignImg)
        container.addSubview(productImg)
        container.addSubview(containerDescription)
        containerDescription.addSubview(descriptionTitleLb)
        containerDescription.addSubview(descriptionLb)
        getCouponView.addSubview(btnProgress)
        getCouponView.addSubview(priceTitleLbl)
        getCouponView.addSubview(priceLbl)
        getCouponView.addSubview(getCouponBtn)
    }
    
    func setupConstraints() {
        
        
        let navigationBarHeight = UIApplication.shared.statusBarFrame.height
        
        guard let root = UIApplication.shared.keyWindow?.rootViewController else {
            return
        }
        let topSafeArea: CGFloat
 
        if #available(iOS 11.0, *) {
            topSafeArea = root.view.safeAreaInsets.top
            
        } else {
            topSafeArea = root.topLayoutGuide.length
        }
        
        
        NSLayoutConstraint.activate([
            scroll.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scroll.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scroll.topAnchor.constraint(equalTo: view.topAnchor, constant: (topSafeArea + navigationBarHeight + 20) * -1),
            scroll.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        let heightConstraint = container.heightAnchor.constraint(equalTo: scroll.heightAnchor)
        heightConstraint.priority = UILayoutPriority(250)
        
        NSLayoutConstraint.activate([
            container.widthAnchor.constraint(equalTo: scroll.widthAnchor),
            container.topAnchor.constraint(equalTo: scroll.topAnchor),
            container.leadingAnchor.constraint(equalTo: scroll.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: scroll.trailingAnchor),
            container.bottomAnchor.constraint(equalTo: scroll.bottomAnchor),
            heightConstraint
        ])

        NSLayoutConstraint.activate([
            progress.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            progress.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            progress.topAnchor.constraint(equalTo: view.topAnchor),
            progress.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            backgroundDesignImg.topAnchor.constraint(equalTo: container.topAnchor),
            backgroundDesignImg.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            backgroundDesignImg.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            backgroundDesignImg.heightAnchor.constraint(equalToConstant: 300)
        ])
        
        
        NSLayoutConstraint.activate([
            productImg.heightAnchor.constraint(equalToConstant: 250),
            productImg.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            productImg.topAnchor.constraint(equalTo: backgroundDesignImg.bottomAnchor, constant: -150)
        ])
        
        NSLayoutConstraint.activate([
            containerDescription.topAnchor.constraint(equalTo: productImg.bottomAnchor, constant: 10),
            containerDescription.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20),
            containerDescription.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20),
            containerDescription.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -80)
        ])
        
        NSLayoutConstraint.activate([
            descriptionTitleLb.topAnchor.constraint(equalTo: containerDescription.topAnchor, constant: 15),
            descriptionTitleLb.leadingAnchor.constraint(equalTo: containerDescription.leadingAnchor, constant: 15),
            descriptionTitleLb.trailingAnchor.constraint(equalTo: containerDescription.trailingAnchor, constant: -15)
        ])

        NSLayoutConstraint.activate([
            descriptionLb.topAnchor.constraint(equalTo: descriptionTitleLb.bottomAnchor, constant: 20),
            descriptionLb.leadingAnchor.constraint(equalTo: descriptionTitleLb.leadingAnchor),
            descriptionLb.trailingAnchor.constraint(equalTo: descriptionTitleLb.trailingAnchor),
            descriptionLb.bottomAnchor.constraint(equalTo: containerDescription.bottomAnchor, constant: -15)
        ])
        
        NSLayoutConstraint.activate([
            getCouponView.leadingAnchor.constraint(equalTo: view.safeLeadingAnchor, constant: 20),
            getCouponView.trailingAnchor.constraint(equalTo: view.safeTrailingAnchor, constant: -20),
            getCouponView.bottomAnchor.constraint(equalTo: view.safeBottomAnchor, constant: -10),
            getCouponView.heightAnchor.constraint(equalToConstant: 60),
            
            btnProgress.leadingAnchor.constraint(equalTo: getCouponView.safeLeadingAnchor),
            btnProgress.trailingAnchor.constraint(equalTo: getCouponView.safeTrailingAnchor),
            btnProgress.bottomAnchor.constraint(equalTo: getCouponView.safeBottomAnchor),
            btnProgress.topAnchor.constraint(equalTo: getCouponView.topAnchor),
            
            
            
            priceTitleLbl.topAnchor.constraint(equalTo: getCouponView.topAnchor, constant: 5),
            priceTitleLbl.leadingAnchor.constraint(equalTo: getCouponView.leadingAnchor, constant: 30),
            
            
            priceLbl.topAnchor.constraint(equalTo: priceTitleLbl.bottomAnchor),
            priceLbl.bottomAnchor.constraint(equalTo: getCouponView.bottomAnchor, constant: -5),
            priceLbl.leadingAnchor.constraint(equalTo: getCouponView.leadingAnchor, constant: 30),
            
            
            getCouponBtn.topAnchor.constraint(equalTo: getCouponView.topAnchor, constant: 5),
            getCouponBtn.bottomAnchor.constraint(equalTo: getCouponView.bottomAnchor, constant: -5),
            getCouponBtn.trailingAnchor.constraint(equalTo: getCouponView.trailingAnchor, constant: -5),
        ])
    }
    
    func prepareViews (with product: ProductResponse) {
        
        navigationItem.title = product.name
        showCouponViewController.couponView.productName = product.name
        descriptionLb.text = product.description
        
        if let price = product.price.toCurrency() {
            priceLbl.text = price
            showCouponViewController.couponView.price = price
        }
        if let url = URL(string: product.pictureUrl) {
            productImg.sd_setImage(with: url)
            showCouponViewController.couponView.productImg.sd_setImage(with: url)
        }
    }
}
extension ProductDetailViewController: ProductDetailViewModelDelegate {
    
    func viewModelDidChanged(state: ProductDetailState) {
        switch(state) {
        case .loading:
            progress.startAnimating()
            break
        case .loadindCoupon:
            btnProgress.startAnimating()
            break
        case .success(let response):
            prepareViews (with: response)
            progress.stopAnimating()
            break
        case .successCoupon(let response):
            btnProgress.stopAnimating()
            
            
            
            if let formatedDate = String(response.expiresDate.prefix(10)).toDate(dateFormat: "yyyy/MM/dd")?.toString(dateFormat: "dd/MM/yyyy") {
                showCouponViewController.couponView.date = formatedDate
            }
            showCouponViewController.couponView.couponName = response.coupon
    
            
            if let sheet = showCouponNavigationController.sheetPresentationController {
                sheet.detents = [.medium()]
                sheet.prefersEdgeAttachedInCompactHeight = true
                sheet.widthFollowsPreferredContentSizeWhenEdgeAttached = true
            }
            
            self.present(showCouponNavigationController, animated: true, completion: nil)
            
        case .error(_ ):
            progress.stopAnimating()
            break
            
        }
    }
}


