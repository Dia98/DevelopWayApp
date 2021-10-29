//
//  ViewModifiers.swift
//  DevelopWayApp
//
//  Created by Diana Sargsyan on 17.10.21.
//

import Foundation
import SwiftUI

struct InertBackroundedModifier : ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.vertical, 3)
            .padding(.leading, 5)
            .background(Color.inertBlue.opacity(0.1).cornerRadius(5))
            .foregroundColor(.darkBlue)
    }
}

struct EmailModifier : ViewModifier {
    func body(content: Content) -> some View {
        content
            .keyboardType(.emailAddress)
            .textContentType(.emailAddress)
            .disableAutocorrection(true)
            .autocapitalization(.none)
    }
}

struct RoundedModifier : ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.inertBlue, lineWidth: 2)
            )
    }
}

struct RoundedFillModifier : ViewModifier {
    func body(content: Content) -> some View {
            content
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.neoCyan)
                )
    }
}

struct TextFieldWithIcon : ViewModifier {
    var imageName: String
    var trailingPadding: CGFloat = 0
    
    func body(content: Content) -> some View {
        HStack {
            Image(systemName: imageName)
                .font(.system(size: 20))
                .foregroundColor(.inertBlue)
                .padding(.trailing, trailingPadding)
            
            content
                .modifier(RoundedModifier())
                .foregroundColor(.neoCyan)
        }
    }
}

struct TitleTextModifier : ViewModifier {
    var title: String
    func body(content: Content) -> some View {
        HStack {
            Text("\(title)")
                .foregroundColor(.inertBlue)
            
            content
                .foregroundColor(.neoCyan)
        }
    }
}
