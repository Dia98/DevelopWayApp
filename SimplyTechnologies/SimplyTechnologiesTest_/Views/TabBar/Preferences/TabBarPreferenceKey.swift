//
//  TabBarPreferenceKey.swift
//  SimplyTechnologiesTest_
//
//  Created by Diana Sargsyan on 20.12.22.
//

import SwiftUI

public struct TabBarPreferenceKey<TabItem: Tabbable>: PreferenceKey {
    
    public static var defaultValue: [TabItem] {
        return .init()
    }
    
    public static func reduce(value: inout [TabItem], nextValue: () -> [TabItem]) {
        value.append(contentsOf: nextValue())
    }
}
