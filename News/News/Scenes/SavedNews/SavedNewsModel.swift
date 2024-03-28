//
//  SavedNewsModel.swift
//  News
//
//  Created by Mahmud CIKRIK on 28.03.2024.
//

import Foundation

struct SavedNewsModel {
    let image: String
    let newsTitle: String
    let newsUrl: String
}

extension SavedNewsModel {
    init(savedNews: SavedNewsItems) {
        self.init(image: savedNews.imgUrl ?? "https://www.google.com",
                  newsTitle: savedNews.title ?? "Title", newsUrl: savedNews.newsUrl ?? "https://www.google.com")
    }
}
