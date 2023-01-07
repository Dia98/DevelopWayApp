//
//  CreateAccountModel.swift
//  DevelopWayApp
//
//  Created by Diana Sargsyan on 19.10.21.
//

import Foundation
import SwiftUI

class CreateAccountModel: ObservableObject {
    
    @Published var user: RegisteredInfo = RegisteredInfo()
    
    @Published var selectedProfileImage: UIImage?
    
    @Published var showImageSheet: Bool = false
    @Published var isPresentingImagePicker: Bool = false
    
    @Published var profileModel: ProfileModel = ProfileModel.init(entity: nil)
    
    func didSelectImage(_ uiimage: UIImage?, _ url: URL?) {
        if let image = uiimage {
            selectedProfileImage = image
            user.imageUrl = url?.absoluteString
        }
    }
    
    func validate(error: (String) -> (), success: () -> ()){
        guard user.email.isValidEmail else {
            error("Email is not valid.")
            return
        }
        
        guard !user.name.isEmpty else {
            error("Name label is not entered.")
            return
        }
        guard !user.surname.isEmpty else {
            error("Surname is not entered")
            return
        }
        
        guard user.password.isValidPassword else {
            error("Password is not valid. Your password shoud contain 8 cherecters, A-Z,a-z,0-9, .!")
            return
        }
        
        guard user.password == user.repassword else {
            error("Password and Re-password don't metch.")
            return
        }
        
        guard user.gender != nil else {
            error("Select gender!.")
            return
        }
        
        if let _ = CoreDataManager.sharedManager.fetchUserByEmail(user.email) {
            error("Email already exists")
            return
        }
        
        saveUser()
        success()
        return
    }
    
    private func saveUser() {
        generateUserID()
        UserManager.sharedInstance.saveNewUser(user)
    }
    
    private func generateUserID() {
        if let users = CoreDataManager.sharedManager.getUsers() {
            var array: [Int] {
                users.compactMap { item in
                    Int(item.id)
                }
            }
            
            var uniqueId: Int?
            while uniqueId == nil {
                let randomInt = Int.random(in: 0...100)
                
                guard !array.contains(randomInt) else { continue }
                uniqueId = randomInt
            }
            
            if let id = uniqueId {
                user.id = id
            }
        }
    }
}

