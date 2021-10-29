//
//  UserManager.swift
//  DevelopWayApp
//
//  Created by Diana Sargsyan on 28.10.21.
//

import Foundation
class UserManager : NSObject {
    
    public static let keyString: String = "DevelopWayApp.currentUserEmail"
    
    class var sharedInstance : UserManager {
        struct Singleton {
            static let instance = UserManager()
        }
        return Singleton.instance
    }
    
    func login(email: String, password: String, error: (String) -> (), success: () -> ()) {
        if let user = CoreDataManager.sharedManager.fetchUserByEmail(email) {
            if user.password == password {
                saveLoggedUser(user)
                success()
                return
            } else {
                error("The password you’ve entered is incorrect.")
                return
            }
        } else {
            error("The email you entered isn’t connected to an account.")
            return
        }
    }
    
    func logout() {
        delete()
    }
    
    func getCurrentUser() -> UserEntity? {
        if let email = UserDefaults.standard.string(forKey: UserManager.keyString) {
            return CoreDataManager.sharedManager.fetchUserByEmail(email)
        }
        return nil
    }
    
    private func saveLoggedUser(_ user: UserEntity) {
        UserDefaults.standard.set(user.email, forKey: UserManager.keyString)
        UserDefaults.standard.synchronize()
    }
    
    func saveNewUser(_ user: RegisteredInfo) {
        CoreDataManager.sharedManager.saveCurrentUser(user)
        UserDefaults.standard.set(user.email, forKey: UserManager.keyString)
        UserDefaults.standard.synchronize()
    }
    
    private func delete() {
        UserDefaults.standard.set(nil, forKey: UserManager.keyString)
        UserDefaults.standard.synchronize()
        NotificationCenter.default.post(name: NSNotification.Name.activeUserDidChanged, object: nil)
    }
}
