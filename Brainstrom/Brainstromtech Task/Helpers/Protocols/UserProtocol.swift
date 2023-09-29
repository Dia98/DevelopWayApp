//
//  UserProtocol.swift
//  Brainstromtech Task
//
//  Created by Diana Sargsyan on 19.08.23.
//

import Foundation

protocol User: Hashable {
    associatedtype Identifier
        
    var identifier : Identifier { get }
    var fullName: String { get }
    var pictureUrl: String { get }
    var gender: String { get }
    var address: String { get }
    var phone: String { get }
    var latitude: Double { get }
    var longitude: Double { get }
}
