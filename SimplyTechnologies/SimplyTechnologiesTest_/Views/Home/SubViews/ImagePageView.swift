//
//  ImagePageView.swift
//  SimplyTechnologiesTest_
//
//  Created by Diana Sargsyan on 21.12.22.
//

import SwiftUI

struct ImagePageView: View {
    
    @State var selectedItem = 0
    let imagesCount: Int = 4
    
    var body: some View {
        VStack {
            TabView(selection: $selectedItem) {
                ForEach(0 ..< imagesCount, id: \.self) { i in
                    ZStack {
                        Image(i % 2 == 0 ? "car_photo" : "car_photo_2")
                            .resizable()
                        
                    }.clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
                }
                .padding(.all, 10)
            }
            .frame(width: UIScreen.main.bounds.width - 40, height: 200)
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            
            HStack(spacing: 2) {
                Spacer()
                
                ForEach(0 ..< imagesCount, id: \.self) { i in
                    Rectangle()
                        .frame(height: 2)
                        .frame(maxWidth: 20)
                        .foregroundColor(selectedItem == i ? .appBrown : .gray.opacity(0.5))
                        .onTapGesture {
                            selectedItem = i
                        }
                }
                Text("+")
                    .foregroundColor(.gray.opacity(0.5))
                    .fontWeight(.semibold)
                    .offset(y: -1)
                
                Spacer()
            }
        }
    }
}
