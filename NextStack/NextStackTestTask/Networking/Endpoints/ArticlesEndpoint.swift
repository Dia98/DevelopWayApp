//
//  ArticlesEndpoint.swift
//  NextStackTestTask
//
//  Created by Diana Sargsyan on 21.03.23.
//

import Foundation

enum ArticlesEndpoint: Endpoint {

    case list(period: Int = 1)
    case detail(id: Int)
    
    var baseURLString: String {
        AppConstants.baseURL
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .list:
            return .get
        case .detail:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .list(let period):
            return baseURLString + "\(period)" + ".json?api-key=\(AppConstants.NYTimesAPIKey)"
        case .detail:
            return ""
        }
    }
    
    var body: Any? {
        switch self {
        case .list:
            return nil
        case .detail:
            return nil
        }

    }
}
