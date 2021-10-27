//
//  UINavigationController + Extensions.swift
//  DevelopWayApp
//
//  Created by Diana Sargsyan on 23.10.21.
//

import Foundation
import UIKit
import SwiftUI

extension UINavigationController {
    // Remove back button text
    open override func viewWillLayoutSubviews() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.neoCyan]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.neoCyan]
        
        navigationBar.tintColor = UIColor.neoCyan
    }
}
