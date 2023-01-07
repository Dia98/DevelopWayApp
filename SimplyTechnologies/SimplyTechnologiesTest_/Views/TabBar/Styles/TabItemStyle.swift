//
//  TabItemStyle.swift
//  SimplyTechnologiesTest_
//
//  Created by Diana Sargsyan on 20.12.22.
//

import SwiftUI

public protocol TabItemStyle {
    associatedtype Content  : View
    
    func tabItem(icon: String, title: String, isSelected: Bool) -> Content
}

extension TabItemStyle {
    
    public func tabItemErased(icon: String, title: String, isSelected: Bool) -> AnyView {
        return .init(self.tabItem(icon: icon, title: title, isSelected: isSelected))
    }
    
}

public struct AnyTabItemStyle: TabItemStyle {
    
    private let _makeTabItem: (String, String, Bool) -> AnyView
    
    public init<TabItem: TabItemStyle>(itemStyle: TabItem) {
        self._makeTabItem = itemStyle.tabItemErased(icon:title:isSelected:)
    }
    
    public func tabItem(icon: String, title: String, isSelected: Bool) -> some View {
        return self._makeTabItem(icon, title, isSelected)
    }
}

public struct DefaultTabItemStyle: TabItemStyle {
    
    @ViewBuilder
    public func tabItem(icon: String, title: String, isSelected: Bool) -> some View {
        let color: Color = isSelected ? .accentColor : .gray
        
        VStack(spacing: 5.0) {
            Image(icon)
                .renderingMode(.template)
            
            Text(title)
                .font(.system(size: 10.0, weight: .medium))
        }
        .foregroundColor(color)
    }
    
}

struct CustomTabItemStyle: TabItemStyle {
    
    public func tabItem(icon: String, title: String, isSelected: Bool) -> some View {
        VStack {
            Rectangle()
                .maskedForeground(color: isSelected ? .appBrown : .white)
                .frame(width: (UIScreen.main.bounds.width / 4) - 5, height: 3.0)
            
            Spacer()
            
            Image(icon)
                .maskedForeground(color: isSelected ? .appBrown : .black)
                .foregroundColor(isSelected ? .white : .gray)
                .frame(width: 35.0, height: 35.0)
            
            Text(title)
                .font(.system(size: 10.0, weight: .medium))
                .foregroundColor(isSelected ? .appBrown : .black)
        }
        .padding(.top, 8.0)
    }
}
