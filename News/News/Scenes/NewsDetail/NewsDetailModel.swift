//
//  NewsDetailModel.swift
//  News
//
//  Created by Mahmud CIKRIK on 19.02.2024.
//

import Foundation

struct NewsDetailModel {
    let id = UUID()
    let title: String
    let content: String
    var date: Date {
        didSet {
            updateFormattedDate()
        }
    }
    var formattedDate: String = "Date"
    let imgUrl: String
    let pageTitle: String
    var savedDate = Date()
    let newsUrl: String
}

extension NewsDetailModel {

    init(news: Article) {
        self.init(
            title: news.title ?? "Title",
            content: news.content ?? "Content",
            date: news.publishedAt ?? Date(),
            imgUrl: news.urlToImage ?? "https://dummyimage.com/300x200/cccccc/ffffff.png&text=News+Image",
            pageTitle: news.source.name ?? "Source Title", newsUrl: news.url ?? "https://www.google.com/")

        updateFormattedDate()
    }
    
    private mutating func updateFormattedDate() {
        formattedDate = "\(date)".stringFormatter() ?? "Date"
        }

}

