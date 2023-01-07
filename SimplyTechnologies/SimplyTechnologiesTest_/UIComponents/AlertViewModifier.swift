//
//  AlertViewModifier.swift
//  SimplyTechnologiesTest_
//
//  Created by Diana Sargsyan on 21.12.22.
//

import Foundation
import SwiftUI

struct AlertView: ViewModifier {
    let alert: Binding<AlertItem?>
    @State private var alertEnabled = false
    
    func body(content: Content) -> some View {
        VStack(spacing: 0) {
            content
            Rectangle()
                .frame(width: 0, height: 0)
                .alert(item: alertV) { i in
                    i.alert
                }
        }
        .onAppear {
            self.alertEnabled = true
        }
        .onDisappear {
            self.alertEnabled = false
        }
    }
    
    private var alertV: Binding<AlertItem?> {
        .init(get: {
            if !self.alertEnabled {
                return nil
            }
            return self.alert.wrappedValue
            
        }, set: { self.alert.wrappedValue = $0})
    }
}

struct AlertItem: Identifiable {
    let id = UUID()
    var systemAlert: Alert?
    
    init(systemAlert: Alert) {
        self.systemAlert = systemAlert
    }
    
    var alert: Alert {
        if let alert = systemAlert {
            return alert
        }
        return Alert(title: Text("Something went wrong"), message: Text(""),
                     dismissButton: .default(Text("OK"), action: nil))
    }
}

extension View {
    func setupAlert(_ alert: Binding<AlertItem?>) -> some View {
        modifier(AlertView(alert: alert))
    }
}
