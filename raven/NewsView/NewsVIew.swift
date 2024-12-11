//
//  NewsVIew.swift
//  raven
//
//  Created by Angel Olvera on 10/12/24.
//

import SwiftUI

struct NewsView: View {
    @ObservedObject var viewModel: NewsViewModel

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.articles) { article in
                    ArticleRow(article: article)
                        .onAppear {
                            if article == viewModel.articles.last {
                                viewModel.refreshArticles()
                            }
                        }
                }
            }
            .navigationTitle("News")
            .onAppear {
                viewModel.fetchArticles()
            }
            .refreshable {
                viewModel.refreshArticles()
            }
            .alert(isPresented: $viewModel.showErrorAlert) {
                Alert(
                    title: Text("Error"),
                    message: Text(viewModel.errorMessage ?? "An unknown error occurred."),
                    dismissButton: .default(Text("Dismiss"))
                )
            }
        }
    }
}

struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView(viewModel: NewsViewModel())
    }
}
