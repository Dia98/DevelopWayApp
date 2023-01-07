//
//  TabBarViewModifier.swift
//  SimplyTechnologiesTest_
//
//  Created by Diana Sargsyan on 20.12.22.
//

import SwiftUI

public struct TabBarViewModifier<TabItem: Tabbable>: ViewModifier {
    
    @EnvironmentObject private var selectionObject: TabBarSelection<TabItem>
    
    public let item: TabItem
    
    public func body(content: Content) -> some View {
        Group {
            if self.item == self.selectionObject.selection {
                content
            } else {
                Color.clear
            }
        }
        .preference(key: TabBarPreferenceKey.self, value: [self.item])
    }
}

extension View {
    
    public func tabItem<TabItem: Tabbable>(for item: TabItem) -> some View {
        return self.modifier(TabBarViewModifier(item: item))
    }
    
}
