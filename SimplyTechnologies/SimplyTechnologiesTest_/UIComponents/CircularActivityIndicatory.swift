//
//  CircularActivityIndicatory.swift
//  SimplyTechnologiesTest_
//
//  Created by Diana Sargsyan on 21.12.22.
//

import SwiftUI

struct CircularActivityIndicatory: View {
    
    var frameWidth: CGFloat
    @State var spinCircle = false
    
    var body: some View {
        ZStack {
            Circle()
                .trim(from: 0.5, to: 1)
                .stroke(Color.appBrown, lineWidth:4)
                .frame(width: frameWidth)
                .rotationEffect(.degrees(spinCircle ? 0 : -360), anchor: .center)
                .animation(
                    Animation.linear(duration: 1).repeatForever(autoreverses: false), value: UUID()
                )
        }
        .onAppear {
            self.spinCircle = true
        }
    }
}

struct CircularActivityIndicatory_Previews: PreviewProvider {
    static var previews: some View {
        CircularActivityIndicatory(frameWidth: 100)
    }
}
