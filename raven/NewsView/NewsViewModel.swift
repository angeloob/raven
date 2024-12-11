//
//  NewsViewModel.swift
//  raven
//
//  Created by Angel Olvera on 10/12/24.
//

import Foundation
import Combine

class NewsViewModel: ObservableObject {
    @Published var articles: [Article] = []
    @Published var showErrorAlert: Bool = false
    @Published var errorMessage: String?
    private var cancellables = Set<AnyCancellable>()
    private let newsAPIService: NewsAPIService
    
    init(newsAPIService: NewsAPIService = NewsAPIService.shared) {
        self.newsAPIService = newsAPIService
        fetchArticles()
    }
    
    func fetchArticles() {
        newsAPIService.fetchArticles()
            .retry(3) // Reintenta la solicitud hasta 3 veces en caso de error
            .catch { [weak self] error -> AnyPublisher<[Article], Never> in
                self?.errorMessage = error.localizedDescription
                self?.showErrorAlert = true
                return Just(self?.newsAPIService.fetchArticlesFromLocal() ?? []).eraseToAnyPublisher()
            }
            .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] articles in
                self?.articles = articles
            })
            .store(in: &cancellables)
    }
    
    func refreshArticles() {
        fetchArticles()
    }
}
