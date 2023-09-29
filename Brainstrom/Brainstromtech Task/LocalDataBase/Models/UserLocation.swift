//
//  UserLocation.swift
//  Brainstromtech Task
//
//  Created by Diana Sargsyan on 20.08.23.
//

import Foundation
import MapKit

struct UserLocation: Identifiable, Equatable, Hashable {
    
    func hash(into hasher: inout Hasher) {
      hasher.combine(id)
    }
    
    static func == (lhs: UserLocation, rhs: UserLocation) -> Bool {
        return lhs.id == rhs.id
    }
    
    var id = UUID()
    var coordinates: CLLocationCoordinate2D
}
