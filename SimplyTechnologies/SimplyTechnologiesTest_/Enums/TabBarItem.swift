//
//  TabBarItem.swift
//  SimplyTechnologiesTest_
//
//  Created by Diana Sargsyan on 20.12.22.
//

import Foundation

enum Item: Int, Tabbable {
    case home = 0
    case vehicle
    case location
    case settings
    
    var icon: String {
        switch self {
        case .home:
            return "home_icon"
        case .vehicle:
            return "vehicle_icon"
        case .location:
            return "location_icon"
        case .settings:
            return "settings_icon"
        }
    }
    
    var title: String {
        switch self {
        case .home:
            return "Home"
        case .vehicle:
            return "Vehicle"
        case .location:
            return "Location"
        case .settings:
            return "Settings"
        }
    }
}
