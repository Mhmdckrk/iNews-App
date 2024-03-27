//
//  HomeViewModel.swift
//  News
//
//  Created by Mahmud CIKRIK on 18.02.2024.
//

import Foundation

final class HomeViewModel: HomeViewModelProtocol {
    
    weak var delegateVC: HomeViewModelDelegate?
    let service: NewsServiceProtocol
    var news: [Source] = []
    var filteredNews: [Source] = []
    var fetchedCategories: [String] = []
    var selectedCategories: [String] = []
    var currentIndex: Int = 0
    
    
    init(service: NewsServiceProtocol) {
        self.service = service
        
    }
    
    func filterData(categories: [String]) {
        filteredNews = self.news.filter { newsItem in
            return categories.contains(newsItem.category!)
        }
        let filteredModel = filteredNews.map { HomeModel(model: $0) }
       
        self.notifyVC(.showNewsList(filteredModel))
    }
    
    func loadData() {
        notifyVC(.updateTitle("News"))
        notifyVC(.setLoading(true))
        
        service.fetchSource { result in
            self.notifyVC(.setLoading(false))
            switch result {
            case .success(let response):
            self.news = response
            self.filteredNews = response
            self.fetchedCategories = Array(Set(response.compactMap { $0.category }))
            self.selectedCategories = self.fetchedCategories
            let model = response.map { HomeModel(model: $0) }
            self.notifyVC(.showNewsList(model))
            self.notifyVC(.showButtons(self.fetchedCategories))
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func selectNews(at index: Int) {
        print(filteredNews.count)
        let singleNews = self.filteredNews[index]
        let routeViewModel = NewsDetailViewModel(service: service, articleId: singleNews.id!, sourceTitle: singleNews.name!)
        delegateVC?.navigate(to: .newsDetail(routeViewModel))
    }
    
    private func notifyVC(_ output: HomeViewModelOutput) {
        delegateVC?.handleViewModelOutput(output)
    }
    
}
