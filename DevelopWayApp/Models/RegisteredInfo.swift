//
//  RegisteredInfo.swift
//  DevelopWayApp
//
//  Created by Diana Sargsyan on 16.10.21.
//

import Foundation
import SwiftUI

class RegisteredInfo: ObservableObject {
    
    @Published var name: String
    @Published var surname: String
    @Published var gender: Gender?
    @Published var email: String
    @Published var password: String
    @Published var repassword: String
    @Published var birthday: Date {
        didSet {
            birthdayFlag = true
        }
    }
    
    @Published var imageUrl: String?
    @Published var image: UIImage?
    @Published var id: Int = 0
    var createdDate: Date?
    
    var birthdayFlag = false
    
    init(name: String, surname: String, gender: Gender?, birthday: Date, email: String ,password: String, repassword: String) {
        
        self.name = name
        self.surname = surname
        self.gender = gender
        self.birthday = birthday
        self.email = email
        self.password = password
        self.repassword = repassword
        
        createdDate = Date()
    }
    
    convenience init() {
        self.init(name: "", surname: "", gender: nil, birthday: Date(), email: "" ,password: "", repassword: "")
    }
    
    func createUniqueId() -> Int {
        return Int.random(in: 0...100)
    }
    
}
