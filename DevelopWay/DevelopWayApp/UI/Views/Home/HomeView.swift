//
//  HomeView.swift
//  DevelopWayApp
//
//  Created by Diana Sargsyan on 17.10.21.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject private var model: HomeViewModel = HomeViewModel()
    
    @State private var loginto: Bool = false
    @State private var alert: AlertItem?
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.darkBlue
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Spacer()
                    
                    loginView
                    
                    Spacer()
                    
                    createNewView
                }
                .padding(.horizontal)
            }
        }
        .setupAlert($alert)
    }
    
    var loginView: some View {
        VStack {
            HStack {
                Image(systemName: "envelope")
                    .font(.system(size: 20))
                    .foregroundColor(.inertBlue)
                
                TextField("", text: $model.email)
                    .placeholder(when: model.email.isEmpty) {
                        Text("Email").foregroundColor(.inertBlue)
                    }
                    .modifier(EmailModifier())
                    .foregroundColor(.neoCyan)
            }
            .modifier(RoundedModifier())
            
            HStack {
                Image(systemName: "key.fill")
                    .font(.system(size: 20))
                    .foregroundColor(.inertBlue)
                    .padding(.trailing, 8)
                
                SecureInputView("", text: $model.password)
                    .placeholder(when: model.password.isEmpty) {
                        Text("Password").foregroundColor(.inertBlue)
                    }
                    .foregroundColor(.neoCyan)
            }
            .modifier(RoundedModifier())
            
            NavigationLink(
                destination: ProfileView(model: model.profileModel),
                isActive: $loginto,
                label: {
                    HStack {
                        Spacer()
                        
                        Text("Login")
                            .bold()
                            .foregroundColor(.white)
                            .padding(.horizontal, 40)
                            .modifier(RoundedFillModifier())
                            .onTapGesture {
                                checkForLogin()
                            }
                        
                        Spacer()
                    }
                })
                .padding(.vertical)
        }
    }
    
    private func checkForLogin() {
        UserManager.sharedInstance.login(email: model.email, password: model.password) { errorText in
            alert = AlertItem(message: errorText)
        } success: {
            if let user = UserManager.sharedInstance.getCurrentUser(){
                model.profileModel = ProfileModel.init(entity: user)
                loginto.toggle()
            }
        }
    }
    
    var createNewView: some View {
        VStack(spacing: 20) {
            Text("DON'T HAVE ACCOUNT?")
                .bold()
                .foregroundColor(.inertBlue)
            
            NavigationLink(
                destination: CreateAccountView(),
                label: {
                    Text("Sign up")
                        .bold()
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                })
        }
        .padding(.vertical)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
