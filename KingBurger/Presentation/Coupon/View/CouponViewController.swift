//
//  CouponViewController.swift
//  KingBurger
//
//  Created by Maxwell Farias on 21/08/23.
//

import UIKit

enum CouponTypeListForFilter: String {
    case expirated = "Expired coupons"
    case activated =  "Activated coupons"
    case all = "All coupons"
}

class CouponViewController: UITableViewController {
    
    var coupons: [Coupon] = []
    var loadingCoupons = false
    var total = 0
    var limit = 0
    var currentPage = 0
    var listType: CouponTypeListForUrl = .activated 
    
    var viewModel: CouponViewModel? {
        didSet {
            viewModel?.delegate = self
        }
    }
    
    let showCouponViewController = ShowCouponViewController()
    lazy var showCouponNavigationController = UINavigationController(rootViewController: showCouponViewController)
    
    override init(style: UITableView.Style) {
        super.init(style: style)
        
        self.tabBarItem.image = UIImage(systemName: "tag")
        self.tabBarItem.title = "Coupon"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        if viewModel?.state == .loading {
            viewModel?.fetch(currentPage: 0, listType: .activated)
        }
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(CouponCell.self, forCellReuseIdentifier: CouponCell.identifier)
        self.tableView.separatorStyle = .none
        navigationItem.title = CouponTypeListForFilter.activated.rawValue
        view.backgroundColor = KingBurgerColor.background
        filterMenu(titleIconName: CouponTypeListForFilter.activated.rawValue)
    }
    
    func filterMenu(titleIconName: String) {
        
        let activatedCouponItem = UIAction(title: CouponTypeListForFilter.activated.rawValue, image: nil) { (action) in
            
            self.filterMenu(titleIconName: action.title)
            self.listType = .activated
            self.navigationItem.title = action.title
            self.coupons.removeAll()
            self.currentPage = 0
            self.viewModel?.fetch(currentPage: 0, listType: .activated)
        }
        
        let expiredCouponItem = UIAction(title: CouponTypeListForFilter.expirated.rawValue, image: nil) { (action) in
            
            self.filterMenu(titleIconName: action.title)
            self.listType = .expirated
            self.navigationItem.title = action.title
            self.coupons.removeAll()
            self.currentPage = 0
            self.viewModel?.fetch(currentPage: 0, listType: .expirated)
        }
        
       
        let allCouponsItem = UIAction(title: CouponTypeListForFilter.all.rawValue, image: nil) { (action) in
            self.filterMenu(titleIconName: action.title)
            self.listType = .all
            self.navigationItem.title = action.title
            self.coupons.removeAll()
            self.currentPage = 0
            self.viewModel?.fetch(currentPage: 0, listType: .all)
        }
        
        let menuItens = [activatedCouponItem, expiredCouponItem, allCouponsItem]
        menuItens.forEach() { item in
            if item.title.hasPrefix(titleIconName) {
                item.image = UIImage(systemName: "checkmark")
            }
        }

        let menu = UIMenu(title: "", options: .displayInline, children: menuItens)
        let navItems = [UIBarButtonItem(image:  UIImage(named: "filter"), primaryAction: nil, menu: menu)]
        self.navigationItem.rightBarButtonItems = navItems
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coupons.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CouponCell.identifier, for: indexPath) as! CouponCell
         cell.prepareViews(coupon: coupons[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.fetchProductDetail(id: coupons[indexPath.row].productId, indexPath.row)
        
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (total == limit && loadingCoupons == false && indexPath.row == coupons.count - 10) {
            self.loadingCoupons = true
            viewModel?.fetch(currentPage: currentPage, listType: self.listType)
            self.currentPage += 1
        }
    }
    
    
    func showCouponDetail (response: ProductResponse, _ indexOfTheSelectedCell: Int) {
        
           let coupon = coupons[indexOfTheSelectedCell]
  
            if let formatedDate = String(coupon.expiresDate.prefix(10)).toDate(dateFormat: "yyyy/MM/dd")?.toString(dateFormat: "dd/MM/yyyy") {
                showCouponViewController.couponView.date = formatedDate
            }
            showCouponViewController.couponView.couponName = coupon.coupon
            showCouponViewController.couponView.productName = response.name
            
            if let price = response.price.toCurrency() {
                showCouponViewController.couponView.price = price
            }
            if let url = URL(string: response.pictureUrl) {
                showCouponViewController.couponView.productImg.sd_setImage(with: url)
            }
            
            if let expiresDate = coupon.expiresDate.toDate(dateFormat: "yyyy-MM-dd'T'HH:mm:ss") {
                if expiresDate.timeIntervalSince1970 < Date().timeIntervalSince1970 {
                    showCouponViewController.couponView.isExpired = true
                } else {
                    showCouponViewController.couponView.isExpired = false
                }
            }
 
            
            if let sheet = showCouponNavigationController.sheetPresentationController {
                sheet.detents = [.medium()]
            }
            
        if !showCouponNavigationController.isBeingPresented {
            present(showCouponNavigationController, animated: true)
        }
           
    }
    
}


extension CouponViewController: CouponViewModelDelegate {
    func viewModelDidChanged(state: CouponState) {
        switch(state) {
        case .loading:
            break
            
        case .success(let response):
            self.coupons += response.data
            self.limit = response.limit
            self.total = response.total
            loadingCoupons = false
            tableView.reloadData()
            break
        case .successProductDetail(let response, let index):
            showCouponDetail(response: response, index)
            break
        case .error( _):
            break
        }
    }

}

