//
//  UsersListView.swift
//  Brainstromtech Task
//
//  Created by Diana Sargsyan on 18.08.23.
//

import SwiftUI

struct UsersListView: View {
    
    @StateObject private var viewModel = UsersListViewModel()
    
    @State private var searchText = ""
    
    @State var isNavigationBarHidden: Bool = true
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                headerView
                
                Divider()
                
                listView
            }
        }
        .searchable(text: $searchText)
        .toolbar(.hidden, for: .navigationBar)
        .navigationBarHidden(isNavigationBarHidden)
        .navigationTitle("")
        .onAppear {
            isNavigationBarHidden = false
        }
        .onChange(of: isNavigationBarHidden) { _ in
            viewModel.getSavedUsers()
        }
    }
    
    private var headerView: some View {
        Picker("", selection: $viewModel.segmentationSelection) {
            ForEach(viewModel.listOptions, id: \.self) { option in
                
                Text(option.title)
                    .foregroundColor(viewModel.segmentationSelection == option ? .primary : .secondary)
            }
        }.pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)
            .padding(.bottom, 10)
            .background(Color(hex: "#F9F9F9F0"))
    }
    
    
    private var listView: some View {
        ZStack {
            switch viewModel.segmentationSelection {
            case .receiving:
                remotUserList
            case .saved:
                sevedUserList
            }
            
            if viewModel.currentUsers.count == 0 {
                Text("List is empty")
            }
        }
    }
    
    private var remotUserList: some View {
        List(remotUsers().enumerated().map({ $0 }), id: \.element.identifier) { index, user in
            NavigationLink {
                UserDetailView(user: user, isNavigationBarHidden: $isNavigationBarHidden)
            } label: {
                Item(user: user)
                    .onAppear { viewModel.requestMoreItemsIfNeeded(index: index) }
            }
        }
        .listStyle(PlainListStyle())
        .overlay {
                        // 4
                        if viewModel.dataIsLoading {
                            ProgressView()
                        }
                    }
    }
    
    private var sevedUserList: some View {
        List(savedUsers(), id: \.identifier) { user in
            NavigationLink {
                UserDetailView(user: user, isNavigationBarHidden: $isNavigationBarHidden)
            } label: {
                Item(user: user)
            }
        }
        .listStyle(PlainListStyle())
    }
    
    func remotUsers() -> [Result] {
        if searchText.isEmpty {
            return viewModel.currentUsers
        } else {
            return viewModel.currentUsers.filter { $0.fullName.contains(searchText) }
        }
    }
    
    func savedUsers() -> [SavedUserModel] {
        if searchText.isEmpty {
            return viewModel.savedUsers
        } else {
            return viewModel.savedUsers.filter { $0.fullName.contains(searchText) }
        }
    }
}

private extension UsersListView {
    struct Item: View {
        
        var user: any User
        
        var body: some View {
            HStack(spacing: 12) {
                image
                
                info
                
                Spacer()
            }
        }
        
        private var info: some View {
            VStack(alignment: .leading) {
                Spacer()
                
                Text(user.fullName)
                    .font(.sfPro(size: 15))
                  .foregroundColor(.black)
                
                Text("\(user.gender), \(user.phone) \n \(user.address)")
                    .font(.sfPro(size: 12))
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.seconderyColor)
                
                Spacer()
            }
        }
        
        private var image: some View {
            VStack {
                if let mediaDataURL = URL(string: user.pictureUrl) {
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
                    .cornerRadius(4)
                    .frame(width: 70, height: 70)
                    
                } else {
                    Spacer()
                    ProgressView()
                    Spacer()
                }
            }
        }
    }
}

struct UsersListView_Previews: PreviewProvider {
    static var previews: some View {
        UsersListView()
//        UsersListView.Item(user: Result(gender: "female", name: Name(title: "Mademoiselle", first: "Margot", last: "Morin"), location: Location(street: Street(number: 860, name: "Rue Bony"), city: "Kirchberg (Sg)", state: "Appenzell Ausserrhoden", country: "Switzerland", postcode: Postcode.integer(4156), coordinates: Coordinates(latitude: "45.9842", longitude: "40.2747"), timezone: Timezone(offset: "+9:00", description: "Tokyo, Seoul, Osaka, Sapporo, Yakutsk")), email: "margot.morin@example.com", login: nil, dob: nil, registered: nil, phone: "077 846 33 29", cell: "079 231 83 04", id: ID(name: "AVS", value: "756.8810.8881.96"), picture: Picture(large: "https://randomuser.me/api/portraits/women/20.jpg", medium: "https://randomuser.me/api/portraits/med/women/20.jpg", thumbnail: "https://randomuser.me/api/portraits/thumb/women/20.jpg"), nat: nil))
    }
}
