//
//  ArticleModel.swift
//  raven
//
//  Created by Angel Olvera on 10/12/24.
//

import Foundation

struct Article: Identifiable, Codable, Equatable {
    var id: Int
    var uri: String
    var url: String
    var assetId: Int
    var source: String
    var publishedDate: String
    var updated: String
    var section: String
    var subsection: String?
    var column: String?
    var byline: String
    var type: String
    var title: String
    var abstract: String
    var media: [Media]

    enum CodingKeys: String, CodingKey {
        case id
        case uri
        case url
        case assetId = "asset_id"
        case source
        case publishedDate = "published_date"
        case updated
        case section
        case subsection
        case column
        case byline
        case type
        case title
        case abstract
        case media
    }

    static func == (lhs: Article, rhs: Article) -> Bool {
        return lhs.id == rhs.id
    }
}

struct Media: Codable {
    var type: String
    var subtype: String
    var caption: String
    var copyright: String
    var mediaMetadata: [MediaMetadata]

    enum CodingKeys: String, CodingKey {
        case type
        case subtype
        case caption
        case copyright
        case mediaMetadata = "media-metadata"
    }
}

struct MediaMetadata: Codable {
    var url: String
    var format: String
    var height: Int
    var width: Int
}
