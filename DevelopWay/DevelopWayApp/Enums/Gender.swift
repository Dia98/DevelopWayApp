//
//  Gender.swift
//  DevelopWayApp
//
//  Created by Diana Sargsyan on 16.10.21.
//

import Foundation

enum Gender: String, Identifiable {
    
    case women = "Male"
    case men = "Female"
    case other = "Other"
    
    var id: String {
        return self.rawValue
    }
}
