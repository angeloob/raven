//
//  ArticleView.swift
//  raven
//
//  Created by Angel Olvera on 10/12/24.
//

import SwiftUI

struct ArticleDetailView: View {
    var article: Article

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(article.title)
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.leading)
                .padding(.bottom, 10)

            if let imageUrl = article.media.first?.mediaMetadata.last?.url, let url = URL(string: imageUrl) {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity)
                        .clipped()
                } placeholder: {
                    ProgressView()
                        .frame(maxWidth: .infinity)
                }
            }

            Text(article.byline)
                .font(.subheadline)
                .foregroundColor(.secondary)

            Text(formattedDate(from: article.publishedDate))
                .font(.subheadline)
                .foregroundColor(.secondary)

            Text(article.abstract)
                .font(.body)
                .padding(.top, 10)

            Spacer()
        }
        .padding()
    }

    private func formattedDate(from dateString: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        if let date = formatter.date(from: dateString) {
            formatter.dateStyle = .long
            formatter.locale = Locale(identifier: "es_ES")
            return formatter.string(from: date)
        }
        return dateString
    }
}

struct ArticleDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleDetailView(article: Article(
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
