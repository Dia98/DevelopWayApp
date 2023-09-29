//
//  Endpoint.swift
//  NextStackTestTask
//
//  Created by Diana Sargsyan on 21.03.23.
//

import Foundation

protocol Endpoint {
    
    var baseURLString: String { get }
    var httpMethod: HTTPMethod { get }
    var path: String { get }
    var body: Any? { get }
}

public struct HTTPMethod: RawRepresentable, Equatable, Hashable {

    public static let get = HTTPMethod(rawValue: "GET")

    public static let patch = HTTPMethod(rawValue: "PATCH")

    public static let post = HTTPMethod(rawValue: "POST")

    public static let put = HTTPMethod(rawValue: "PUT")
    
    public let rawValue: String

    public init(rawValue: String) {
        self.rawValue = rawValue
    }
}
