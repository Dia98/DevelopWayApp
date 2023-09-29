//
//  ArticleDetailViewModel.swift
//  NextStackTestTask
//
//  Created by Diana Sargsyan on 21.03.23.
//

import Foundation

class ArticleDetailViewModel: ObservableObject {
    
    @Published var currentArticles: [Result]? = nil
    
    init () {
        getArticles()
    }
    
    func getArticles() {
        NetworkingManager.sharedManager.getCurrentPopularArticles { [weak self] info in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                if let resopnse = info {
                    self.currentArticles = resopnse.results
                } else {
                    
                }
            }
        }
    }
    
}
