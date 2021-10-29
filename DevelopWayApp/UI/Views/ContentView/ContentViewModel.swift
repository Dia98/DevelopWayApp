//
//  ContentViewModel.swift
//  DevelopWayApp
//
//  Created by Diana Sargsyan on 29.10.21.
//

import Foundation
import SwiftUI

class ContentViewModel : ObservableObject {
    
    @Published var currentUser: UserEntity?
    @Published var userState: UserState = .unregistered
    
    init() {
        getUserState()
        addNotificationObserver()
    }
    
    private func addNotificationObserver() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.activeSessionDidChangedNotification(_:)),
                                               name: NSNotification.Name.activeUserDidChanged,
                                               object: nil)
    }
    
    @objc func activeSessionDidChangedNotification(_ notification: Notification) {
        getUserState()
    }
    
    private func getUserState() {
        if let user = UserManager.sharedInstance.getCurrentUser() {
            userState = .loggedIn
            currentUser = user
        } else {
            userState = .unregistered
        }
        objectWillChange.send()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
