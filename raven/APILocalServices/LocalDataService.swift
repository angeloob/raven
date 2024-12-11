//
//  LocalDataService.swift
//  raven
//
//  Created by Angel Olvera on 10/12/24.
//

import Foundation

class LocalDataService {
    static let shared = LocalDataService()
    private init() {}

    private let fileName = "articles.json"
    private var fileURL: URL {
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentDirectory.appendingPathComponent(fileName)
    }

    func saveArticles(_ articles: [Article]) {
        do {
            let data = try JSONEncoder().encode(articles)
            try data.write(to: fileURL)
        } catch {
            print("Failed to save articles: \(error)")
        }
    }

    func loadArticles() -> [Article] {
        do {
            let data = try Data(contentsOf: fileURL)
            let articles = try JSONDecoder().decode([Article].self, from: data)
            return articles
        } catch {
            print("Failed to load articles: \(error)")
            return []
        }
    }
}
