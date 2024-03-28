//
//  SavedNewsViewController.swift
//  News
//
//  Created by Mahmud CIKRIK on 28.03.2024.
//

import UIKit
import Kingfisher
import WebKit

class SavedNewsViewController: UIViewController {
    
    @IBOutlet var tableViews: UITableView!
    
    var savedList: [SavedNewsModel] = []
    var savedData: [SavedNewsItems] = []
    var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViews.dataSource = self
        tableViews.delegate = self
        tableViews.register( SaveTableViewCell.nib(), forCellReuseIdentifier: SaveTableViewCell.identifier)
        webView = WKWebView(frame: self.view.bounds)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DataPersistenceManager.shared.fetchingNewsFromDataBase { result in
            switch result {
            case .success(let savedItems):
                self.savedList = savedItems.map { SavedNewsModel(image: $0.imgUrl ?? "", newsTitle: $0.title ?? "", newsUrl: $0.newsUrl ?? "")}
                self.savedData = savedItems
                print(savedItems.count)
                self.tableViews.reloadData()
            case .failure(let failure):
                print(failure)
            }
        }
    }
}
    
extension SavedNewsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "saveCell", for: indexPath) as! SaveTableViewCell
        let item = savedList[indexPath.row]
        cell.getImage(url: item.image)
        cell.newsTitle.text = item.newsTitle
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedURL = savedList[indexPath.row]
        if let url = URL(string: selectedURL.newsUrl) {
            let request = URLRequest(url: url)
            webView.load(request)
            
            if let navigationController = navigationController {
                            navigationController.pushViewController(WebViewController(webView: webView), animated: true)
                        }
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            
            DataPersistenceManager.shared.deleteTitleWith(model: savedData[indexPath.row]) { result in
                switch result {
                case .success():
                    print("Deleted from Database")
                case .failure(let failure):
                    print(failure)
                }
                self.savedList.remove(at: indexPath.row)
                self.tableViews.deleteRows(at: [indexPath], with: .fade)
            }
            
        default:
            break
        }
        
    }
}
