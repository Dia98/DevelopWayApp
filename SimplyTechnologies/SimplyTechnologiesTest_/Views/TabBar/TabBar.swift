//
//  TabBar.swift
//  SimplyTechnologiesTest_
//
//  Created by Diana Sargsyan on 20.12.22.
//

import SwiftUI

public struct TabBar<TabItem: Tabbable, Content: View>: View {
    
    @State private var items: [TabItem]
    
    private let selectedItem: TabBarSelection<TabItem>
    
    private let tabItemStyle : AnyTabItemStyle
    private let tabBarStyle  : AnyTabBarStyle
    
    private let content: Content
    
    private init<ItemStyle: TabItemStyle, BarStyle: TabBarStyle>(
        tabItemStyle : ItemStyle,
        tabBarStyle  : BarStyle,
        selection    : Binding<TabItem>,
        @ViewBuilder content: () -> Content
    ) {
        self.selectedItem = .init(selection: selection)
        
        self.tabItemStyle = .init(itemStyle: tabItemStyle)
        self.tabBarStyle  = .init(barStyle: tabBarStyle)
        
        self.content = content()
        
        self._items = .init(initialValue: .init())
    }
    
    public init(selection: Binding<TabItem>, @ViewBuilder content: () -> Content) {
        self.init(
            tabItemStyle : DefaultTabItemStyle(),
            tabBarStyle  : DefaultTabBarStyle(),
            selection    : selection,
            content      : content
        )
    }
    
    private var tabItems: some View {
        HStack {
            ForEach(self.items, id: \.self) { item in
                self.tabItemStyle.tabItem(icon: item.icon, title: item.title, isSelected: self.selectedItem.selection == item)
                    .onTapGesture { [item] in
                        self.selectedItem.selection = item
                        self.selectedItem.objectWillChange.send()
                    }
            }
            .frame(maxWidth: .infinity)
        }
    }
    
    public var body: some View {
        ZStack {
            self.content
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .environmentObject(self.selectedItem)
            
            GeometryReader { geometry in
                VStack {
                    Spacer()
                    
                    self.tabBarStyle.tabBar(with: geometry) {
                        .init(self.tabItems)
                    }
                }
                .edgesIgnoringSafeArea(.bottom)
            }
        }
        .onPreferenceChange(TabBarPreferenceKey.self) { value in
            self.items = value
        }
    }
    
}

extension TabBar {
    
    public func tabItem<ItemStyle: TabItemStyle>(style: ItemStyle) -> Self {
        return .init(
            tabItemStyle : style,
            tabBarStyle  : self.tabBarStyle,
            selection    : self.selectedItem.$selection,
            content      : { self.content }
        )
    }
    
    public func tabBar<BarStyle: TabBarStyle>(style: BarStyle) -> Self {
        return .init(
            tabItemStyle : self.tabItemStyle,
            tabBarStyle  : style,
            selection    : self.selectedItem.$selection,
            content      : { self.content }
        )
    }
}

