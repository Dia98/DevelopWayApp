//
//  AlertItem.swift
//  DevelopWayApp
//
//  Created by Diana Sargsyan on 23.10.21.
//

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
            //alert when view not visible causes crash sometime.
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
    
    var title = ""
    var message = ""
    var dismiss: (() -> ())?
    var custom: Alert?
    
    init(message: String, title: String = "", dismiss: (() -> ())? = nil) {
        self.message = message
        self.title = title
        self.dismiss = dismiss
    }
    
    
    init(custom: Alert) {
        self.custom = custom
    }
    
    var alert: Alert {
        if let c = custom {
            return c
        }
        return Alert(title: Text(title), message: Text(message),
                     dismissButton: .default(Text("OK"), action: { self.dismiss?() }))
    }
}

extension View {
    func setupAlert(_ alert: Binding<AlertItem?>) -> some View {
        modifier(AlertView(alert: alert))
    }
}
