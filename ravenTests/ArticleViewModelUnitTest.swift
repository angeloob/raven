//
//  ravenTests.swift
//  ravenTests
//
//  Created by Angel Olvera on 09/12/24.
//

import XCTest
import Foundation
import Combine
@testable import raven

class ArticleViewModelTests: XCTestCase {
    var viewModel: NewsViewModel!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        viewModel = NewsViewModel(newsAPIService: NewsAPIServiceMock(shouldReturnError: false))
        cancellables = []
    }

    override func tearDown() {
        viewModel = nil
        cancellables = nil
        super.tearDown()
    }

    func testFetchArticlesSuccess() {
        let expectation = XCTestExpectation(description: "Fetch articles successfully")

        viewModel.$articles
            .dropFirst()
            .sink { articles in
                XCTAssertFalse(articles.isEmpty, "Articles should not be empty")
                expectation.fulfill()
            }
            .store(in: &cancellables)

        viewModel.fetchArticles()

        wait(for: [expectation], timeout: 5.0)
    }

    func testFetchArticlesFailure() {
        let expectation = XCTestExpectation(description: "Fetch articles failure")
        viewModel = NewsViewModel(newsAPIService: NewsAPIServiceMock(shouldReturnError: true))

        viewModel.$showErrorAlert
            .dropFirst()
            .sink { showErrorAlert in
                XCTAssertTrue(showErrorAlert, "Error alert should be shown")
                expectation.fulfill()
            }
            .store(in: &cancellables)

        viewModel.fetchArticles()

        wait(for: [expectation], timeout: 5.0)
    }
}
