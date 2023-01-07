//
//  HomeViewModel.swift
//  SimplyTechnologiesTest_
//
//  Created by Diana Sargsyan on 20.12.22.
//

import Foundation
import SwiftUI
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var doors: Doors = Doors(loced: false)
    @Published var engine: Engine = Engine(onStart: false)
    @Published var hornAndLights: HornAndLights = HornAndLights()
    @Published var location: Location = Location()
    @Published var notifications: [Notification] = [Notification(), Notification(), Notification()]
    
    @Published var startAnimation: Bool = false {
        willSet {
            objectWillChange.send()
        }
    }
    @Published var alert: AlertItem?
    @Published var showAlert: Bool = false {
        didSet {
            if showAlert {
                setupAlert()
            }
        }
    }
    
    private func setupAlert() {
        alert = AlertItem(systemAlert: Alert(title: Text("Are you sure"),
                                             message: Text("Please confirm that you want to lock the doors of \("My QX55")"),
                                             primaryButton: .default(Text("Yes, Unlock"), action: {
                                                    self.unlock()
                                                }) ,secondaryButton: .cancel()))
    }
    
    private func unlock(){
        showAlert = false
        startAnimation.toggle()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.doors.loced = !self.doors.loced
            self.startAnimation.toggle()
        }
    }
}
