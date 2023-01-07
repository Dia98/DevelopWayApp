//
//  TabBarStyle.swift
//  SimplyTechnologiesTest_
//
//  Created by Diana Sargsyan on 20.12.22.
//

import SwiftUI

public protocol TabBarStyle {
    associatedtype Content: View
    
    func tabBar(with geometry: GeometryProxy, itemsContainer: @escaping () -> AnyView) -> Content
}

extension TabBarStyle {
    
    public func tabBarErased(with geometry: GeometryProxy, itemsContainer: @escaping () -> AnyView) -> AnyView {
        return .init(self.tabBar(with: geometry, itemsContainer: itemsContainer))
    }
}

public struct DefaultTabBarStyle: TabBarStyle {
    
    public func tabBar(with geometry: GeometryProxy, itemsContainer: @escaping () -> AnyView) -> some View {
        VStack(spacing: 0.0) {
            
            VStack {
                itemsContainer()
                    .frame(height: 50.0)
                    .padding(.bottom, geometry.safeAreaInsets.bottom)
            }
            .background(
                Color.green
            )
            .frame(height: 50.0 + geometry.safeAreaInsets.bottom)
        }
    }
    
}

public struct AnyTabBarStyle: TabBarStyle {
    
    private let _makeTabBar: (GeometryProxy, @escaping () -> AnyView) -> AnyView
    
    public init<BarStyle: TabBarStyle>(barStyle: BarStyle) {
        self._makeTabBar = barStyle.tabBarErased
    }
    
    public func tabBar(with geometry: GeometryProxy, itemsContainer: @escaping () -> AnyView) -> some View {
        return self._makeTabBar(geometry, itemsContainer)
    }
}

struct CustomTabBarStyle: TabBarStyle {
    
    public func tabBar(with geometry: GeometryProxy, itemsContainer: @escaping () -> AnyView) -> some View {
        itemsContainer()
//            .cornerRadius(25.0)
            .frame(height: 58.0)
//            .padding(.horizontal, 64.0)
            .padding(.bottom, geometry.safeAreaInsets.bottom)
            .background(Color.white)
    }
    
}
