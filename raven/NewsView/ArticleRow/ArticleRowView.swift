//
//  ArticleRowView.swift
//  raven
//
//  Created by Angel Olvera on 10/12/24.
//

import SwiftUI

struct ArticleRow: View {
    var article: Article

    var body: some View {
        NavigationLink(destination: ArticleDetailView(article: article)) {
            HStack(alignment: .top) {
                if let imageUrl = article.media.first?.mediaMetadata.first?.url, let url = URL(string: imageUrl) {
                    AsyncImageView(url: url)
                } else {
                    Image("nyt_placeholder")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 75, height: 75)
                        .clipped()
                }
                VStack(alignment: .leading, spacing: 5) {
                    Text(article.title)
                        .font(.headline)
                        .lineLimit(3)
                        .multilineTextAlignment(.leading)
                    Text(article.abstract)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .lineLimit(3)
                        .multilineTextAlignment(.leading)
                }
            }
        }
    }
}

struct ArticleRow_Previews: PreviewProvider {
    static var previews: some View {
        ArticleRow(article: Article(
            id: 100000009860792,
            uri: "nyt://article/f99a247f-4007-51fb-8f38-3227f5be02fc",
            url: "https://www.nytimes.com/2024/12/05/nyregion/social-media-insurance-industry-brian-thompson.html",
            assetId: 100000009860792,
            source: "New York Times",
            publishedDate: "2024-12-05",
            updated: "2024-12-06 09:10:16",
            section: "New York",
            subsection: "",
            column: nil,
            byline: "By Dionne Searcey and Madison Malone Kircher",
            type: "Article",
            title: "Torrent of Hate for Health Insurance Industry Follows C.E.O.’s Killing",
            abstract: "The shooting death of a UnitedHealthcare executive in Manhattan has unleashed Americans’ frustrations with an industry that often denies coverage and reimbursement for medical claims.",
            media: []
        ))
    }
}
