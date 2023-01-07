//
//  TabBarSelection.swift
//  SimplyTechnologiesTest_
//
//  Created by Diana Sargsyan on 20.12.22.
//

import SwiftUI

public class TabBarSelection<TabItem: Tabbable>: ObservableObject {
    
    @Binding public var selection: TabItem
    
    public init(selection: Binding<TabItem>) {
        self._selection = selection
    }
}
