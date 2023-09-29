//
//  NetworkingManager.swift
//  NextStackTestTask
//
//  Created by Diana Sargsyan on 21.03.23.
//

import Foundation

final class NetworkingManager {
    
    class var sharedManager : NetworkingManager {
        struct Singleton {
            static let instance = NetworkingManager()
        }
        return Singleton.instance
    }
    
    func getCurrentPopularArticles(period: Int = 1, completion: @escaping (MainModel?) -> ()) {
        
        let urlString = ArticlesEndpoint.list().path

        if let url = URL(string: urlString) {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                
                
                if let error = error {
                    print(error)
                    return
                }
                guard let data = data else {
                    print("Did not receive data")
                    return
                }
                do {
                    let result = try JSONDecoder().decode(MainModel.self, from: data)
                    
                    completion(result)
                    return
                } catch {
                    print("Error: can not convert data to JSON")
                    completion(nil)
                    return
                }
            }
            task.resume()
        }
        completion(nil)
        return
    }
}
