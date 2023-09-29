//
//  NetworkingManager.swift
//  Brainstromtech Task
//
//  Created by Diana Sargsyan on 18.08.23.
//

import Foundation

final class NetworkingManager {
    
    class var sharedManager : NetworkingManager {
        struct Singleton {
            static let instance = NetworkingManager()
        }
        return Singleton.instance
    }
    
    func getUsers(count: Int = 1, completion: @escaping (MainModel?) -> ()) {
        
        let urlString = UsersEndpoints.users(count: count).path

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
    
    func getBrainstormUsers(pageSize: Int = 15, page: Int, completion: @escaping (MainModel?) -> ()) {
        
        let urlString = UsersEndpoints.brainstormUsers(pageSize: pageSize, page: page).path

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
