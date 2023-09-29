//
//  UsersEndpoints.swift
//  Brainstromtech Task
//
//  Created by Diana Sargsyan on 18.08.23.
//

import Foundation

enum UsersEndpoints: Endpoint {
    
    case users(count: Int)
    case brainstormUsers(pageSize: Int = 20, page: Int)
    
    var baseURLString: String {
        AppConstants.baseURL
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .users:
            return .get
        case .brainstormUsers:
            return .get
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .users:
            return nil
        case .brainstormUsers:
            return nil
        }
    }
    
    var path: String {
        switch self {
        case .users(let count):
            return baseURLString + "?results=\(count)"
        case .brainstormUsers(let pageSize, let page):
            return baseURLString + "?seed=brainstorm&results=\(pageSize)&page=\(page)"
        }
    }
    
    var body: Any? {
        switch self {
        case .users:
            return nil
        case .brainstormUsers:
            return nil
        }
    }
}
