//
//  MockService.swift
//  NewsTests
//
//  Created by Mahmud CIKRIK on 8.03.2024.
//

import Foundation
@testable import News

final class MockNewsService: NewsServiceProtocol {

    var source: [Source]?
    
    var news: [Article]?
    
    func fetchSource(completion: @escaping (Result<[Source], Error>) -> Void) {
        completion(.success(source!))
    }
    
    func fetchTopHeadlines(sourceName: String, completion: @escaping (Result<[Article], Error>) -> Void) {
        completion(.success(news!))
    }

}
