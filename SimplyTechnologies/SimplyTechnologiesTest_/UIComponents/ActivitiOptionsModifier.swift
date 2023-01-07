//
//  ActivitiOptionsModifier.swift
//  SimplyTechnologiesTest_
//
//  Created by Diana Sargsyan on 21.12.22.
//

import SwiftUI

struct ActivitiOptionsModifier : ViewModifier {
    
    var height: CGFloat = 90
    
    func body(content: Content) -> some View {
        RoundedRectangle(cornerRadius: 4)
            .fill(Color.white.opacity(0.6))
            .overlay(content
                        .padding(12))
            .frame(height: height)
    }
}
