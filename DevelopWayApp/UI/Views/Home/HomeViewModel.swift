//
//  HomeViewModel.swift
//  DevelopWayApp
//
//  Created by Diana Sargsyan on 29.10.21.
//

import Foundation
import SwiftUI

class HomeViewModel: ObservableObject {
    
    @Published var email: String = ""
    @Published var password: String = ""
    
    @Published var profileModel: ProfileModel = ProfileModel.init(entity: nil)
}
