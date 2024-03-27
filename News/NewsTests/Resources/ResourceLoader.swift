//
//  ResourceLoader.swift
//  NewsTests
//
//  Created by Mahmud CIKRIK on 8.03.2024.
//

import Foundation
@testable import News


class ResourceLoader {
    
    enum ResourceName: String {
        case source = "SourcesModel"
        case headlines = "TopHeadlinesModel"
    }
    
    static func loadSources(resource: ResourceName) throws -> [Source] {
        let bundle = Bundle.test
        let url = bundle.url(forResource: resource.rawValue, withExtension: "json").unsafelyUnwrapped
        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        let news = try decoder.decode(SourcesModel.self, from: data)
        return news.sources
    }
    
    static func loadTopHeadlines(resource: ResourceName) throws -> [Article] {
        let bundle = Bundle.test
        let url = bundle.url(forResource: resource.rawValue, withExtension: "json").unsafelyUnwrapped
        let data = try Data(contentsOf: url)
        let decoder = Decoders.plainDateDecoder
        let headlines = try decoder.decode(TopHeadlinesModel.self, from: data)
        return headlines.articles
    }
    
}

private extension Bundle {
    class Dummy { }
    static let test = Bundle(for: Dummy.self)
}
