//
//  Models.swift
//  SimplyTechnologiesTest_
//
//  Created by Diana Sargsyan on 20.12.22.
//

import Foundation

struct Doors {
    
    var loced: Bool
}


struct Engine {
    
    var onStart: Bool
}

struct HornAndLights {
    
    var lightIsOn: Bool = false
    var lightAndHornIsOn: Bool = false
}

struct Location {
    
    var longitude: Double = 0
    var latitude: Double = 0
    var address: String = ""
    var lasteDate: Date = Date()
}


struct AlertInfo {
    
    var iconName: String
    var type: String
    var stste: Bool
}

struct Notification {
    
    var message: String = ""
    var time: Date = Date()
}
