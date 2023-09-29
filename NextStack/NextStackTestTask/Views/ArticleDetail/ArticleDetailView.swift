//
//  ArticleDetailView.swift
//  NextStackTestTask
//
//  Created by Diana Sargsyan on 21.03.23.
//

import SwiftUI

struct ArticleDetailView: View {
    var article: Result
    
    @State var selectedImageIndex = 0
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                title
                
                metaInfo
                
                images
                
                description
                
                Spacer()
            }
            .padding(.horizontal)
        }
    }
    
    private var description: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(article.abstract)
                .font(.body)
            
            ForEach(article.desFacet, id: \.self) { item in
                Text(item)
            }
        }
    }
    
    private var title: some View {
        Text(article.title)
            .font(.title)
    }
    
    private var metaInfo: some View {
        HStack {
            Text(article.updated)
            
            Spacer()
            
            Text(article.subsection)
        }
    }
    
    private var images: some View {
        TabView(selection: $selectedImageIndex) {
            ForEach(article.media, id: \.self) { item in
                
                if let mediaMetadata = item.mediaMetadata.last {
                    AsyncImage(
                        url: URL(string: mediaMetadata.url)!,
                        placeholder: {
                            ProgressView()
                        },
                        image: {
                            Image(uiImage: $0)
                                .resizable()
                                .renderingMode(.original)
                        }
                    )
                    .frame(width: CGFloat(mediaMetadata.width), height: CGFloat(mediaMetadata.height), alignment: .top)
                    
                } else {
                    VStack {
                        Spacer()
                        ProgressView()
                        Spacer()
                    }
                }
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
        .frame(minHeight: 300)
    }
}

struct ArticleDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleDetailView(article:
                            Result(uri: "nyt://article/b5a80351-bab7-51d9-8a75-0839caa96540",
                                   url: "https://www.nytimes.com/2023/03/20/sports/olympics/jennifer-fox-sexual-abuse-the-tale.html",
                                   id: 100000008770809,
                                   assetID: 100000008770809,
                                   source: Source(rawValue: "New York Times") ?? .newYorkTimes,
                                   publishedDate: "2023-03-20",
                                   updated: "2023-03-20 11:29:20",
                                   section: "Sports",
                                   subsection: "Olympics",
                                   nytdsection: "sports",
                                   adxKeywords: "Child Abuse and Neglect;Sex Crimes;Movies;Rowing;Content Type: Personal Profile;internal-sub-only;Coaches and Managers;Dern, Laura;Fox, Jennifer;Nash, Ted;US Center for SafeSport",
                                   column: nil,
                                   byline: "By Juliet Macur",
                                   type: ResultType(rawValue: "Article") ?? .article,
                                   title: "N.Y. Authorities Prepare for Unprecedented Arrest of an Ex-President",
                                   abstract: "Ahead of a likely indictment, law enforcement officials are making security plans as some of Donald J. Trump’s supporters signal that they intend to protest.",
                                   desFacet: [],
                                   orgFacet: [],
                                   perFacet: [],
                                   geoFacet: [],
                                   media: [
                                    Media(
                                        type: MediaType(rawValue: "image") ?? .image,
                                        subtype: Subtype(rawValue: "photo") ?? .photo,
                                        caption:"An arrest of former President Donald J. Trump would in some ways play out like any other. But in other ways it would be completely different.",
                                        copyright :"Haiyun Jiang/The New York Times",
                                        approvedForSyndication:1,
                                        mediaMetadata: [
                                            MediaMetadatum(
                                                url: "https://static01.nyt.com/images/2023/03/20/multimedia/20trump-security-1-mwgb/20trump-security-1-mwgb-mediumThreeByTwo210.jpg",
                                                format: Format(rawValue: "mediumThreeByTwo210") ?? .mediumThreeByTwo210,
                                                height: 140,
                                                width:210
                                            )
                                        ])
                                   ],
                                   etaID: 0))
    }
}
