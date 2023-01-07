//
//  TabBarItemProtocol.swift
//  SimplyTechnologiesTest_
//
//  Created by Diana Sargsyan on 20.12.22.
//

import Foundation

public protocol Tabbable: Hashable {
    var icon: String { get }
    var title: String { get }
}
