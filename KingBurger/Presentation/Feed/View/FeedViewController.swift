//
//  FeedViewController.swift
//  KingBurger
//
//  Created by Maxwell Farias on 21/08/23.
//

import UIKit
import SwiftUI

class FeedViewController: UIViewController {
    
    var sections =  [CategoryResponse]()
    
    private var headerView: HighlightView!
    
    private let progress: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView()
        aiv.backgroundColor = .systemBackground
        aiv.startAnimating()
        return aiv
    }()
    
    private var homeFeedTable: UITableView = {
        let tv = UITableView(frame: .zero, style: .grouped)
        tv.register(FeedTableViewCell.self, forCellReuseIdentifier: FeedTableViewCell.identifier)
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyViewCode()

        homeFeedTable.backgroundColor = KingBurgerColor.background
        
        navigationController?.title = "Inicio"
        navigationController?.tabBarItem.image = UIImage(systemName: "house")
        
        headerView = HighlightView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 200))
        homeFeedTable.tableHeaderView = headerView
        
        headerView.delegate = self
        homeFeedTable.dataSource = self
        homeFeedTable.delegate = self
        
        configureNavBar()
        viewModel?.fetch()
        headerView.imageView.image = UIImage(named: "highlight1")
        viewModel?.fetchHighlight()
    }
    
    var viewModel: FeedViewModel? {
        didSet {
            viewModel?.delegate = self
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeFeedTable.frame = view.bounds
        progress.frame = view.bounds
    }
    
    private func configureNavBar() {
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.title = "Products"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "power"), style: .done, target: self, action: #selector(logoutDidTapped))
    }
    
    @objc func logoutDidTapped(_ sender: UIBarButtonItem) {
        homeFeedTable.removeFromSuperview()
//        homeFeedTable = nil
        viewModel?.logout()
    }
}
extension FeedViewController: ViewCodeProtocol {
    func buildViewHierarchy() {
        view.addSubview(homeFeedTable)
        view.addSubview(progress)
    }
    
    func setupConstraints() {
        
    }
}

extension FeedViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].name
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let padddingView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 40))
        let label = UILabel(frame: CGRect(x: 20, y: 0, width: tableView.bounds.width, height: 40))
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.text = sections[section].name.uppercased()
        padddingView.addSubview(label)
        return padddingView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FeedTableViewCell.identifier, for: indexPath) as! FeedTableViewCell
        cell.products.append(contentsOf: sections[indexPath.section].products)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 240
    }
}

extension FeedViewController: FeedViewModelDelegate {
    func viewModelDidChanged(state: FeedState) {
        switch(state) {
        case .loading:
            break
            
        case .success(let categories):
            progress.stopAnimating()
            self.sections = categories
            homeFeedTable.reloadData()
            break
        case .successHighlight(let response):
            guard let url = URL(string: response.pictureUrl) else { break }
            headerView.imageView.sd_setImage(with: url)
            headerView.id = response.id
            break
        case .error(_):
            break
        }
    }
}

extension FeedViewController: FeedCollectionViewDelegate {
    func itemSelected(productId: Int) {
        viewModel?.goToProductDetail(id: productId )
    }
}

extension FeedViewController: HighlightViewDelegate {
    func highlightDidSelected(id: Int) {
        viewModel?.goToProductDetail(id: id)
    }
}

