//
//  ContentView.swift
//  SimplyTechnologiesTest_
//
//  Created by Diana Sargsyan on 20.12.22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var selection: Item = .home
    
    var body: some View {
        TabBar(selection: $selection) {
            HomeView()
                .tabItem(for: Item.home)
            
            Text("Vehicle")
                .tabItem(for: Item.vehicle)

            Text("Location")
                .tabItem(for: Item.location)

            Text("Settings")
                .tabItem(for: Item.settings)
        }
        .tabBar(style: CustomTabBarStyle())
        .tabItem(style: CustomTabItemStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
