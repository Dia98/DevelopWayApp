//
//  View + Extensions.swift
//  SimplyTechnologiesTest_
//
//  Created by Diana Sargsyan on 20.12.22.
//

import Foundation
import SwiftUI

extension View {
    public func maskedForeground(color: Color) -> some View {
        self.overlay(color)
        .mask(self)
    }
}

extension View {
    var verticalTextSeparator: some View {
        Rectangle()
            .frame(height: 20)
            .frame(maxWidth: 2)
            .foregroundColor(.gray)
    }
}
