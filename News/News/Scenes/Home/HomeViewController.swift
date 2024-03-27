//
//  HomeViewController.swift
//  News
//
//  Created by Mahmud CIKRIK on 18.02.2024.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var buttonCollection: UICollectionView!
    
    var categories: [String] = []
    
    
    var viewModel: HomeViewModelProtocol? = HomeViewModel(service: service)
    
    private var homeNewsList: [HomeModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.delegateVC = self
        
        buttonCollection.dataSource = self
        buttonCollection.delegate = self
        buttonCollection.register(ButtonsCell.nib(), forCellWithReuseIdentifier: ButtonsCell.identifier)
        buttonCollection.allowsMultipleSelection = true
        
        tableView.dataSource = self
        tableView.delegate = self
        viewModel?.loadData()
        
        if #available(iOS 13.0, *) {
                    activityIndicator.style = .medium
                }
    }
    
}

extension HomeViewController: HomeViewModelDelegate {
    
    func handleViewModelOutput(_ output: HomeViewModelOutput) {
        
        switch output {
            
        case .updateTitle(let title):
        self.title = title
        case .setLoading(let isShowed):
            activityIndicator.layer.zPosition = 5
            activityIndicator.backgroundColor = .white
            if isShowed {
                activityIndicator.startAnimating()
            } else {
                UIView.animate(withDuration: 0.8, animations: {
                    self.activityIndicator.alpha = 0.0
                    self.activityIndicator.layer.opacity = 0.0
                }) { complete in
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.hidesWhenStopped = true
                }
            }
        case .showNewsList(let modelList):
            self.homeNewsList = modelList
            tableView.reloadData()
        case .showButtons(let fetchedCategories):
            self.categories = fetchedCategories
            buttonCollection.reloadData()
        }
        
    }
    
    func navigate(to route: HomeViewRoute) {
        switch route {
        case .newsDetail(let routeViewModel):
            let viewController = NewsDetailBuilder.make(with: routeViewModel)
            show(viewController, sender: nil)
        }
    }
    
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeNewsList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath)
        let news = homeNewsList[indexPath.row]
        cell.textLabel?.text = news.title
        cell.detailTextLabel?.text = news.detail
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        viewModel?.selectNews(at: indexPath.row)
    }

}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = buttonCollection.dequeueReusableCell(withReuseIdentifier: ButtonsCell.identifier, for: indexPath) as! ButtonsCell
        let singleItem = categories[indexPath.item]
        cell.sliderButtons.setTitle(singleItem, for: .normal)
        cell.configure(model: viewModel!)

        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cell = buttonCollection.dequeueReusableCell(withReuseIdentifier: ButtonsCell.identifier, for: indexPath) as! ButtonsCell
        return CGSize(width: cell.sliderButtons.frame.width, height: 120)
        }
    
}
