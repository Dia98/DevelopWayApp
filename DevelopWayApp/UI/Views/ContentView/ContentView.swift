//
//  ContentView.swift
//  DevelopWayApp
//
//  Created by Diana Sargsyan on 15.10.21.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var model = ContentViewModel()
    
    private var profileModel: ProfileModel {
        if let user = UserManager.sharedInstance.getCurrentUser() {
            return ProfileModel.init(entity: user)
        } else {
            return ProfileModel.init(entity: nil)
        }
    }
    
    var body: some View {
        if model.userState == .loggedIn {
            ProfileView(model: profileModel)
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
