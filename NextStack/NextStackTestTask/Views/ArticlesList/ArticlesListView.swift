//
//  ArticlesListView.swift
//  NextStackTestTask
//
//  Created by Diana Sargsyan on 21.03.23.
//

import SwiftUI

struct ArticlesListView: View {
    
    @StateObject private var viewModel = ArticleDetailViewModel()
    
    var body: some View {
        if viewModel.currentArticles == nil {
            ProgressView()
        } else {
            listView
        }
    }
    
    private var listView: some View {
        NavigationView {
            ZStack {
                listContent
                
                if viewModel.currentArticles?.count == 0 {
                    Text("List is empty")
                }
            }
            .navigationTitle("NY Times")
        }
    }
    
    private var listContent: some View {
        List(viewModel.currentArticles!, id: \.self) { article in
            
            NavigationLink {
                ArticleDetailView(article: article)
            } label: {
                Item(article: article)
            }
        }
        .listStyle(PlainListStyle())
    }
}

private extension ArticlesListView {
    struct Item: View {
        
        var article: Result
        
        var body: some View {
            HStack {
                image
                
                Text(article.title)
                    .frame(height: 50)
                    .truncationMode(.tail)
            }
        }
        
        private var image: some View {
            VStack {
                if let media = article.media.first,
                   let item = media.mediaMetadata.first {
                    
                    AsyncImage(
                        url: URL(string: item.url)!,
                        placeholder: {
                            ZStack {
                                
                                ProgressView()
                            }
                        },
                        image: {
                            Image(uiImage: $0)
                                .resizable()
                        }
                    )
                    .scaledToFill()
                    .cornerRadius(CGFloat(item.width) / 2)
                    .frame(width: CGFloat(item.width), height: CGFloat(item.height), alignment: .center)
                    
                } else {
                    ProgressView()
                }
            }
        }
    }
}

struct ArticlesListView_Previews: PreviewProvider {
    static var previews: some View {
        ArticlesListView()
    }
}
