//
//  UserDetailView.swift
//  Brainstromtech Task
//
//  Created by Diana Sargsyan on 18.08.23.
//

import SwiftUI
import MapKit

struct UserDetailView: View {
    @StateObject private var viewModel: UserDetailViewModel
    
    @Binding var isNavigationBarHidden: Bool
    
    init(user: any User, isNavigationBarHidden: Binding<Bool>) {
        self._viewModel = StateObject(wrappedValue: UserDetailViewModel(user: user))
        self._isNavigationBarHidden = isNavigationBarHidden
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            
            Divider()
            
            ZStack(alignment: .bottom) {
                mapView
                
                images
                    .offset(y: 60)
            }
            
            VStack(spacing: 10) {
                title
                
                description
                
                Spacer()
            
                if viewModel.userIsSaved {
                    removeUseerButtons
                } else {
                    saveUserButton
                }
            }
            .padding(60)
        }
        .navigationBarHidden(isNavigationBarHidden)
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarTitle(viewModel.user.fullName, displayMode: .inline)
        .onAppear{
            isNavigationBarHidden = false
        }
        .onDisappear {
            isNavigationBarHidden = true
        }
    }
    
    private var removeUseerButtons: some View {
        VStack(spacing: 20) {
            ZStack {
                Rectangle()
                  .foregroundColor(.clear)
                  .frame(width: 250, height: 48)
                  .background(
                    LinearGradient(
                      stops: [
                        Gradient.Stop(color: Color(red: 0.91, green: 0.91, blue: 0.91), location: 0.00),
                        Gradient.Stop(color: Color(red: 0.91, green: 0.91, blue: 0.91), location: 1.00),
                      ],
                      startPoint: UnitPoint(x: 0, y: 0.59),
                      endPoint: UnitPoint(x: 1, y: 0.6)
                    )
                  )
                  .cornerRadius(100)
                
                Text("User saved")
                    .font(.sfPro(size: 16).weight(.semibold))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
            }
            
            Button {
                viewModel.buttonAction()
            } label: {
                Text("Remove user")
                    .font(.sfPro(size: 16).weight(.semibold))
                  .multilineTextAlignment(.center)
                  .foregroundColor(Color(red: 0.92, green: 0.34, blue: 0.34))
            }
        }
    }
    
    private var saveUserButton: some View {
        Button {
            viewModel.buttonAction()
        } label: {
            ZStack {
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 250, height: 48)
                    .background(
                        LinearGradient(
                            stops: [
                                Gradient.Stop(color: Color(red: 0.07, green: 0.89, blue: 0.49), location: 0.00),
                                Gradient.Stop(color: Color(red: 0.07, green: 0.79, blue: 0.43), location: 1.00),
                            ],
                            startPoint: UnitPoint(x: 0, y: 0.59),
                            endPoint: UnitPoint(x: 1, y: 0.6)
                        )
                    )
                    .cornerRadius(100)
                
                Text("Save user")
                    .font(.sfPro(size: 16).weight(.semibold))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
            }
        }
    }
    
    private var description: some View {
        Text("\(viewModel.user.gender), \(viewModel.user.phone) \n \(viewModel.user.address)")
            .font(.sfPro(size: 12))
            .multilineTextAlignment(.center)
            .foregroundColor(.seconderyColor)
    }
    
    private var mapView: some View {
        Map(coordinateRegion: $viewModel.mapRegion, annotationItems: [viewModel.location]) { item in
            
            MapAnnotation(coordinate: item.coordinates) {
                mapMarker
            }
        }
        .frame(height: 200)
    }
    
    private var mapMarker: some View {
        Image.mapMarkerFill
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 40, height: 40)
            .onTapGesture {
                print("do something")
            }
    }
    
    private var title: some View {
        Text(viewModel.user.fullName)
            .font(.sfPro(size: 20))
    }
    
    private var images: some View {
        VStack {
            if let mediaDataURL = URL(string: viewModel.user.pictureUrl) {
                AsyncImage(
                    url: mediaDataURL,
                    placeholder: {
                        ProgressView()
                    },
                    image: {
                        Image(uiImage: $0)
                            .resizable()
                            .renderingMode(.original)
                    }
                )
                .frame(width: 120, height: 120)
                .overlay(
                    RoundedRectangle(cornerRadius: 60)
                        .stroke(.white, lineWidth: 3)
                )
                .cornerRadius(60)
                
            } else {
                Spacer()
                ProgressView()
                Spacer()
            }
        }
    }
}

struct UserDetailView_Previews: PreviewProvider {
    static var previews: some View {
        UserDetailView(user: Result(gender: "female", name: Name(title: "Mademoiselle", first: "Margot", last: "Morin"), location: Location(street: Street(number: 860, name: "Rue Bony"), city: "Kirchberg (Sg)", state: "Appenzell Ausserrhoden", country: "Switzerland", postcode: Postcode.integer(4156), coordinates: Coordinates(latitude: "45.9842", longitude: "40.2747"), timezone: Timezone(offset: "+9:00", description: "Tokyo, Seoul, Osaka, Sapporo, Yakutsk")), email: "margot.morin@example.com", login: nil, dob: nil, registered: nil, phone: "077 846 33 29", cell: "079 231 83 04", id: ID(name: "AVS", value: "756.8810.8881.96"), picture: Picture(large: "https://randomuser.me/api/portraits/women/20.jpg", medium: "https://randomuser.me/api/portraits/med/women/20.jpg", thumbnail: "https://randomuser.me/api/portraits/thumb/women/20.jpg"), nat: nil), isNavigationBarHidden: .constant(false))
    }
}
