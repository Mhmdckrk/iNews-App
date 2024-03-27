//
//  HomeContracts.swift
//  News
//
//  Created by Mahmud CIKRIK on 18.02.2024.
//

import Foundation

protocol HomeViewModelProtocol: AnyObject {
    var  delegateVC: HomeViewModelDelegate? { get set }
//    func fetchData(categories: [String])
    func loadData()
    func filterData(categories: [String])
    func selectNews(at index: Int)
    var filteredNews: [Source] { get set }
    var fetchedCategories: [String] { get set }
    var selectedCategories: [String] { get set }
    var currentIndex: Int { get set }
    
}

protocol HomeViewModelDelegate: AnyObject {
    func handleViewModelOutput(_ output: HomeViewModelOutput)
    func navigate(to route: HomeViewRoute)
    
}

enum HomeViewRoute {
    case newsDetail(NewsDetailViewModelProtocol)
    
}

enum HomeViewModelOutput: Equatable {
    static func == (lhs: HomeViewModelOutput, rhs: HomeViewModelOutput) -> Bool {
        return true
    }
    
    
    case updateTitle(String)
    case setLoading(Bool)
    case showNewsList([HomeModel])
    case showButtons([String])
    
}
