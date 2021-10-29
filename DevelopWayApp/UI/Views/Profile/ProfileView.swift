//
//  ProfileView.swift
//  DevelopWayApp
//
//  Created by Diana Sargsyan on 17.10.21.
//

import SwiftUI

struct ProfileView: View {
    
    @ObservedObject var model: ProfileModel
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var showGraficView: Bool = false
    
    var body: some View {
        ZStack {
            Color.darkBlue
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                
                profileImage
                
                infoView
                
                Spacer()
                
                graphicView
                
                logoutView
            }
            .padding(.horizontal)
        }
        .navigationBarBackButtonHidden(true)
    }
    
    private var profileImage: some View {
        VStack {
            if let image = model.profileImage {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 80, height: 80, alignment: .center)
                    .cornerRadius(40)
                    .overlay(
                        RoundedRectangle(cornerRadius: 40)
                            .stroke(Color.neoCyan, lineWidth: 2))
            } else {
                Image(systemName: "person.circle")
                    .font(.system(size: 75, weight: .thin))
            }
        }
        .foregroundColor(.inertBlue)
        .padding(.bottom, 40)
    }
    
    private var infoView: some View {
        VStack(spacing: 15) {
            nameView
            
            emailView
            
            birthdayView
            
            genderView
        }
    }
    
    private var emailView: some View {
        HStack{
            Text("\(model.user.email)")
            
            Spacer()
        }
        .modifier(TitleTextModifier(title: "Email: "))
        .modifier(TextFieldWithIcon(imageName: "envelope"))
        
    }
    
    private var nameView: some View {
        HStack {
            Text("\(model.user.name)")
            
            Text("\(model.user.surname)")
            
            Spacer()
                
        }
        .foregroundColor(.neoCyan)
        .modifier(TextFieldWithIcon(imageName: "person"))
    }
    
    private var birthdayView: some View {
        HStack{
            Text("\(model.user.birthday)")
            
            Spacer()
        }
        .modifier(TitleTextModifier(title: "Birthday: "))
        .modifier(TextFieldWithIcon(imageName: "calendar"))
        
    }
    
    private var genderView: some View {
        Text("\(model.user.gender.rawValue)")
            .modifier(TitleTextModifier(title: "Gender: "))
            .modifier(RoundedModifier())
    }
    
    private var graphicView: some View {
        Button(action: {
            showGraficView.toggle()
        }) {
            HStack {
                Text("Graphic Charts")
                    .bold()
                    .foregroundColor(.darkBlue)
                
                Image(systemName: "skew")
                    .font(.system(size: 20))
                    .rotationEffect(.degrees(90))
                    .foregroundColor(.darkBlue)
            }
            .padding()
            .background(Color.neoCyan.cornerRadius(8))
            .padding(.bottom, 40)
        }
    }
    
    private var logoutView: some View {
        Button(action: {
            UserManager.sharedInstance.logout()
        }) {
            HStack {
                Text("LOGOUT")
                    .bold()
                    .foregroundColor(.darkBlue)
                
                Image(systemName: "square.and.arrow.up")
                    .font(.system(size: 20))
                    .rotationEffect(.degrees(90))
                    .foregroundColor(.darkBlue)
            }
            .padding()
            .background(Color.neoCyan.cornerRadius(8))
        }
    }
}
