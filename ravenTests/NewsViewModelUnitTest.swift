//
//  NewsViewUnitTest.swift
//  ravenTests
//
//  Created by Angel Olvera on 10/12/24.
//

import XCTest
import SwiftUI
@testable import raven

class NewsViewTests: XCTestCase {
    func testNewsView() {
        let viewModel = NewsViewModel(newsAPIService: NewsAPIServiceMock(shouldReturnError: false))
        let newsView = NewsView(viewModel: viewModel)

        // Render the view
        let hostingController = UIHostingController(rootView: newsView)
        XCTAssertNotNil(hostingController.view, "The view should be created successfully")

        // Simulate view appearing
        viewModel.fetchArticles()

        // Verify the view's state
        XCTAssertFalse(viewModel.articles.isEmpty, "Articles should not be empty after fetching")
    }
}
