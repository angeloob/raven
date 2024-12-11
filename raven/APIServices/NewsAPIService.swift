//
//  NewsAPIService.swift
//  raven
//
//  Created by Angel Olvera on 10/12/24.
//

import Foundation
import Combine

enum NewsAPIError: LocalizedError {
    case networkError(Error)
    case serverError(statusCode: Int)
    case decodingError(Error)
    case unknownError

    var errorDescription: String? {
        switch self {
        case .networkError(let error):
            return error.localizedDescription
        case .serverError(let statusCode):
            return "Server returned an error with status code \(statusCode)."
        case .decodingError(let error):
            return "Failed to decode the response: \(error.localizedDescription)"
        case .unknownError:
            return "An unknown error occurred."
        }
    }
}

class NewsAPIService {
    static let shared = NewsAPIService()
    init() {} // Cambiar a internal o public

    func fetchArticles() -> AnyPublisher<[Article], NewsAPIError> {
        let apiKey = "qTl6HA9lEk9bHwEMNSrdjRAceMnSqQEZ"
        let url = URL(string: "https://api.nytimes.com/svc/mostpopular/v2/emailed/7.json?api-key=\(apiKey)")!
        return URLSession.shared.dataTaskPublisher(for: url)
            .mapError { NewsAPIError.networkError($0) }
            .tryMap { result -> Data in
                guard let httpResponse = result.response as? HTTPURLResponse else {
                    throw NewsAPIError.unknownError
                }
                guard httpResponse.statusCode == 200 else {
                    throw NewsAPIError.serverError(statusCode: httpResponse.statusCode)
                }
                return result.data
            }
            .mapError { error in
                if let newsAPIError = error as? NewsAPIError {
                    return newsAPIError
                } else {
                    return NewsAPIError.unknownError
                }
            }
            .decode(type: APIResponse.self, decoder: JSONDecoder())
            .mapError { NewsAPIError.decodingError($0) }
            .map { $0.results }
            .handleEvents(receiveOutput: { articles in
                LocalDataService.shared.saveArticles(articles)
            })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

    func fetchArticlesFromLocal() -> [Article] {
        return LocalDataService.shared.loadArticles()
    }
}

struct APIResponse: Codable {
    let results: [Article]
}
