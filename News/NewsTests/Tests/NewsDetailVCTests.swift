//
//  NewsDetailVCTests.swift
//  NewsTests
//
//  Created by Mahmud CIKRIK on 8.03.2024.
//

import XCTest
@testable import News

final class NewsDetailVCTests: XCTestCase {

    private var view: MockNewsDetailView!
    private var service: MockNewsService!
    private var viewModel: NewsDetailViewModel!
    
    override func setUp() {
        
        service = MockNewsService()
        viewModel = NewsDetailViewModel(service: service)
        view = MockNewsDetailView()
        viewModel.delegateVC = view
        
    }
    
    func testLoad() throws {
        
        // GIVEN
        
        let news = try ResourceLoader.loadTopHeadlines(resource: .headlines)
        service.news = news
        
        // WHEN
        
        viewModel.load()
        
        // THEN
        
        let expectedSliderList = news.map({ NewsDetailModel(news: $0) })
        let expectedTableList = news.map({ NewsDetailModel(news: $0) })
        
        XCTAssertEqual(view.outputs.count, 5)
        XCTAssertNotNil(view.outputs[0]) // Checking .updateTitle
        XCTAssertEqual(view.outputs[1], .setLoading(true))
        XCTAssertEqual(view.outputs[2], .setLoading(false))
        XCTAssertEqual(view.outputs[3], .showSliderList(expectedSliderList))
        XCTAssertEqual(view.outputs[4], .showTableList(expectedTableList))

    }

}
