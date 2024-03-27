//
//  TopHeadlinesModel.swift
//  News
//
//  Created by Mahmud CIKRIK on 18.02.2024.
//

import Foundation

// MARK: - SourcesModel
struct SourcesModel: Codable {
    let status: String?
    let sources: [Source]
}

// MARK: - Source Info
struct Source: Codable {
    let id: String?
    let name: String?
    let description: String?
    let url: String?
    let category: String?
    let language: String?
    let country: String?
}
