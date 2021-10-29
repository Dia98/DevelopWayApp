//
//  ProfileModel.swift
//  DevelopWayApp
//
//  Created by Diana Sargsyan on 29.10.21.
//

import Foundation
import SwiftUI

class ProfileModel: ObservableObject {
    
    var user: User
    
    var profileImage: UIImage?
    
    init(entity: UserEntity?) {
        if let info = entity {
            self.user = User.init(entity: info)
        } else {
            self.user = User()
        }
        tryGetImage()
    }
    
    func tryGetImage() {
        if let imageURL = user.imageURL, let url = URL(string: imageURL) {
            if FileManager.default.fileExists(atPath: imageURL) {
                do {
                    let data = try Data(contentsOf: url)
                    profileImage = UIImage(data: data)
                }
                catch {
                    //ERROR
                }
            }
        }
    }
}

extension ProfileModel {
    class User {
        let name: String
        let surname: String
        let gender: Gender
        let email: String
        var birthday: String = ""
        let imageURL: String?
        
        let formatter = DateFormatter()
        
        init() {
            self.name = ""
            self.surname = ""
            self.email = ""
            self.gender = Gender.women
            self.imageURL = nil
        }
        
        init(entity: UserEntity) {
            self.name = entity.name ?? ""
            self.surname = entity.surname ?? ""
            self.email = entity.email ?? ""
            self.gender = Gender.init(rawValue: entity.gender ?? "") ?? .women
            self.imageURL = entity.imageURL
            
            formatter.dateFormat = "dd/MM/YYYY"
            if let birthday = entity.birthday {
                self.birthday = formatter.string(from: birthday)
            }
        }
    }
}
