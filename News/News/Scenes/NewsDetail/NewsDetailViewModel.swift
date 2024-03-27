//
//  NewsDetailViewModel.swift
//  News
//
//  Created by Mahmud CIKRIK on 19.02.2024.
//

import Foundation
import UIKit
import Kingfisher

class NewsDetailViewModel: NewsDetailViewModelProtocol {
    
    
    weak var delegateVC: NewsDetailViewModelDelegate?
    var  buttonStringa: String?
    private let sourceTitle: String
    private let articleId: String
    var service: NewsServiceProtocol?
    var model: [NewsDetailModel] = []
    var sliderList: [NewsDetailModel] = []
    var tableList: [NewsDetailModel] = []
    var news: [Article] = []
    var selectedNews: NewsDetailModel?
    var timer: Timer?

    
    init(service: NewsServiceProtocol, articleId: String = "", sourceTitle: String = "") {
        self.articleId = articleId
        self.sourceTitle = sourceTitle
        self.service = service
        
        self.timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(self.refreshNews), userInfo: nil, repeats: true)
        if let timer = self.timer {
        RunLoop.main.add(timer, forMode: .common)
        timer.fireDate = Date().addingTimeInterval(3.0)
        }


    }
    
    @objc func refreshNews() {
        load()
    }
    
    func load() {
        DispatchQueue.main.async {
            self.notifyVC(.updateTitle(self.sourceTitle))
        }
        notifyVC(.setLoading(true))
        let sourceName = articleId
        guard let service = service else { return }
        service.fetchTopHeadlines(sourceName: sourceName) { [weak self] result in
            guard let self = self else { return }
            self.notifyVC(.setLoading(false))
            switch result {
            case .success(let response):
            if response != news {
                print("Haber listesi güncellendi.")
                    self.news = response
                    var model = response.map { NewsDetailModel(news: $0) }
                    model.sort { $0.date > $1.date }
                    self.model = model
                    self.sliderList = Array(model.prefix(3))
                self.notifyVC(.showSliderList(sliderList))
                    self.tableList = Array(model.suffix(from: 3))
                self.notifyVC(.showTableList(tableList))
            } else {
                print("Haber listesi Güncel. -Aynı-")
            }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func notifyVC(_ output: NewsDetailViewModelOutput) {
        delegateVC?.handleViewModelOutput(output)
    }
    
    func saveNews(selectedNews: NewsDetailModel, completionHandler: @escaping ((String) -> Void)) {
        DataPersistenceManager.shared.fetchingNewsFromDataBase { result in
            switch result {
            case .success(let news):
                if let index = news.firstIndex(where: { $0.title == selectedNews.title }) {
                    DataPersistenceManager.shared.deleteTitleWith(model: news[index]) { result in
                        switch result {
                        case .success():
                            print("Deleted from the Core Database")
                            completionHandler("Kaydet")
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                } else {
                    DataPersistenceManager.shared.saveNews(model: selectedNews) { result in
                        switch result {
                        case .success():
                            print("Sucessfully downloaded")
                            completionHandler("Kaydı Sil")
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                }
            case .failure(let error):
                print("Error fetching from database \(error)")
            }
        }
    }
    
    func setButtons(selectedNews: NewsDetailModel, completionHandler: @escaping ((String) -> Void)) {
        
        DataPersistenceManager.shared.fetchingNewsFromDataBase { result in
            switch result {
            case .success(let savedNews):
                if savedNews.contains(where: { $0.title == selectedNews.title }) {
                    completionHandler("Kaydı Sil")
                } else {
                    completionHandler("Kaydet")
                }
            case .failure(let error):
                    print(error)
            }
        }
    }
    
    func getImage(imgUrl: String, images: UIImageView) {
        
        let url = URL(string: imgUrl)
        images.kf.setImage(with: url) { result in
            switch result {
            case .success(_):
            break
            case .failure(_):
                // Handler: In case of any error accurs - 404 Image not found etc. -
                images.kf.setImage(with: URL(string: "https://dummyimage.com/300x200/cccccc/ffffff.png&text=News+Image"))
            }
        }
        
    }
    
    deinit {
        print("ViewModel Deinitalized")
        timer?.invalidate()
    }
    
}
