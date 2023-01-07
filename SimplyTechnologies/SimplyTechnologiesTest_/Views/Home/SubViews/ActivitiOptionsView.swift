//
//  ActivitiOptionsView.swift
//  SimplyTechnologiesTest_
//
//  Created by Diana Sargsyan on 21.12.22.
//

import SwiftUI

// MARK: - DoorsView

struct DoorsView: View {
    
    @Binding var doors: Doors
    @Binding var showAlert: Bool
    var startAnimation: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            header
            
            HStack() {
                
                actionButton(loced: true)
                
                actionButton(loced: false)
            }
            .modifier(ActivitiOptionsModifier())
        }
    }
    
    private func actionButton(loced: Bool) -> some View {
        Button {
            if !startAnimation && loced == doors.loced {
                withAnimation {
                    showAlert.toggle()
                }
            }
        } label: {
            if startAnimation && loced == doors.loced {
                CircularActivityIndicatory(frameWidth: 60)
            } else {
                Circle()
                    .fill(loced == doors.loced ? .black : .appBrown)
                    .overlay(Image(loced ? "lock_icon" : "unlock_icon")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.white)
                        .padding(12))
                    .frame(width: 60, height: 60)
            }
        }
    }
    
    private var header: some View {
        HStack {
            Text("Doors")
                .fontWeight(.semibold)
            
            verticalTextSeparator
            
            
            Text(startAnimation ? "..." : (doors.loced ? "Locked" : "Unlocked"))
                .foregroundColor(.gray)
        }
    }
}

// MARK: - EngineView

struct EngineView: View {
    
    @Binding var engine: Engine
    
    var body: some View {
        VStack(alignment: .leading) {
            header
            
            HStack() {
                
                actionButton(onStart: true)
                
                actionButton(onStart: false)
            }
            .modifier(ActivitiOptionsModifier())
        }
    }
    
    private func actionButton(onStart: Bool) -> some View {
        Button {
            
        } label: {
            Circle()
                .fill(.black)
                .overlay(
                    Text(onStart ? "START" : "STOP")
                        .font(.system(size: 13))
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(5))
                .frame(width: 60, height: 60)
        }
    }
    
    private var header: some View {
        HStack {
            Text("Engine")
                .fontWeight(.semibold)
        }
    }
}

// MARK: - HornAndLights

struct HornAndLightsView: View {
    
    @Binding var hornAndLights: HornAndLights
    
    var body: some View {
        VStack(alignment: .leading) {
            header
            
            HStack() {
                
                actionButton(onliLight: false)
                
                actionButton(onliLight: true)
            }
            .modifier(ActivitiOptionsModifier())
        }
    }
    
    private func actionButton(onliLight: Bool) -> some View {
        Button {
            
        } label: {
            ZStack {
                Circle()
                    .fill(.black)
                    .frame(width: 60, height: 60)
                
                Circle()
                    .fill(.white)
                    .overlay(
                        Image(onliLight ? "light_icon" : "horn&light_icon")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.white)
                            .padding(onliLight ? 15 : 5))
                    .frame(width: 56, height: 56)
            }
        }
    }
    
    private var header: some View {
        HStack {
            Text("Horn & Lights")
                .fontWeight(.semibold)
        }
    }
}

// MARK: - Location

struct LocationView: View {
    
    @Binding var location: Location
    
    var body: some View {
        VStack(alignment: .leading) {
            header
            
            ZStack {
                Image("map_icon")
                    .resizable()
                    .scaledToFit()
                
                HStack {
                    
                    ZStack {
                        Image("aim_icon")
                            .resizable()
                            .maskedForeground(color: .appBrown)
                            .frame(width: 55.0, height: 55.0)
                        
                        Image("vehicle_icon")
                            .resizable()
                            .maskedForeground(color: .appBrown)
                            .frame(width: 25.0, height: 25.0)
                    }
                    
                    VStack {
                        Text("Irvine")
                            .foregroundColor(.black)
                            .fontWeight(.bold)
                        
                        Text("CA")
                            .foregroundColor(.gray)
                            .fontWeight(.bold)
                    }
                }
            }
            .modifier(ActivitiOptionsModifier())
        }
    }
    
    private var header: some View {
        HStack {
            Text("Locate")
                .fontWeight(.semibold)
            
            verticalTextSeparator
            
            Text("2d ago")
                .foregroundColor(.gray)
        }
    }
}

// MARK: - AlertView

struct AlertsView: View {
    
    let icons: [String] = ["square.grid.3x3.square", "alarm", "clock", "key.viewfinder"]
    
    var body: some View {
        VStack(alignment: .leading) {
            header
            
            VStack(spacing: 2) {
                
                Spacer()
                
                Text("2")
                    .foregroundColor(.appBrown)
                    .fontWeight(.bold)
                    .font(.system(size: 18))
                
                Text("Alerts On")
                    .foregroundColor(Color(uiColor: .darkGray))
                    .fontWeight(.semibold)
                    .font(.system(size: 16))
                
                HStack {
                    ForEach(0 ..< 4, id: \.self) { i in
                        
                        alertIcon(imageName: icons[i])
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 10)
            }
            .modifier(ActivitiOptionsModifier(height: 120))
        }
    }
    
    private func alertIcon(imageName: String) -> some View {
        Button {
            
        } label: {
            Image(systemName: imageName)
                .resizable()
                .scaledToFit()
                .foregroundColor(Color(uiColor: .darkGray))
        }
    }
    
    private var header: some View {
        HStack {
            Text("Alert")
                .fontWeight(.semibold)
        }
    }
}

// MARK: - NotificationsView

struct NotificationsView: View {
    
    var notifications: [Notification]
    
    var body: some View {
        VStack(alignment: .leading) {
            header
            
            VStack(spacing: 2) {
                
                Spacer()
                
                Text("\(notifications.count)")
                    .foregroundColor(.appBrown)
                    .fontWeight(.bold)
                    .font(.system(size: 18))
                
                Text("Messages")
                    .foregroundColor(.gray)
                    .fontWeight(.semibold)
                    .font(.system(size: 16))
                
                Spacer()
                
                Text("Last: Open Recall...")
                    .lineLimit(1)
                    .foregroundColor(.gray)
                    .fontWeight(.bold)
                    .font(.system(size: 12))
            }
            .modifier(ActivitiOptionsModifier(height: 120))
        }
    }
    
    private var header: some View {
        HStack {
            Text("Notificationc")
                .fontWeight(.semibold)
        }
    }
}
