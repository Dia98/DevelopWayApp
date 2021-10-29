//
//  ViewExtensions.swift
//  DevelopWayApp
//
//  Created by Diana Sargsyan on 18.10.21.
//

import Foundation
import SwiftUI

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}

extension View {
    func keyboardDragClose() -> some View {
        gesture(DragGesture().onChanged{_ in UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)})
    }
}

extension View {
    func keyboardTapClose() -> some View {
        gesture(TapGesture().onEnded({ _ in
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }))
    }
}

extension View {
    func randomButtonStyle() -> some View {
        self.modifier(RandomButtonStyle())
    }
}
