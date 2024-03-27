//
//  TopHeadlinesModel.swift
//  News
//
//  Created by Mahmud CIKRIK on 8.03.2024.
//

import Foundation

// MARK: - TopHeadlinesModel
struct TopHeadlinesModel: Codable {
    let status: String?
    let totalResults: Int?
    let articles: [Article]
}

// MARK: - Article
struct Article: Codable, Equatable {
    static func == (lhs: Article, rhs: Article) -> Bool {
        return true
    }
    
    let source: NewsSource
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: Date?
    let content: String?
}

// MARK: - Source Id
struct NewsSource: Codable {
    let id: String?
    let name: String?
}
