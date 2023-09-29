//
//  SavedUserModel.swift
//  Brainstromtech Task
//
//  Created by Diana Sargsyan on 18.08.23.
//

import Foundation


class SavedUserModel: User, Hashable {
    typealias Identifier = String
    
    static func == (lhs: SavedUserModel, rhs: SavedUserModel) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    var identifier: String {
        return id
    }
    
    let id : String
    let fullName: String
    let pictureUrl: String
    let gender: String
    let address: String
    let phone: String
    let latitude, longitude: Double
    
    init(id: String, fullName: String, pictureUrl: String, gender: String, address: String, phone: String, latitude: Double, longitude: Double) {
        
        self.id = id
        self.fullName = fullName
        self.pictureUrl = pictureUrl
        self.gender = gender
        self.address = address
        self.phone = phone
        self.latitude = latitude
        self.longitude = longitude
    }
}
