//
//  NewsDetailViewController.swift
//  News
//
//  Created by Mahmud CIKRIK on 19.02.2024.
//

import UIKit

class NewsDetailViewController: UIViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var horizontalSlider: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var pageDots: UIPageControl!
    
    weak var timer: Timer?
    
    var slideIndex = 0
    
    var viewModel: NewsDetailViewModelProtocol?
    
    deinit {
        print("NewsDetailViewController deinitalized.")
    }
    
    private var sliderList: [NewsDetailModel] = []
    private var tableList: [NewsDetailModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.load()
        viewModel?.delegateVC = self

        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ListTableViewCell.nib(), forCellReuseIdentifier: ListTableViewCell.identifier)
        
        horizontalSlider.dataSource = self
        horizontalSlider.delegate = self
        horizontalSlider.register(SliderCollectionViewCell.nib(), forCellWithReuseIdentifier: SliderCollectionViewCell.identifier)
    
        
        timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(slideToNext), userInfo: nil, repeats: true)
        
        pageDots.subviews.forEach {
            $0.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            }
        
        if #available(iOS 13.0, *) {
                    activityIndicator.style = .medium
                }
    }
    
    @objc func slideToNext () {
        
        if slideIndex < sliderList.count-1 {
            slideIndex += 1
        } else { slideIndex = 0 }
        
        pageDots.currentPage = slideIndex
        horizontalSlider.scrollToItem(at: IndexPath(item: slideIndex, section: 0), at: .right, animated: true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        timer?.invalidate()
        viewModel?.timer?.invalidate()
    }
    
}

extension NewsDetailViewController: NewsDetailViewModelDelegate {
    func handleViewModelOutput(_ output: NewsDetailViewModelOutput) {
        
        switch output {
            
        case .updateTitle(let title):
            DispatchQueue.main.async {
                self.title = title
            }
        case .setLoading(let isShowed):
            activityIndicator.layer.zPosition = 5
            activityIndicator.backgroundColor = .white
            if isShowed {
                activityIndicator.startAnimating()
            } else {
                UIView.animate(withDuration: 0.8, animations: {
                    self.activityIndicator.alpha = 0.0
                    self.activityIndicator.layer.opacity = 0.0
                }) {  complete in
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.hidesWhenStopped = true
                }
            }
        case .showSliderList(let sliderList):
            self.sliderList = sliderList
            self.pageDots.numberOfPages = sliderList.count
            DispatchQueue.main.async {
                self.horizontalSlider.reloadData()
            }
        case .showTableList(let tableList):
            self.tableList = tableList
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
//    func showDetail(_ model: [NewsDetailModel]) {
//        self.title = model[0].pageTitle
//
//    }
    
}

extension NewsDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableList.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.identifier, for: indexPath) as! ListTableViewCell
            let singleItem = tableList[indexPath.row]
            cell.dateLabel.text = singleItem.formattedDate
            cell.titleLabel.text = singleItem.title
            cell.viewModel = viewModel
            cell.configure(with: singleItem)
            
            return cell
        }
        return UITableViewCell()
    }
    
}

extension NewsDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return sliderList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SliderCollectionViewCell.identifier, for: indexPath) as! SliderCollectionViewCell
        let singleItem = sliderList[indexPath.item]
        cell.dateLabel.text = singleItem.formattedDate
        cell.titleLabel.text = singleItem.title
        cell.currentIndex = indexPath.item
        cell.viewModel = viewModel
        cell.configure(with: singleItem)

        return cell
        
    }
    
}
