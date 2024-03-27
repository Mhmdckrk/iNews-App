//
//  MockViews.swift
//  NewsTests
//
//  Created by Mahmud CIKRIK on 8.03.2024.
//

import Foundation
@testable import News

class MockHomeView: HomeViewModelDelegate {
    
    var newsDetailRouteCalled: Bool = false
    var outputs: [HomeViewModelOutput] = []
    
    func reset() {
        outputs.removeAll()
        newsDetailRouteCalled = false
        
    }
    
    func navigate(to route: HomeViewRoute) {
        switch route {
        case .newsDetail(_):
        newsDetailRouteCalled = true
            
        }
    }
    
    func handleViewModelOutput(_ output: HomeViewModelOutput) {
        outputs.append(output)
    }
    
}

class MockNewsDetailView: NewsDetailViewModelDelegate {
    
    var newsDetailRouteCalled: Bool = false
    var outputs: [NewsDetailViewModelOutput] = []
    
    func reset() {
        outputs.removeAll()
        newsDetailRouteCalled = false
        
    }
        
    func handleViewModelOutput(_ output: NewsDetailViewModelOutput) {
        outputs.append(output)
    }

}
