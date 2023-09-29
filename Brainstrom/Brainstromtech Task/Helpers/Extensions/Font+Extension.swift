//
//  Font+Extension.swift
//  Brainstromtech Task
//
//  Created by Diana Sargsyan on 19.08.23.
//

import Foundation
import SwiftUI

extension Font {
    
    static let sfPro = "SF Pro Text"
    
    public static func sfPro(size: CGFloat) -> Font {
        return .custom(sfPro, size: size)
    }
}
