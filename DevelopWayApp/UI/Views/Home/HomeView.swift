//
//  HomeView.swift
//  DevelopWayApp
//
//  Created by Diana Sargsyan on 17.10.21.
//

import SwiftUI

struct HomeView: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    
    @State private var loginto: Bool = false
    
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
        
    }
    
    var loginView: some View {
        VStack {
            HStack {
                Image(systemName: "envelope")
                    .font(.system(size: 20))
                    .foregroundColor(.inertBlue)
                
                TextField("", text: $email)
                    .placeholder(when: email.isEmpty) {
                            Text("Email").foregroundColor(.inertBlue)
                    }
                    .foregroundColor(.neoCyan)
            }
            .modifier(RoundedModifier())
            
            HStack {
                Image(systemName: "key.fill")
                    .font(.system(size: 20))
                    .foregroundColor(.inertBlue)
                    .padding(.trailing, 8)
                
                TextField("", text: $password)
                    .placeholder(when: password.isEmpty) {
                            Text("Password").foregroundColor(.inertBlue)
                    }
                    .foregroundColor(.neoCyan)
            }
            .modifier(RoundedModifier())
            
            NavigationLink(
                destination: ProfileView(),
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
        loginto.toggle()
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
