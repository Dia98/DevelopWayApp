//
//  ContentView.swift
//  DevelopWayApp
//
//  Created by Diana Sargsyan on 15.10.21.
//

import SwiftUI

struct ContentView: View {
    
    var userIslogged: Bool {
        if let _ = UserManager.sharedInstance.getCurrentUser() {
            return true
        }
        return false
    }
    
    var body: some View {
        if userIslogged {
            ProfileView()
        } else {
            HomeView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
