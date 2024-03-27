//
//  HomeVCTests.swift
//  NewsTests
//
//  Created by Mahmud CIKRIK on 8.03.2024.
//

import XCTest
@testable import News

final class HomeVCTests: XCTestCase {

    private var view: MockHomeView!
    private var service: MockNewsService!
    private var viewModel: HomeViewModel!
    
    override func setUp() {
        
        service = MockNewsService()
        viewModel = HomeViewModel(service: service)
        view = MockHomeView()
        viewModel.delegateVC = view
        
    }
    
    func testLoad() throws {
        
        // GIVEN
        let sources = try ResourceLoader.loadSources(resource: .source)
        service.source = sources
        
        // WHEN
        viewModel.loadData()
        
        // THEN
        XCTAssertEqual(view.outputs.count, 5)
        XCTAssertNotNil(view.outputs[0]) // If .updateTitle not nil = Sucess!!
        XCTAssertEqual(view.outputs[1], .setLoading(true))
        XCTAssertEqual(view.outputs[2], .setLoading(false))
        let expectedSources = sources.map({ HomeModel(model: $0) })
        let expectedCategories = sources.compactMap({ $0.category })
        XCTAssertEqual(view.outputs[3], .showNewsList(expectedSources))
        XCTAssertEqual(view.outputs[4], .showButtons(expectedCategories))

    }
    
    func testNavigation() throws {
        
        // GIVEN
        let sources = try ResourceLoader.loadSources(resource: .source)
        service.source = sources
        viewModel.loadData()
        view.reset()
        
        // WHEN
        viewModel.selectNews(at: 0)
        
        // THEN
        XCTAssertTrue(view.newsDetailRouteCalled)
        
    }
}
