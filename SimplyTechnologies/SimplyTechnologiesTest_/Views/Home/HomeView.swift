//
//  HomeView.swift
//  SimplyTechnologiesTest_
//
//  Created by Diana Sargsyan on 20.12.22.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject private var viewModel: HomeViewModel = HomeViewModel()
    
    var body: some View {
        ZStack {
            beckroundGradient
            
            ScrollView(showsIndicators: false) {
                
                header
                
                ZStack {
                    beckroundView
                    
                    VStack {
                        updatedButton
                        
                        carModelImages
                        
                        activitiOptionsList
                    }
                }
            }
            .mask(
                bottomGradient
            )
            
        }
        .setupAlert($viewModel.alert)
    }
    
    private var updatedButton: some View {
        Button {
            
        } label: {
            HStack(spacing: 0) {
                Image("refresh_icon")
                
                Text("Updated 1min ago")
                    .fontWeight(.bold)
                    .foregroundColor(.black.opacity(0.6))
            }
        }
        .padding(.top)
    }
    
    private var carModelImages: some View {
        ScrollView {
            LazyHStack {
                ImagePageView()
            }
        }
    }
    
    private var beckroundView: some View {
        VStack(spacing: 0) {
            Color.gray.opacity(0.2)
                .frame(maxHeight: 110)
            
            Color.gray.opacity(0.5)
        }
    }
    
    private var header: some View {
        HStack {
            Spacer()
            
            Text("MY QX55")
            
            Rectangle()
                .frame(height: 30)
                .frame(maxWidth: 2)
                .foregroundColor(.appBrown)
            
            Image("gas_icon")
            Text("120mi")
                .fontWeight(.heavy)
            
            Spacer()
        }
    }
    
    private var bottomGradient: some View {
        LinearGradient(gradient: Gradient(colors: [Color.white, Color.white, Color.white, Color.white, Color.white.opacity(0)]), startPoint: .top, endPoint: .bottom)
    }
    
    private var beckroundGradient: some View {
        LinearGradient(gradient: Gradient(colors: [Color(.white), Color(.white)]), startPoint: .topLeading, endPoint: .bottomTrailing)
            .ignoresSafeArea()
    }
    
    private var activitiOptionsList: some View {
        Grid(alignment: .center,
             horizontalSpacing: 30,
             verticalSpacing: 30) {
            
            GridRow {
                DoorsView(doors: $viewModel.doors, showAlert: $viewModel.showAlert, startAnimation: viewModel.startAnimation)
                
                EngineView(engine: $viewModel.engine)
            }
            
            GridRow {
                HornAndLightsView(hornAndLights: $viewModel.hornAndLights)
                
                LocationView(location: $viewModel.location)
            }
            
            GridRow {
                AlertsView()
                
                NotificationsView(notifications: viewModel.notifications)
            }
        }
             .padding(.horizontal, 30)
             .padding(.vertical)
             .padding(.bottom, 200)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
