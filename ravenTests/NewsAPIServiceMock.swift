//
//  NewsAPIServiceMock.swift
//  ravenTests
//
//  Created by Angel Olvera on 10/12/24.
//

import Foundation
import Combine
@testable import raven

class NewsAPIServiceMock: NewsAPIService {
    var shouldReturnError: Bool

    init(shouldReturnError: Bool) {
        self.shouldReturnError = shouldReturnError
        super.init()
    }

    override func fetchArticles() -> AnyPublisher<[Article], NewsAPIError> {
        if shouldReturnError {
            return Fail(error: NewsAPIError.networkError(NSError(domain: "", code: -1, userInfo: nil)))
                .eraseToAnyPublisher()
        } else {
            let articles = [Article(id: 1,
                                    uri: "uri",
                                    url: "url",
                                    assetId: 1,
                                    source: "source",
                                    publishedDate: "2024-12-05",
                                    updated: "2024-12-06",
                                    section: "section",
                                    subsection: nil,
                                    column: nil,
                                    byline: "byline",
                                    type: "type",
                                    title: "title",
                                    abstract: "abstract",
                                    media: [])]
            return Just(articles)
                .setFailureType(to: NewsAPIError.self)
                .eraseToAnyPublisher()
        }
    }

    override func fetchArticlesFromLocal() -> [Article] {
        return [Article(id: 1,
                        uri: "uri",
                        url: "url",
                        assetId: 1,
                        source: "source",
                        publishedDate: "2024-12-05",
                        updated: "2024-12-06",
                        section: "section",
                        subsection: nil,
                        column: nil,
                        byline: "byline",
                        type: "type",
                        title: "title",
                        abstract: "abstract",
                        media: [])]
    }
}
