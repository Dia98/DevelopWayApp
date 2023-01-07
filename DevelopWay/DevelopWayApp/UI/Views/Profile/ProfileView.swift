//
//  ProfileView.swift
//  DevelopWayApp
//
//  Created by Diana Sargsyan on 17.10.21.
//

import SwiftUI
import SwiftUICharts

struct ProfileView: View {
    
    @ObservedObject var model: ProfileModel
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var displayGraficView: Bool = false
    
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
            
            if displayGraficView {
                GeometryReader{ _ in
                    chartView
                        .padding(.vertical)
                        .background(Color.white.cornerRadius(8))
                        .padding(.horizontal)
                        .padding(.vertical, 150)
                }.background(
                    Color.black.opacity(0.65)
                        .edgesIgnoringSafeArea(.all)
                        .onTapGesture {
                            displayGraficView = false
                        }
                )
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    
    
    private var chartView: some View {
        RangedBarChart(chartData: model.chartData)
            .touchOverlay(chartData: model.chartData, specifier: "%.0f", unit: .suffix(of: "ID"))
            .xAxisGrid(chartData: model.chartData)
            .yAxisGrid(chartData: model.chartData)
            .xAxisLabels(chartData: model.chartData)
            .yAxisLabels(chartData: model.chartData)
            .infoBox(chartData: model.chartData)
            .headerBox(chartData: model.chartData)
            .legends(chartData: model.chartData, columns: [GridItem(.flexible()), GridItem(.flexible())])
            .id(model.chartData.id)
            .frame(minWidth: 150, maxWidth: 900, minHeight: 150, idealHeight: 500, maxHeight: 600, alignment: .center)
            .padding(.horizontal)
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
            displayGraficView.toggle()
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
    
//    func randomEntries() -> [ChartDataEntry] {
//        var entries = [ChartDataEntry]()
//        guard model.chartInfo.count > 0 else {
//            return []
//        }
//        let formatter = DateFormatter()
//        entries = model.chartInfo.compactMap({ item in
//
//            formatter.dateFormat = " dd/MM"
//            var x = ""
//            if let birthday = item.createdDate {
//                x = formatter.string(from: birthday)
//            }
//
//            return ChartDataEntry(x: x, y: Double(item.id))
//        })
//        return entries
//    }
    
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
