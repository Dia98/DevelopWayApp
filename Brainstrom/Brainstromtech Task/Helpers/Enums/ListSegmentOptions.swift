//
//  ListSegmentOptions.swift
//  Brainstromtech Task
//
//  Created by Diana Sargsyan on 19.08.23.
//

import Foundation

enum ListSegmentOptions: Int, CaseIterable {
    
    case receiving = 0
    case saved = 1
    
    var title: String {
        switch self {
        case .receiving:
            return "Users"
        case .saved:
            return "Saved Users"
        }
    }
}
